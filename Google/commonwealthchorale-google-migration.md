# Migrating commonwealthchorale.net to Google

## Background

commonwealthchorale.net is registered at GoDaddy, but its DNS is currently hosted at **Cloudflare** (nameservers `nile.ns.cloudflare.com` / `tia.ns.cloudflare.com`). GoDaddy has no visibility into what records exist in that Cloudflare zone — it only knows DNS is delegated there.

To move the domain to Google, this is a **two-step migration**, not a one-step DNS edit:

1. **Cut the domain over from Cloudflare's nameservers to GoDaddy's**, which makes GoDaddy the DNS authority.
2. **Rebuild the needed records in GoDaddy's DNS Records tab**, pointing at Google instead of whatever Cloudflare had.

Nameservers are the single lever that controls *all* DNS for the domain — email routing (MX), the website (A/CNAME), and verification records (TXT) all live in one zone, wherever the nameservers point. There's no per-service "route email through X" setting separate from that.

**Risk:** the moment nameservers switch, anything Cloudflare was serving (email, live website, other subdomains) stops resolving until the equivalent records exist in GoDaddy. Confirm with Carol what's actually running on Cloudflare before touching production (commonwealthchorale.net).

---

## Part 1: Full dry run on driscollsingers.net

Since driscollsingers.net is already on GoDaddy's own nameservers, testing "point it at Google" alone (as done previously) only exercises step 2 above — not the Cloudflare cutover. To rehearse the *actual* migration end-to-end:

1. **Create a free Cloudflare account** and add driscollsingers.net as a site.
2. **Point driscollsingers.net's nameservers at Cloudflare** (GoDaddy → domain → DNS → Nameservers → Change Nameservers → enter custom nameservers → the two Cloudflare ones Cloudflare gives you). Wait for propagation.
3. **Add a couple of test records inside Cloudflare** (e.g., an A record and an MX record) so there's something real to migrate away from — this simulates Carol's current setup.
4. **Switch nameservers back to GoDaddy's defaults**: GoDaddy → DNS → Nameservers → Change Nameservers → select "Use GoDaddy nameservers." Wait for propagation.
5. **Rebuild records in GoDaddy pointed at Google** (see Part 2 record list below) under DNS → DNS Records → Add.
6. Confirm everything resolves as expected (site loads, verification passes) before treating this as validated.

This confirms you know the exact click path and timing before doing it on the live choir domain.

---

## Part 2: Records to point at Google

Add these under **DNS → DNS Records → Add** (after nameservers are on GoDaddy):

### Website (Google Sites)
- In Google Sites: Settings → Custom URLs → enter the domain → Assign. Google will give you a verification token and hosting target.
- **TXT** record: Host `@`, Value = verification token from Google.
- **CNAME** record: Host `www`, Value `ghs.googlehosted.com`.
- Root domain (`@`) can't be a CNAME — if you need the naked domain to also work, use the **A records** Google Sites provides instead of a CNAME for `@`.
- Back in Google Sites, click **Verify**.

### Email (only if moving email to Google Workspace — confirm with Carol first)
- **MX** records: Google Workspace's mail server list (provided when you set up Workspace for the domain, typically `ASPMX.L.GOOGLE.COM` plus several `ALT` servers with priorities).
- **TXT** (SPF): `v=spf1 include:_spf.google.com ~all`
- **TXT/CNAME** (DKIM): value provided by Google Workspace admin console when you generate a DKIM key for the domain.

---

## Part 3: Migrate commonwealthchorale.net (live domain)

Only after the dry run succeeds and Carol confirms what's actually on Cloudflare:

1. Document every record currently in Cloudflare's dashboard for commonwealthchorale.net (needs Cloudflare login — ask Carol who has access, since GoDaddy delegate access doesn't extend to it).
2. GoDaddy → commonwealthchorale.net → DNS → Nameservers → Change Nameservers → "Use GoDaddy nameservers." Wait for propagation (up to 48 hrs, usually faster).
3. Immediately rebuild in GoDaddy DNS Records:
   - Everything from step 1 that still needs to exist (anything not moving to Google).
   - The new Google records from Part 2.
4. Verify: site loads over `commonwealthchorale.net` and `www.commonwealthchorale.net`, email sends/receives correctly, Google Sites shows "Verified."

---

## Quick reference: GoDaddy navigation

- Domain detail page: `dcc.godaddy.com/control/portfolio/<domain>/settings`
- Tabs: **Overview | DNS | Products | Activity Log**
- Under DNS: **DNS Records | Forwarding | Nameservers | Premium DNS | Hostnames | DS Records**
  - **DNS Records** — add/edit A, CNAME, MX, TXT records (only usable once nameservers point to GoDaddy).
  - **Nameservers** — the single setting controlling who's authoritative for the domain's DNS.
