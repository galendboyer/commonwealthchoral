# What Actually Happens When Someone Emails driscollsingers.net

![Numbered diagram of the email resolution path through GoDaddy to Groupanizer or Google](./email-routing-diagram.svg)

**(1)** An email is sent. A mail server — Gmail's, in this test — has a message addressed to `testsingers@driscollsingers.net` and needs to figure out where in the world to deliver it. It doesn't know yet; all it has is a domain name.

**(2)** That mail server asks the internet's DNS system a question: "who is authoritative for driscollsingers.net, and what's the mail server for that domain?" The first stop in answering that question is the domain's registry record — the piece of information that says, for driscollsingers.net, "ask these two nameservers." That registry record is exactly the **Nameservers** setting inside GoDaddy. GoDaddy is the registrar, which means GoDaddy is the party that gets to tell the wider internet which nameservers are authoritative for this domain. It doesn't matter who actually runs those nameservers — GoDaddy's job is just to point at them correctly.

From here, the path splits in two (steps 3 onward in the diagram, reading left to right), depending on what that Nameservers setting currently says. Each box in a column is named for where the message ends up, not for who's hosting the plumbing along the way — that's why every box on the left mentions Groupanizer, and every box on the right mentions Google, even though the actual DNS host differs from the final destination.

**Left column — if it says Cloudflare's nameservers (3a):** the sending mail server asks Cloudflare's DNS servers directly, "what's the MX record for driscollsingers.net?" **(4a)** Cloudflare answers with its own MX records — its mail-routing servers. **(5a)** The sending mail server connects to Cloudflare, and Cloudflare's Email Routing feature takes over: it looks up the routing rule set up for `testsingers@driscollsingers.net` and forwards the message on to **Groupanizer**, the destination configured for that address. Google is never contacted at all in this version — the message's entire journey happens through Cloudflare's infrastructure until it lands in Groupanizer.

**Right column — if it says GoDaddy's own nameservers (3b):** the sending mail server instead asks GoDaddy's DNS servers the same question. **(4b)** GoDaddy's DNS servers answer with whatever records live in GoDaddy's own DNS Records tab — in this domain's case, Google's mail servers (`aspmx.l.google.com` and its alternates). **(5b)** The sending mail server connects to Google's mail infrastructure and hands off the message. Google checks its own records (the SPF, DKIM, and DMARC entries also stored in that same DNS zone) to decide whether to trust the message, then delivers it into the Google Workspace mailbox for that address.

Two details make this trickier to observe than it sounds. First, only one of these two columns is ever active for the domain as a whole — it's determined by that single Nameservers setting, not by the individual email address, so no domain can have some addresses going through Cloudflare and others going through Google at the same time. Second, DNS answers get cached for a period of time (the record's TTL) by every mail server and resolver that asks about them, so a sending mail server can still be holding onto a stale answer even right after the Nameservers setting changes — which is why a test can appear to succeed or fail for reasons that have nothing to do with whether the setting change actually "worked."

The only way to know which path a given message actually took is to look at where it ended up and read the delivery trail left in its headers — that trail records every mail server that actually touched the message, which is the ground truth regardless of what any dashboard currently displays.

---

## The same picture, applied to commonwealthchorale.net

![Numbered diagram of commonwealthchorale.net's current Cloudflare path and its Google target](./commonwealthchorale-routing-diagram.svg)

Both columns for commonwealthchorale.net are marked preconfigured — the left column because it's genuinely built and running today, and the right column as the target structure this document has been walking through, ready to be built out the same way it already exists on the test domain. What distinguishes them here isn't which one is "real" — it's the orange arrow curving from GoDaddy (2) over to the left column (3a), marked **ACTIVE now**. That arrow is the actual current state: this domain's Nameservers setting points at Cloudflare, so the left column is the only one that resolves anything right now. A message sent to this domain goes through Cloudflare's DNS zone (4a) and lands wherever Cloudflare's Email Routing currently forwards it (5a) — a destination Carol has configured, worth confirming before anything changes. The right column (3b/4b/5b, the Google target) is drawn dashed at step 5b specifically because, while the pattern is understood, those records haven't actually been built on this domain yet.

Nothing about this domain should be touched until the toggle mechanism itself has been proven on the test domain below.

---

## The same picture, as a toggle test on driscollsingers.net

![Numbered diagram of driscollsingers.net with both paths pre-configured and a toggle at the registrar](./driscollsingers-toggle-test-diagram.svg)

driscollsingers.net is set up differently on purpose: both columns already exist and are fully configured — the left column (3a/4a/5a) through the Email Routing rule that forwards to Groupanizer, and the right column (3b/4b/5b) through its existing Google Workspace setup. Neither column is "the test" and the other "the real thing" — both are equally real and equally ready to answer, which is why both are tagged preconfigured rather than one being marked active. The only thing that decides which one actually handles a given message is the Nameservers value at step 2, the same single toggle switch described throughout this document.

The point of this test is to flip that toggle back and forth — Cloudflare to Google, then Google back to Cloudflare, more than once — and confirm each time, using the header-trail method described above, that the message actually took the path the toggle said it should. Proving that the switch is reliable and repeatable in both directions is what builds confidence in flipping it for real. Once that's demonstrated on driscollsingers.net, the same action — changing the Nameservers setting, and only that setting — gets carried out on commonwealthchorale.net, using its own actual records rather than test ones, replacing the orange "ACTIVE now" arrow in the diagram above with one pointing right, at Google, instead of left toward Cloudflare.
