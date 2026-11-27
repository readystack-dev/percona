# Provenance — Percona (`9.7.2-3-CE-ubuntu24.04-r2`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/percona/percona-server
- Revision built: `Percona-Server-9.7.2-3` (commit `45d3d00fefeeda215229e834e43d60a08bd0bf6c`)
- Source tree: `9d4e6535b7c638efae00f564d44beae1c195090061a6a08a58cd59c0d4af83b7` over 63392 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-c`; base image `ubuntu:24.04`
- Compiled with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1795672795` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/percona:9.7.2-3-CE-ubuntu24.04-r2` — index digest `sha256:dac6e0f189a9278ba93590fd08cf85cd409511f95533f928e408d7e0aec18651` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:3b8c785b0c6400f4b36e293529b67ca3b8fa0c2f24057798d8086fdc6f389fc2` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/percona:9.7.2-3-CE-ubuntu24.04-r2`

## Pinned inputs, and why

- 20 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 3, image digests 1, dependency versions readystack sets 9, pins in the kit's dockerfiles 2, readystack's build engine 1, dependencies upstream chose 2).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-percona-9.7.2-3-CE-ubuntu24.04-r2.trail.json`, published beside this archive and signed with the release key (`ReadyStack-percona-9.7.2-3-CE-ubuntu24.04-r2.trail.json.sigstore`), and readable at https://readystack.dev/products/percona/trail/9.7.2-3-CE-ubuntu24.04-r2.

