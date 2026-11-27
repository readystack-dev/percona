# Percona 9.7.2-3 — ReadyStack release `9.7.2-3-CE-ubuntu24.04-r1`

Generated 2026-11-25 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/percona:9.7.2-3-CE-ubuntu24.04-r1` (linux/amd64). Index digest `sha256:d40c25d0ef77b0b29fe5ecc4e0d813560c3d483ced3fff3ce6758372ce03dabb` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:bb3762ab917d90890bf0867d815770b45a92b256a2b937c23060a94859a1947b` [`TARGET_DIGEST.txt`].
- **Upstream:** Percona 9.7.2-3 built from source at `Percona-Server-9.7.2-3` of https://github.com/percona/percona-server — upstream notes: https://github.com/percona/percona-server/releases/tag/Percona-Server-9.7.2-3 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** `ubuntu:24.04`; runtime user `mysql`.
- **Build:** `source-rebuild-c`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `9.7.2-2-CE-ubuntu24.04-r4`.

## What changed in this release

- Upstream version 9.7.2-2 → 9.7.2-3.
- This release moves Percona from 9.7.2-2 to 9.7.2-3, a release of upstream's newer 9.7.2-3.x line. Upstream's release notes list what changed: https://github.com/percona/percona-server/releases/tag/Percona-Server-9.7.2-3

## Security status at release (measured 2026-11-25)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `mysql` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/percona:9.7.2-3-CE-ubuntu24.04-r1` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** MYSQL_ROOT_HOST defaults to %, so root can log in over the network with its password; set MYSQL_ROOT_HOST=localhost on the first start to create no network root account, or restrict it to an address or subnet.
- **Before exposing this service:** The TLS certificate the server generates on its first start is self-signed; clients that verify certificates need your own certificate, configured with ssl_cert and ssl_key in a file under /etc/mysql/conf.d/.
- **Before exposing this service:** Keep ports 3306 and 33060 on a private network: both accept password logins for every account with a network host.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:bb3762ab917d90890bf0867d815770b45a92b256a2b937c23060a94859a1947b`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 10 of 10 use cases passed (10 authored) against the running image [`docs/validation/test-results.json`].

## Known issues

- **low** (ReadyStack package): Admin handbook: Measured on the release digest: every health-check ping (every 5 s, no credentials) writes a sha256_password deprecation Warning to docker logs (one more line per manual ping), so a healthy log does… [`RSD-percona-2b3a6e9f4c`]

## Defects fixed

- 33 problems found before release and fixed before it shipped (33 by review); each is listed in `docs/defects/defects.json`.

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/percona:9.7.2-3-CE-ubuntu24.04-r1
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

