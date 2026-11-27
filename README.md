# Percona: ReadyStack build kit

The offline build kit for the Docker image `readystack/percona:9.7.2-3-CE-ubuntu24.04-r1`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [9.7.2-3-CE-ubuntu24.04-r1](https://github.com/readystack-dev/percona/releases/tag/9.7.2-3-CE-ubuntu24.04-r1)
- Image: [`docker.io/readystack/percona:9.7.2-3-CE-ubuntu24.04-r1`](https://hub.docker.com/r/readystack/percona/tags), manifest digest `sha256:bb3762ab917d90890bf0867d815770b45a92b256a2b937c23060a94859a1947b`
- Product page: https://readystack.dev/products/percona
- Source and build recipe: https://readystack.dev/products/percona/recipe
- Build trail: https://readystack.dev/products/percona/trail/9.7.2-3-CE-ubuntu24.04-r1
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=percona

## The image

Single container. Percona Server for MySQL 9.7.2-3 (9.7 LTS) compiled from the upstream source tag with CMake and installed in /usr/local/mysql. The image is the whole database server: there is no external database and no sidecar. mysqld runs in the foreground as the non-root mysql user. On the first start with an empty data directory the entrypoint creates the data directory in /var/lib/mysql and sets the root password before the server opens a network port.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-25 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 95 packages with copyleft licences (GPL, LGPL, MPL), all of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`mysql`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-25; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/percona.

Percona is distributed under its upstream licence (GPL-2.0-only); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [9.7.2-3-CE-ubuntu24.04-r1 release](https://github.com/readystack-dev/percona/releases/tag/9.7.2-3-CE-ubuntu24.04-r1): `ReadyStack-percona-9.7.2-3-CE-ubuntu24.04-r1.tar.gz` (1.1 GB), SHA-256 `90b09edebc439090501279f47065aa4bf045e0511a1ddc62e58c61f898eec2b6`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-percona-9.7.2-3-CE-ubuntu24.04-r1.rebuild.json.sigstore ReadyStack-percona-9.7.2-3-CE-ubuntu24.04-r1.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-percona-9.7.2-3-CE-ubuntu24.04-r1.tar.gz
cd 9.7.2-3-CE-ubuntu24.04-r1
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-percona-9.7.2-3-CE-ubuntu24.04-r1.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/percona/recipe. The complete kit is the release download. Each release is a tag here.

— ReadyStack · https://readystack.dev
