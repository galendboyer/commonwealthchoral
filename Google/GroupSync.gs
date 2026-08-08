/**
 * GroupSync.gs
 *
 * Browser-only tool for syncing a Google Group's membership against a
 * roster exported from Donor Snap (or anywhere else). No command line,
 * no installs. Upload the export through a dialog, preview the changes,
 * then apply them.
 *
 * Setup:
 *   1. In the Apps Script editor, open Services (+) and add:
 *        - "Admin SDK API"  (manages group membership)
 *        - "Drive API"      (only needed to read uploaded .xlsx files)
 *   2. Make sure the "Config" and "Roster" sheet tabs exist (see README).
 *   3. Add UploadDialog.html as a second file in this Apps Script project.
 *   4. Save, reload the spreadsheet, and use the "Group Sync" menu.
 *
 * Whoever RUNS this (clicks Preview/Sync/Upload) needs a Google Workspace
 * admin role with Groups read/write privileges over the target group -
 * Super Admin works, but a scoped Groups Editor role is safer. See README.
 */

function onOpen() {
  SpreadsheetApp.getUi()
    .createMenu('Group Sync')
    .addItem('Upload Roster File...', 'showUploadDialog')
    .addSeparator()
    .addItem('Preview Changes', 'previewSync')
    .addItem('Run Sync', 'runSync')
    .addToUi();
}

function getConfig() {
  var sheet = SpreadsheetApp.getActive().getSheetByName('Config');
  if (!sheet) throw new Error('No "Config" tab found. See README.');
  var groupEmail = sheet.getRange('B1').getValue().toString().trim();
  if (!groupEmail) throw new Error('Put the group email address in Config tab, cell B1.');
  return { groupEmail: groupEmail };
}

// ---------------------------------------------------------------------------
// Upload dialog: lets someone pick the Excel/CSV file exported from Donor
// Snap and turns it into the Roster tab, using the column mapping in Config.
// ---------------------------------------------------------------------------

function showUploadDialog() {
  var html = HtmlService.createHtmlOutputFromFile('UploadDialog')
    .setWidth(440)
    .setHeight(280);
  SpreadsheetApp.getUi().showModalDialog(html, 'Upload Roster File');
}

/**
 * Config tab layout used for imports (in addition to B1 = group email):
 *   B2 = exact column header for email in the Donor Snap export
 *   B3 = (optional) column header for role (OWNER/MANAGER/MEMBER); blank = everyone MEMBER
 *   B4 = (optional) column header to filter on, e.g. "Voice Part"
 *   B5 = (optional) value that column must equal, e.g. "Bass" - leave B4/B5
 *        blank to import every row (use this for a whole-roster group like member@)
 */
function getImportConfig() {
  var sheet = SpreadsheetApp.getActive().getSheetByName('Config');
  if (!sheet) throw new Error('No "Config" tab found. See README.');
  return {
    emailColumn: (sheet.getRange('B2').getValue() || 'Email').toString().trim(),
    roleColumn: (sheet.getRange('B3').getValue() || '').toString().trim(),
    filterColumn: (sheet.getRange('B4').getValue() || '').toString().trim(),
    filterValue: (sheet.getRange('B5').getValue() || '').toString().trim()
  };
}

/**
 * Called from UploadDialog.html with the file contents (base64) and name.
 * Returns a plain-text summary shown back in the dialog.
 */
function importRosterFile(base64Data, filename) {
  var bytes = Utilities.base64Decode(base64Data);
  var lower = filename.toLowerCase();
  var rows;

  if (lower.endsWith('.csv')) {
    var text = Utilities.newBlob(bytes, 'text/csv', filename).getDataAsString();
    rows = Utilities.parseCsv(text);
  } else if (lower.endsWith('.xlsx') || lower.endsWith('.xls')) {
    rows = parseExcelBytes(bytes, filename);
  } else {
    throw new Error('Please upload a .xlsx or .csv file.');
  }

  if (!rows || rows.length < 2) {
    throw new Error('That file does not seem to have any data rows.');
  }

  var mapped = mapRowsToRoster(rows);
  writeRosterTab(mapped.roster);

  var msg = 'Imported ' + mapped.roster.length + ' of ' + (rows.length - 1) +
    ' row(s) from "' + filename + '" into the Roster tab.';
  if (mapped.skipped.length) {
    msg += ' ' + mapped.skipped.length + ' row(s) were filtered out or had no email.';
  }
  msg += ' Close this dialog, then use Group Sync > Preview Changes.';
  return msg;
}

