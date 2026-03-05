{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      self,
    }:
    flake-utils.lib.eachSystem [ "aarch64-linux" "x86_64-linux" ] (
      system:
      let
        inherit (nixpkgs) lib;
        pkgs = import nixpkgs { inherit system; };
      in
      {
        nixosConfigurations = lib.nixosSystem {
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./configuration.nix
          ];
        };

        packages.default = pkgs.writeShellScriptBin "runvm" ''
          set -euo pipefail

          TMPDIR="$(mktemp -d)"
          export TMPDIR
          trap 'rm -rf -- "$TMPDIR"' EXIT

          export NIX_DISK_IMAGE="$TMPDIR"/nixos.qcow2
          ${lib.getExe self.nixosConfigurations."${system}".config.system.build.vm}
        '';

        apps.default = {
          type = "app";
          program = lib.getExe self.packages."${system}".default;
          meta.description = "Run the VM, then clear up any created storage";
        };

        formatter = pkgs.nixfmt-tree;
      }
    );
}
