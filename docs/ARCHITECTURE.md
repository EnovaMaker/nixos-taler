# Architecture (design)

High-level approach — this is the design this proposal funds building
out, not a description of a finished system.

```
                    nixpkgs (existing, minimal)
wallet --> exchange (port 8081) --> PostgreSQL
              |
              v
          merchant (port 8080)

                    this project (proposed layer)
auditor  ·  TLS/ACME  ·  backups  ·  secrets (sops/agenix)  ·
systemd hardening  ·  AML/KYC typed options  ·  admin/merchant CLI
```

- **Exchange / Merchant / PostgreSQL** — already declarable today via
  nixpkgs' own `nixos/modules/services/finance/taler/` module. This
  project does not re-implement that layer.
- **Auditor** — independent database and scheduled consistency checks
  against the exchange, not present upstream.
- **AML/KYC options** — GNU Taler enforces legitimization rules
  (`[kyc-rule-*]`) by default; upstream leaves these as raw freeform INI.
  This project turns them into typed, safe-by-default Nix options.
- **TLS/ACME, backups, secrets, hardening** — the operational baseline
  needed to run any of this outside a lab environment.

The exact NixOS options surface, CLI, and how this layers onto the
existing upstream module are part of what this proposal delivers — see
[ROADMAP.md](ROADMAP.md).

## Open questions

- Exact mechanism for layering onto nixpkgs' `services.taler` common
  config generator (`environment.etc."taler/taler.conf"`) versus a
  parallel `services.nixosTaler` namespace that composes with it — to be
  settled with upstream maintainers during the M3 upstreaming phase.
- Exchange key lifecycle (denomination/signing key rotation) in a fully
  declarative NixOS setup — still open.

Feedback on this design is welcome via issues.