function parseExcelBytes(bytes, filename) {
  var blob = Utilities.newBlob(bytes, MimeType.MICROSOFT_EXCEL, filename);
  var tempFile = Drive.Files.create(
    { name: 'tmp_roster_import_' + Date.now(), mimeType: MimeType.GOOGLE_SHEETS },
    blob,
    { convert: true }
  );
  try {
    var ss = SpreadsheetApp.openById(tempFile.id);
    var sheet = ss.getSheets()[0];
    return sheet.getDataRange().getValues();
  } finally {
    Drive.Files.remove(tempFile.id);
  }
}

function mapRowsToRoster(rows) {
  var cfg = getImportConfig();
  var headerRow = rows[0].map(function (h) { return h.toString().trim().toLowerCase(); });

  function colIndex(name) {
    if (!name) return -1;
    return headerRow.indexOf(name.toString().trim().toLowerCase());
  }

  var emailIdx = colIndex(cfg.emailColumn);
  if (emailIdx === -1) {
    throw new Error('Could not find a column named "' + cfg.emailColumn +
      '" in the uploaded file. Columns found: ' + rows[0].join(', '));
  }
  var roleIdx = colIndex(cfg.roleColumn);
  var filterIdx = colIndex(cfg.filterColumn);

  var roster = [];
  var skipped = [];
  var validRoles = ['MEMBER', 'MANAGER', 'OWNER'];

  for (var i = 1; i < rows.length; i++) {
    var row = rows[i];
    var email = (row[emailIdx] || '').toString().trim().toLowerCase();
    if (!email) { skipped.push('(row ' + (i + 1) + ': no email)'); continue; }

    if (filterIdx !== -1 && cfg.filterValue) {
      var val = (row[filterIdx] || '').toString().trim().toLowerCase();
      if (val !== cfg.filterValue.toString().trim().toLowerCase()) {
        skipped.push(email + ' (filtered out)');
        continue;
      }
    }

    var role = 'MEMBER';
    if (roleIdx !== -1) {
      var candidate = (row[roleIdx] || '').toString().trim().toUpperCase();
      if (validRoles.indexOf(candidate) !== -1) role = candidate;
    }

    roster.push({ email: email, role: role });
  }

  return { roster: roster, skipped: skipped };
}

function writeRosterTab(rosterRows) {
  var ss = SpreadsheetApp.getActive();
  var sheet = ss.getSheetByName('Roster');
  if (!sheet) sheet = ss.insertSheet('Roster');
  sheet.clear();
  sheet.getRange(1, 1, 1, 2).setValues([['email', 'role']]);
  if (rosterRows.length) {
    var values = rosterRows.map(function (r) { return [r.email, r.role]; });
    sheet.getRange(2, 1, values.length, 2).setValues(values);
  }
}

function getRosterRows() {
  var sheet = SpreadsheetApp.getActive().getSheetByName('Roster');
  if (!sheet) throw new Error('No "Roster" tab found. See README.');
  var data = sheet.getDataRange().getValues();
  var rows = [];
  // Row 1 is the header: email, role
  for (var i = 1; i < data.length; i++) {
    var email = (data[i][0] || '').toString().trim().toLowerCase();
    var role = (data[i][1] || 'MEMBER').toString().trim().toUpperCase();
    if (email) rows.push({ email: email, role: role || 'MEMBER' });
  }
  return rows;
}

function getCurrentMembers(groupEmail) {
  var members = [];
  var pageToken;
  do {
    var resp = AdminDirectory.Members.list(groupEmail, {
      maxResults: 200,
      pageToken: pageToken
    });
    if (resp.members) members = members.concat(resp.members);
    pageToken = resp.nextPageToken;
  } while (pageToken);
  return members;
}

