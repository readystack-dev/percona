# Percona 9.7.2-2 — ReadyStack release `9.7.2-2-CE-ubuntu24.04-r4`

Generated 2026-11-25 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/percona:9.7.2-2-CE-ubuntu24.04-r4` (linux/amd64). Index digest `sha256:1c7a2f14423983124478b6b5c31a92ad8ca5aa18882a6dfa10d7bdabc8168474` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:0a56b596de0bd71569413600002da22b5741f8d203797a06b467a32e40116ad6` [`TARGET_DIGEST.txt`].
- **Upstream:** Percona 9.7.2-2 built from source at `Percona-Server-9.7.2-2` of https://github.com/percona/percona-server — upstream notes: https://github.com/percona/percona-server/releases/tag/Percona-Server-9.7.2-2 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** `ubuntu:24.04`; runtime user `mysql`.
- **Build:** `source-rebuild-c`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `9.7.2-2-CE-ubuntu24.04-r3`.

## What changed in this release

- Upstream version unchanged (9.7.2-2); ReadyStack rebuild.
- Percona 9.7.2-2 is unchanged from the release this supersedes (9.7.2-2-CE-ubuntu24.04-r3); this release rebuilds it. Changes: libssh-4 moves from 0.10.6-2ubuntu0.5 to 0.10.6-2ubuntu0.6 (USN-9187-1). Settings, ports and data volumes are those of 9.7.2-2-CE-ubuntu24.04-r3: replace the container with this image on the same volumes.

## Security status at release (measured 2026-11-25)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `mysql` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/percona:9.7.2-2-CE-ubuntu24.04-r4` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** MYSQL_ROOT_HOST defaults to %, so root can log in over the network with its password; set MYSQL_ROOT_HOST=localhost on the first start to create no network root account, or restrict it to an address or subnet.
- **Before exposing this service:** The TLS certificate the server generates on its first start is self-signed; clients that verify certificates need your own certificate, configured with ssl_cert and ssl_key in a file under /etc/mysql/conf.d/.
- **Before exposing this service:** Keep ports 3306 and 33060 on a private network: both accept password logins for every account with a network host.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:0a56b596de0bd71569413600002da22b5741f8d203797a06b467a32e40116ad6`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 10 of 10 use cases passed (10 authored) against the running image [`docs/validation/test-results.json`].

## Known issues

- **low** (ReadyStack package): API guide: Reset procedure gives no hint to wait for the temporary server; the first docker exec fails. [`RSD-percona-6fccda8916`] (carried from `9.7.2-2-CE-ubuntu24.04-r1`, recorded there as `RSD-percona-48d945e9a6`)
- **low** (ReadyStack package): API guide: Reset procedure gives no hint to wait for the temporary server; the first docker exec fails. [`RSD-percona-a9f8a8a3de`] (carried from `9.7.2-2-CE-ubuntu24.04-r1`, recorded there as `RSD-percona-a540d006b0`)

## Defects fixed

- 1 problem found before release and fixed before it shipped (1 by review); each is listed in `docs/defects/defects.json`.

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/percona:9.7.2-2-CE-ubuntu24.04-r4
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

