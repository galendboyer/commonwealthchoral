# Keeping a Google Group's Roster Up to Date

This is what to do to update who's in a group (like `basses@...` or
`member@...`) whenever your Donor Snap list changes. Everything happens
in your browser — no software to install.

## What you'll need

- The Google Sheet link for this group (ask whoever set this up for you,
  if you don't have it).
- A fresh member list exported from Donor Snap.

## Steps

1. **Export the list from Donor Snap** as you normally would, to Excel
   (`.xlsx`) or CSV — either works.

2. **Open the Google Sheet** in your browser.

3. **Upload it:** click the **Group Sync** menu at the top, then
   **Upload Roster File...**. Choose the file you just exported and
   click **Import Roster**. You'll get a message saying how many rows
   were imported.

4. **Preview the changes:** click **Group Sync → Preview Changes**.
   This does *not* change anything yet — it just shows what *would*
   happen. Click over to the **Log** tab at the bottom to read it:
   - **WILL ADD** — people about to be added to the group
   - **WILL REMOVE** — people about to be taken off the group (because
     they weren't in the file you uploaded)
   - **WILL UPDATE ROLE** — people whose role is changing

   Read the "WILL REMOVE" list carefully — anyone not in your uploaded
   file gets removed. If something looks wrong (a name missing that
   should be there, a lot more removals than expected), stop and check
   your Donor Snap export before continuing.

5. **Run it for real:** click **Group Sync → Run Sync**. It will ask you
   to confirm a count of adds/removes/updates — check the numbers match
   what you saw in Preview, then confirm.

6. **Check the result:** the **Log** tab updates with a line for every
   person added, removed, or updated, and flags anything that failed
   (usually a typo'd email address).

That's it — repeat this any time your Donor Snap list changes.

## A few things worth knowing

- People don't need a Gmail address to be in the group — any email
  address works.
- The upload always replaces the whole roster for that group. If
  someone's missing from your export, they'll be removed on the next
  sync — that's how it's meant to work, but it's why Preview matters.
- If a sync fails entirely, or the menu/buttons don't do anything,
  that's a setup issue, not something to troubleshoot yourself — check
  with whoever built this for you.
