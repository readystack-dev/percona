# Provenance — Percona (`9.7.2-2-CE-ubuntu24.04-r3`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/percona/percona-server
- Revision built: `Percona-Server-9.7.2-2` (commit `91438a0430fbcd52dd85472edf3b357484484c22`)
- Source tree: `5e375ebb44dd748378b684ac1550632360d163dbce826c53c90ee5c04c7927f9` over 63386 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-c`; base image `ubuntu:24.04`
- Compiled with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1794476898` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/percona:9.7.2-2-CE-ubuntu24.04-r3` — index digest `sha256:01d4e68517012f99d1734780e6163f9e92ea9aa33178cb60d0c5ee67dce38872` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:186d5ba406023ee3efbb570a00073ea62a366535d91e471dda71d9b19e356c23` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/percona:9.7.2-2-CE-ubuntu24.04-r3`

## Pinned inputs, and why

- 15 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 3, image digests 1, dependency versions readystack sets 4, pins in the kit's dockerfiles 2, readystack's build engine 1, dependencies upstream chose 2).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-percona-9.7.2-2-CE-ubuntu24.04-r3.trail.json`, published beside this archive and signed with the release key (`ReadyStack-percona-9.7.2-2-CE-ubuntu24.04-r3.trail.json.sigstore`), and readable at https://readystack.dev/products/percona/trail/9.7.2-2-CE-ubuntu24.04-r3.

