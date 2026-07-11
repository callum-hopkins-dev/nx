# nx

Manage a flake-based NixOS configuration.

`nx` is a small command-line tool for managing a flake-based NixOS configuration. It assumes your configuration is stored in `/etc/nixos` and selects the host configuration using the current hostname.

It provides shortcuts for common workflows such as:

```console
nx setup
nx build
nx switch
nx update
nx check
```

## Install

### Run directly

```console
nix run github:callum-hopkins-dev/nx -- --help
```

### Install into your profile

```console
nix profile install github:callum-hopkins-dev/nx
```

### Add to a NixOS flake

Add `nx` as an input:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nx.url = "github:callum-hopkins-dev/nx";
  };
}
```

Install the package directly:

```nix
{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.nx.packages.${pkgs.system}.default
  ];
}
```

### Use the overlay

```nix
{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    inputs.nx.overlays.default
  ];

  environment.systemPackages = [
    pkgs.nx
  ];
}
```

## Maintainer

**Callum Hopkins**

- GitHub: [@callum-hopkins-dev](https://github.com/callum-hopkins-dev)
- Email: [callum@hopkins.family](mailto:callum@hopkins.family)

## Contributing

Bug reports and additions are welcome. Feel free to open an issue or submit a pull request, but please note that contributions will only be considered on a limited basis.
