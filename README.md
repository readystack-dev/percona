# Percona: ReadyStack build kit

The offline build kit for the Docker image `readystack/percona:9.7.2-2-CE-ubuntu24.04-r3`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [9.7.2-2-CE-ubuntu24.04-r3](https://github.com/readystack-dev/percona/releases/tag/9.7.2-2-CE-ubuntu24.04-r3)
- Image: [`docker.io/readystack/percona:9.7.2-2-CE-ubuntu24.04-r3`](https://hub.docker.com/r/readystack/percona/tags), manifest digest `sha256:186d5ba406023ee3efbb570a00073ea62a366535d91e471dda71d9b19e356c23`
- Product page: https://readystack.dev/products/percona
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=percona

Percona is distributed under its upstream licence (GPL-2.0-only); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [9.7.2-2-CE-ubuntu24.04-r3 release](https://github.com/readystack-dev/percona/releases/tag/9.7.2-2-CE-ubuntu24.04-r3): `ReadyStack-percona-9.7.2-2-CE-ubuntu24.04-r3.tar.gz` (1.1 GB), SHA-256 `e7a4e6682eb9b51a2b26881cb3e04b6ba10dbcdf8c0bef7804d69d914ad20076`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-percona-9.7.2-2-CE-ubuntu24.04-r3.rebuild.json.sigstore ReadyStack-percona-9.7.2-2-CE-ubuntu24.04-r3.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-percona-9.7.2-2-CE-ubuntu24.04-r3.tar.gz
cd 9.7.2-2-CE-ubuntu24.04-r3
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-percona-9.7.2-2-CE-ubuntu24.04-r3.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/percona/recipe. The complete kit is the release download. Each release is a tag here.
