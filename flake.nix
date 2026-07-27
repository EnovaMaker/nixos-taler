# =============================================================================
# nixos-taler — flake skeleton (design phase)
#
# This is intentionally a skeleton: it declares the project's planned
# structure and gives contributors a dev shell to read/discuss the design
# docs in. It does not build or test anything yet — see docs/ROADMAP.md for
# what each output below will actually contain once implementation starts.
# =============================================================================
{
  description = "nixos-taler: Declarative GNU Taler infrastructure with NixOS (design phase, no implementation yet)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        # -------------------------------------------------------------------
        # Planned outputs — not implemented yet (see docs/ROADMAP.md):
        #
        #   nixosModules.taler   services.taler.* NixOS module
        #                        (exchange, merchant, database submodules)
        #   packages.taler-cli   wallet / admin CLI
        #   checks.taler-test    NixOS VM integration test
        # -------------------------------------------------------------------

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            postgresql # for poking at the DB schema while discussing the design
          ];
        };
      });
}
