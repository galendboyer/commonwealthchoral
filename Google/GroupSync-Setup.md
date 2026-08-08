# Group Roster Sync — Setup

A Google Sheet that lets anyone with edit access update a Google Group's
membership straight from a browser — upload the Excel/CSV file exported
from Donor Snap through a dialog, and the sync figures out who to add,
remove, and update. No command line.

Two different roles:
- **Uploader** — anyone you give edit access to the Sheet. They export the
  roster from Donor Snap and upload it through the dialog. No spreadsheet
  editing skill needed.
- **Sync runner** — whoever clicks "Run Sync" needs Google Workspace admin
  rights over Groups (see step 8). Can be the same person or someone else;
  Google will ask that person to sign in and authorize the first time.

## One-time setup (~15 minutes)

1. **Create the Sheet.** Go to sheets.new. Rename it something like
   "Driscoll Singers – Group Roster" (or whichever group you're testing).

2. **Create three tabs** (right-click the tab bar → rename/duplicate):
   - `Config`
   - `Roster`
   - `Log` — leave this empty; the script creates/fills it automatically.

3. **Export one file from Donor Snap first** so you know its real column
   headers (e.g. it might call the email column "Email Address" rather
   than "Email"). Open it and note the exact header text for:
   - the email column (required)
   - a role/section column, if you have one you want to use (optional)

4. **Fill in Config**, column B, using the header text you just found:

   | | A | B |
   |---|---|---|
   | 1 | Group email: | `basses@driscollsingers.net` |
   | 2 | Email column: | `Email Address` *(whatever Donor Snap calls it)* |
   | 3 | Role column (optional): | *(blank if you don't have one — everyone imports as MEMBER)* |
   | 4 | Filter column (optional): | e.g. `Voice Part` — use this if one export covers the whole chorus and you need to pick out just this section |
   | 5 | Filter value (optional): | e.g. `Bass` — only rows where the Filter column equals this get imported |

   For a whole-roster group like `member@...`, leave rows 4–5 blank so
   every row imports. For a section group like `basses@...`, set rows 4–5
   to pick out just that section from the same export.

5. **Add the Roster tab header row** (the import will overwrite the rest):
   `email` in A1, `role` in B1.

6. **Add the script files.**
   - Menu: `Extensions` → `Apps Script`.
   - Delete the placeholder `myFunction() {}` code in `Code.gs`, paste in
     the contents of `GroupSync.gs`.
   - Click the `+` next to "Files" → **HTML**, name it exactly
     `UploadDialog`, and paste in the contents of `UploadDialog.html`.
   - Click the **Services** `+` next to "Files" in the left sidebar and add
     both:
     - **Admin SDK API** (manages group membership)
     - **Drive API** (only used to read uploaded `.xlsx` files — not
       needed if you'll only ever upload `.csv`)
   - Save (Ctrl/Cmd+S). Name the project anything.

7. **Authorize.** Close the Apps Script tab, reload the spreadsheet tab.
   A new **Group Sync** menu appears at the top. Click
   `Group Sync → Upload Roster File...`. The first time, Google will
   interrupt to ask you to authorize — sign in with the account that has
   admin rights (step 8) and approve.

8. **Permissions the sync-runner's account needs**, in the Google Admin
   console (admin.google.com) for the domain that owns the group:
   - Simplest: that account is a **Super Admin**.
   - Better for a volunteer-run choir: create a **custom admin role**
     scoped to just Groups (`Admin roles → Create new role`, grant the
     "Groups" privilege, optionally scoped to only the group types/OUs
     you want them touching), then assign that role to their account.
     This way they can manage group membership without holding the keys
     to the whole domain.
   - Either way, the account must also just be a normal user/admin on
     the **same Workspace/Cloud Identity account that owns the domain**
     the group's on (driscollsingers.net now, commonwealthchorale.net
     later).

## Everyday use

1. In Donor Snap, export the member list to Excel (or CSV) as usual.
2. Open the Sheet in a browser.
3. `Group Sync → Upload Roster File...` — pick the file you just
   exported. This overwrites the **Roster** tab with the (optionally
   filtered) rows from the file. Nothing in the Google Group changes yet.
4. `Group Sync → Preview Changes` — writes what *would* happen to the
   **Log** tab. Check it looks right (nobody unexpected being removed,
   no obviously wrong email counts).
5. `Group Sync → Run Sync` — confirms a count, then actually adds,
   removes, and updates members to match the uploaded file exactly.
6. Check the **Log** tab for a line-by-line result (and any failures,
   e.g. a typo'd email).

## Notes

- People don't need Gmail addresses to be group members — any valid
  email works.
- After an upload, the Roster tab is treated as the full source of
  truth: anyone not in the file gets removed on the next "Run Sync."
  Always Preview first, especially the first few times.
- If Donor Snap's export includes the whole chorus in one file, use the
  Config tab's filter column/value (e.g. `Voice Part` = `Bass`) to pull
  out just one section per group. Leave the filter blank for a
  whole-roster group like `member@...`.
- To reuse this for a different group (e.g. `basses@...` vs
  `member@...`), either change `Config!B1` (and the filter, if any)
  before each upload, or duplicate the whole Sheet once per group so
  each has its own Config.
- Once this is working against `driscollsingers.net`, the same Sheet
  works for `commonwealthchorale.net` groups — just point Config at the
  real group address once that domain is routed through Google Groups.
- The Drive API step (temporary file conversion) is only needed for
  `.xlsx` uploads. If Donor Snap can export `.csv` instead, you can skip
  adding that service entirely.
