{
  description = "Manage a flake-based NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    let
      overlay = final: prev: {
        nx = final.writeShellApplication {
          name = "nx";

          runtimeInputs = [
            final.git
            final.nix
            final.nixos-rebuild-ng
            final.hostname
          ];

          text = builtins.readFile ./nx;

          meta = {
            description = "Manage a flake-based NixOS configuration";
            mainProgram = "nx";
            platforms = final.lib.platforms.all;
          };
        };
      };
    in
    {
      overlays.default = overlay;
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        packages.default = pkgs.nx;
      }
    );
}
