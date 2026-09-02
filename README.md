# nixos-taler

**A production-operations layer for GNU Taler on NixOS — proposed for NGI TALER**

## The idea

nixpkgs already ships a minimal NixOS module for GNU Taler
(`nixos/modules/services/finance/taler/`) that declares the exchange and
merchant daemons and their PostgreSQL databases. It stops at the minimum
needed to boot them: no auditor, no TLS/ACME, no automated backups, no
secrets management, no hardened systemd confinement, and no ergonomic
options for the AML/KYC legitimization rules GNU Taler enforces by
default — operators are left writing raw INI by hand for all of that.

This project proposes the layer on top: an auditor role, typed AML/KYC
options, TLS/ACME termination, encrypted backups, sops/agenix secrets,
and full systemd sandboxing — submitted as an extension to the existing
nixpkgs module rather than a competing one.

The option tree would extend `services.taler.*` directly. That is the
nixpkgs `ngi` team's preference, given in
[ngi-nix/forge#944](https://github.com/ngi-nix/forge/issues/944); the
proposal as submitted sketched a separate `services.nixosTaler` tree,
before that question had been put to them.

```nix
services.taler = {
  enable = true;
  role = "both"; # exchange | merchant | both
  currency = "EUR";
  auditor.enable = true;
  backup.enable = true;
};
```

This repository holds the design and early groundwork for the proposal
submitted to the NGI TALER open call (NLnet, European Commission Next
Generation Internet programme). See [docs/ROADMAP.md](docs/ROADMAP.md) for
what the requested funding delivers.

## Why this gap

The existing nixpkgs Taler module (maintained by nixpkgs' `ngi` team)
covers the bare daemons. Running an exchange or merchant in production
also needs an auditor, certificate management, backups, secrets
rotation, sandboxing, and safe AML/KYC configuration — none of which
exist there yet. This project fills that gap as an extension to their
module rather than a competing one, coordinated with its maintainers before
any upstream PR — that conversation happened at
[ngi-nix/forge#944](https://github.com/ngi-nix/forge/issues/944), where
they confirmed the direction is welcome, named the option tree they
prefer, and asked that changes arrive in small, reviewable portions.

## Status

Early-stage: architecture drafted, core module structure validated in a
local proof of concept against the existing nixpkgs Taler module. Not a
public package yet — see [docs/ROADMAP.md](docs/ROADMAP.md) for the
delivery plan this proposal funds.

## Funding

Proposed to NGI TALER (NLnet), August 2026. Developed alongside
nixos-iot-edge, proposed to NGI Fediversity — separate codebases,
separate protocol domains, neither depends on the other being funded.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

[MIT](LICENSE)
