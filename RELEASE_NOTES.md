# Percona 9.7.2-3 — ReadyStack release `9.7.2-3-CE-ubuntu24.04-r2`

Generated 2026-11-27 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/percona:9.7.2-3-CE-ubuntu24.04-r2` (linux/amd64). Index digest `sha256:dac6e0f189a9278ba93590fd08cf85cd409511f95533f928e408d7e0aec18651` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:3b8c785b0c6400f4b36e293529b67ca3b8fa0c2f24057798d8086fdc6f389fc2` [`TARGET_DIGEST.txt`].
- **Upstream:** Percona 9.7.2-3 built from source at `Percona-Server-9.7.2-3` of https://github.com/percona/percona-server — upstream notes: https://github.com/percona/percona-server/releases/tag/Percona-Server-9.7.2-3 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** `ubuntu:24.04`; runtime user `mysql`.
- **Build:** `source-rebuild-c`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `9.7.2-3-CE-ubuntu24.04-r1`.

## What changed in this release

- Upstream version unchanged (9.7.2-3); ReadyStack rebuild.
- Percona 9.7.2-3 is unchanged from the release this supersedes (9.7.2-3-CE-ubuntu24.04-r1); this release rebuilds it. Changes: libgssapi-krb5-2 moves from 1.20.1-6ubuntu2.10 to 1.20.1-6ubuntu2.12 (USN-9202-1); libk5crypto3 moves from 1.20.1-6ubuntu2.10 to 1.20.1-6ubuntu2.12 (USN-9202-1); libkrb5-3 moves from 1.20.1-6ubuntu2.10 to 1.20.1-6ubuntu2.12 (USN-9202-1); libkrb5support0 moves from 1.20.1-6ubuntu2.10 to 1.20.1-6ubuntu2.12 (USN-9202-1). Settings, ports and data volumes are those of 9.7.2-3-CE-ubuntu24.04-r1: replace the container with this image on the same volumes.

## Security status at release (measured 2026-11-27)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `mysql` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/percona:9.7.2-3-CE-ubuntu24.04-r2` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** MYSQL_ROOT_HOST defaults to %, so root can log in over the network with its password; set MYSQL_ROOT_HOST=localhost on the first start to create no network root account, or restrict it to an address or subnet.
- **Before exposing this service:** The TLS certificate the server generates on its first start is self-signed; clients that verify certificates need your own certificate, configured with ssl_cert and ssl_key in a file under /etc/mysql/conf.d/.
- **Before exposing this service:** Keep ports 3306 and 33060 on a private network: both accept password logins for every account with a network host.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:3b8c785b0c6400f4b36e293529b67ca3b8fa0c2f24057798d8086fdc6f389fc2`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 10 of 10 use cases passed (10 authored) against the running image [`docs/validation/test-results.json`].

## Known issues

- **low** (ReadyStack package): Admin handbook: Measured on the release digest: every health-check ping (every 5 s, no credentials) writes a sha256_password deprecation Warning to docker logs (one more line per manual ping), so a healthy log does… [`RSD-percona-f836797e24`] (carried from `9.7.2-3-CE-ubuntu24.04-r1`, recorded there as `RSD-percona-2b3a6e9f4c`)
- **low** (ReadyStack package): API guide: The rewritten 'docker exec (continued)' section gives, as its example of running a program, a command that prints an Access denied error on a container that has a root password, without saying so;… [`RSD-percona-5adf0e39ac`] (carried from `9.7.2-3-CE-ubuntu24.04-r1`, recorded there as `RSD-percona-eccd18d7cf`)

## Defects fixed

- 16 problems found before release and fixed before it shipped (16 by review); each is listed in `docs/defects/defects.json`.

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/percona:9.7.2-3-CE-ubuntu24.04-r2
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