function computeDiff() {
  var groupEmail = getConfig().groupEmail;
  var roster = getRosterRows();
  var current = getCurrentMembers(groupEmail);

  var rosterByEmail = {};
  roster.forEach(function (r) { rosterByEmail[r.email] = r.role; });

  var currentByEmail = {};
  current.forEach(function (m) { currentByEmail[m.email.toLowerCase()] = m; });

  var toAdd = [];
  var toRemove = [];
  var toUpdateRole = [];

  roster.forEach(function (r) {
    var existing = currentByEmail[r.email];
    if (!existing) {
      toAdd.push(r);
    } else if ((existing.role || 'MEMBER').toUpperCase() !== r.role) {
      toUpdateRole.push({ email: r.email, from: existing.role, to: r.role });
    }
  });

  current.forEach(function (m) {
    if (!rosterByEmail.hasOwnProperty(m.email.toLowerCase())) {
      toRemove.push({ email: m.email, role: m.role });
    }
  });

  return {
    groupEmail: groupEmail,
    toAdd: toAdd,
    toRemove: toRemove,
    toUpdateRole: toUpdateRole
  };
}

function writeLog(lines) {
  var ss = SpreadsheetApp.getActive();
  var sheet = ss.getSheetByName('Log');
  if (!sheet) sheet = ss.insertSheet('Log');
  sheet.clear();
  sheet.getRange(1, 1, lines.length, 1).setValues(lines.map(function (l) { return [l]; }));
  ss.setActiveSheet(sheet);
}

function previewSync() {
  var diff = computeDiff();
  var lines = [];
  lines.push('PREVIEW for ' + diff.groupEmail + ' — ' + new Date());
  lines.push('(Nothing has been changed. This is a preview only.)');
  lines.push('');
  lines.push('WILL ADD (' + diff.toAdd.length + '):');
  diff.toAdd.forEach(function (r) { lines.push('  + ' + r.email + ' as ' + r.role); });
  lines.push('');
  lines.push('WILL REMOVE (' + diff.toRemove.length + '):');
  diff.toRemove.forEach(function (r) { lines.push('  - ' + r.email + ' (was ' + r.role + ')'); });
  lines.push('');
  lines.push('WILL UPDATE ROLE (' + diff.toUpdateRole.length + '):');
  diff.toUpdateRole.forEach(function (r) { lines.push('  ~ ' + r.email + ': ' + r.from + ' -> ' + r.to); });
  writeLog(lines);
  SpreadsheetApp.getUi().alert('Preview written to the "Log" tab. Nothing has changed yet.');
}

function runSync() {
  var ui = SpreadsheetApp.getUi();
  var diff = computeDiff();

  var confirm = ui.alert(
    'Confirm sync',
    'This will add ' + diff.toAdd.length + ', remove ' + diff.toRemove.length +
      ', and update the role of ' + diff.toUpdateRole.length +
      ' member(s) in ' + diff.groupEmail + '.\n\nContinue?',
    ui.ButtonSet.YES_NO
  );
  if (confirm !== ui.Button.YES) return;

  var lines = [];
  lines.push('SYNC RESULT for ' + diff.groupEmail + ' — ' + new Date());
  lines.push('');

  diff.toAdd.forEach(function (r) {
    try {
      AdminDirectory.Members.insert({ email: r.email, role: r.role }, diff.groupEmail);
      lines.push('ADDED: ' + r.email + ' as ' + r.role);
    } catch (e) {
      lines.push('FAILED ADD: ' + r.email + ' — ' + e.message);
    }
  });

  diff.toUpdateRole.forEach(function (r) {
    try {
      AdminDirectory.Members.update({ role: r.to }, diff.groupEmail, r.email);
      lines.push('UPDATED ROLE: ' + r.email + ' ' + r.from + ' -> ' + r.to);
    } catch (e) {
      lines.push('FAILED UPDATE: ' + r.email + ' — ' + e.message);
    }
  });

  diff.toRemove.forEach(function (r) {
    try {
      AdminDirectory.Members.remove(diff.groupEmail, r.email);
      lines.push('REMOVED: ' + r.email);
    } catch (e) {
      lines.push('FAILED REMOVE: ' + r.email + ' — ' + e.message);
    }
  });

  writeLog(lines);
  ui.alert('Sync complete. See the "Log" tab for details.');
}
