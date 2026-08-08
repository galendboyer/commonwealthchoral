# Group Roster Sync — Build & Admin Guide

For whoever is building/maintaining this tool (not the person uploading
rosters day to day — see `GroupSync-UserGuide.md` for that).

## What this is

A Google Sheet + Apps Script tool. A group maintainer uploads the Excel/CSV
export from Donor Snap through a dialog; the script diffs it against the
Google Group's actual membership and adds/removes/updates people to match.
No command line involved for the maintainer — all the setup below is
one-time, done by you.

## One-time build (~15 minutes per group, or per Sheet if you template it)

1. **Create the Sheet.** Go to sheets.new. Name it something like
   "Driscoll Singers – Group Roster" (test domain) — later, one per
   `commonwealthchorale.net` group, or one Sheet reused across groups
   if you're comfortable swapping Config values before each upload.

2. **Create three tabs:**
   - `Config`
   - `Roster` — add a header row: `email` in A1, `role` in B1. The
     upload step overwrites everything below that.
   - `Log` — leave empty; the script creates/fills it automatically.

3. **Get one real Donor Snap export first.** Open it and note the exact
   column header text for:
   - the email column (required)
   - a role or section column, if relevant (optional — e.g. "Voice Part")

4. **Fill in Config**, column B:

   | | A | B |
   |---|---|---|
   | 1 | Group email: | `basses@driscollsingers.net` |
   | 2 | Email column: | exact header from the DS export, e.g. `Email Address` |
   | 3 | Role column (optional): | blank if none — everyone imports as MEMBER |
   | 4 | Filter column (optional): | e.g. `Voice Part` — use if one export covers the whole chorus |
   | 5 | Filter value (optional): | e.g. `Bass` — only rows matching this import |

   Leave rows 4–5 blank for a whole-roster group (`member@...`). Set them
   to pull one section out of a full-chorus export for a section group
   (`basses@...`).

5. **Add the script files.**
   - Menu: `Extensions` → `Apps Script`.
   - Replace the placeholder `myFunction() {}` in `Code.gs` with the
     contents of `GroupSync.gs`.
   - Add a new **HTML** file (the `+` next to "Files"), name it exactly
     `UploadDialog`, paste in `UploadDialog.html`.
   - Add two **Services** (`+` next to "Services" in the left sidebar):
     - **Admin SDK API** — manages group membership.
     - **Drive API** — only needed if maintainers will upload `.xlsx`.
       Skip it if you'll standardize on `.csv` exports from Donor Snap.
   - Save. Name the project anything.

6. **Do the first authorization and test run yourself.**
   - Reload the spreadsheet tab. A **Group Sync** menu appears.
   - Click `Group Sync → Upload Roster File...`, upload a real export,
     and approve the Google authorization prompt when it appears
     (sign in with an account that has the permissions in step 7).
   - Run `Preview Changes` and sanity-check the Log tab before ever
     running a real `Run Sync` against a live group.

7. **Grant the sync-runner's account permission**, in the Google Admin
   console (admin.google.com) for the domain that owns the group. This
   is whoever will click "Run Sync" day to day — often the same
   volunteer who uploads the file.
   - Simplest: that account is a **Super Admin**. Fine for testing on
     `driscollsingers.net`, not something to hand out casually on the
     real domain.
   - Better for production: `Admin roles → Create new role`, grant the
     **Groups** privilege (optionally scoped to specific group types or
     OUs), assign it to that account. They can manage membership without
     holding keys to the whole domain.
   - Either way, the account needs to exist as a user in the same
     Workspace/Cloud Identity account that owns the domain
     (`driscollsingers.net` now, `commonwealthchorale.net` later).

8. **Share the Sheet** with the maintainer (Editor access is enough).
   Hand them `GroupSync-UserGuide.md` — they don't need anything else in
   this document.

## Reuse and scaling notes

- **New group, same Sheet:** change `Config!B1` (and the filter, if any)
  before each upload. Fine for occasional use by one careful person.
- **New group, own Sheet:** duplicate the whole Sheet (File → Make a
  copy), update its Config tab. Cleaner if multiple people maintain
  different groups, since each Sheet's Log/Roster stays independent.
- **Moving from the test domain to production:** once this works
  end-to-end against `driscollsingers.net`, point `Config!B1` at the
  real `commonwealthchorale.net` group address (once that domain is
  routed through Google Groups) — nothing else about the script changes.
- **Debugging:** the Log tab records every add/remove/update attempt,
  including per-row failures (e.g. a malformed email) without aborting
  the rest of the sync. If a whole run fails outright, check that the
  Admin SDK/Drive services are still added and that the signed-in
  account still has Groups admin rights.
- **Security:** the Roster tab, after an upload, is treated as the full
  source of truth — anyone missing from it gets removed on the next
  sync. Encourage maintainers to always run Preview before Run Sync,
  especially early on.
