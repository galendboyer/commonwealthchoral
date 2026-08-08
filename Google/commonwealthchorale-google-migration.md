# Cutting Over `commonwealthchorale.net` to Google Groups — Live Domain Plan

*Unlike the `driscollsingers.net` test (a domain with nothing on it), `commonwealthchorale.net` is live: existing mail flows through it today via GoDaddy and Constant Contact. This plan is built around **not breaking that** during the transition.*

## The key fact that shapes everything

**MX records apply to the entire domain, not individual addresses.** You cannot route `basses@commonwealthchorale.net` through Google while leaving `altos@` or anyone's personal mailbox on the old system — the moment MX changes, *all* incoming mail for `commonwealthchorale.net` goes to Google. This is unavoidable and is the one genuinely "live" step in this whole process. Everything else below can be done in advance with **zero impact** on current mail.

---

## Phase 0: Audit the Current State (do this first, changes nothing)

Before touching anything, find out exactly what's running today:

1. **Check current MX records.** In GoDaddy DNS management for `commonwealthchorale.net`, look at the MX records currently listed. Write down every host and priority value exactly as shown — this is your rollback data if anything goes wrong.
2. **Check current TXT records**, specifically:
   - Any **SPF record** (starts with `v=spf1 ...`) — this authorizes which servers are allowed to send mail *as* `commonwealthchorale.net`. If Constant Contact sends newsletters "from" your domain, there's likely an `include:` for Constant Contact's servers in here.
   - Any **DKIM records** already present (for GoDaddy email or Constant Contact)
   - Any **DMARC record** (a TXT record at `_dmarc.commonwealthchorale.net`) — this tells receiving mail servers how strictly to enforce SPF/DKIM failures
3. **Inventory real mailboxes.** Does anyone have an actual personal inbox like `director@commonwealthchorale.net` hosted through GoDaddy email? (Not a list/group address — an actual individual's mailbox.) This matters enormously: if real mailboxes exist, they must become Google Workspace users (or the mail routed elsewhere) before MX changes, or their mail will start bouncing the moment you cut over.
4. **Understand how the current group addresses actually work.** Ask: when someone emails `basses@commonwealthchorale.net` today, what actually happens? Likely one of:
   - It's a GoDaddy email forwarding rule/alias that redirects to a list of addresses
   - It doesn't actually receive mail at all — Constant Contact might just be a one-way *outbound* newsletter tool where an admin uploads a list and Constant Contact blasts it out, with no real inbound `basses@` mailbox existing
   
   This distinction changes your migration significantly. If there's no real inbound address today, you're not "migrating" mail flow so much as creating something new. If there is, you need to know exactly what's currently forwarding to whom, since Constant Contact's list may not match GoDaddy's forwarding list exactly.

**Bring back what you find for #1 and #2 (the actual MX and TXT record text) — paste them here and I'll help you read them and figure out exactly what needs to change vs. stay.**

---

## Phase 1: Set Up Google Workspace for the Domain (non-disruptive)

This step **does not touch mail flow** — you're just registering the domain with Workspace and proving ownership.

- Sign up at workspace.google.com for `commonwealthchorale.net`
- Apply for/confirm **Google Workspace for Nonprofits** eligibility first
- Complete domain **ownership verification** (a TXT record, added *alongside* existing TXT records — this does not remove or conflict with SPF/DKIM/etc. already there)

At this point, current mail keeps flowing exactly as before. Nothing has changed for end users.

## Phase 2: Set Up DKIM (non-disruptive)

- Generate the DKIM key in Admin console (Apps → Gmail → Authenticate email)
- Add the DKIM TXT record (`google._domainkey`) in GoDaddy — this is an *additional* TXT record, not a replacement of anything existing
- Click "Start authentication"

Still no impact on live mail — DKIM just means Google *can* authenticate messages once it's actually sending them, which isn't yet.

## Phase 3: Build and Fully Populate Every Google Group (non-disruptive)

This is the big one you can do entirely in advance:

- Create every group you need (`basses@`, `altos@`, `tenors@`, etc.) inside the Workspace account
- Configure each group's settings (external members allowed, who can post, reply-to-group, etc. — same settings we worked through on the test domain)
- **Add every real member now**, using their personal emails
- Test internally — group owners can post test messages and members will receive them **as long as you're testing via the group's direct interface or a member replying**, though true "send an email to `basses@commonwealthchorale.net` from outside" won't work correctly until MX is switched (mail will still go to your old provider until then)

By the end of this phase, the groups are fully built and populated, sitting ready — just not yet receiving domain mail.

## Phase 4: Update SPF/DMARC for Outgoing Mail (careful, but not yet disruptive to inbound)

If you want Google Groups/Gmail to be able to send mail *as* `commonwealthchorale.net` (e.g., a reply from a Workspace-hosted address), your SPF record needs `include:_spf.google.com` added alongside whatever's already there for Constant Contact — **not replacing it**, unless you're also retiring Constant Contact's sending. Removing an existing legitimate include could cause Constant Contact's newsletters to start failing SPF checks and land in spam.

This step is safe to do ahead of the cutover since it only affects *outgoing* authentication, not where incoming mail is delivered.

## Phase 5: The MX Cutover (the actual live moment)

This is the one step that immediately redirects all incoming mail:

- Confirm every real mailbox from Phase 0's inventory has a home in Workspace (as a user or otherwise handled) — **do not proceed if this isn't resolved**
- Change the MX record(s) in GoDaddy to point to Google (`smtp.google.com`, priority 1, or the legacy 5-record set)
- Do this at a **low-traffic time** (e.g., late evening) and tell people mail might be briefly delayed
- Propagation is usually fast (minutes) but can take up to 24–48 hours in rare cases since DNS caching varies by the sender's own resolver

## Phase 6: Verify and Monitor

- Send test emails to each group address from an outside account
- Confirm delivery to members
- Check that Constant Contact sending (if still in use) isn't broken by SPF changes
- Watch for a few days for any bounced mail reports

## Phase 7: Decommission the Old Path

- Once confident, turn off/retire the old GoDaddy forwarding rules for the group addresses
- Decide whether Constant Contact remains in use for actual newsletter *sending* (a separate function from the group list-serve behavior) or whether it's being fully replaced

---

## What to bring back next

Paste (or describe) the actual current **MX records** and **TXT records** for `commonwealthchorale.net` from GoDaddy's DNS management page, and I'll help you read exactly what's there and map out what changes, what stays, and what the real risk points are before you touch anything live.
