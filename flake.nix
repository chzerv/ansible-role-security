{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
        with pkgs; {
          devShells.default = mkShell {
            buildInputs = [
              ansible
              ansible-lint
              yamllint
              vagrant
              molecule
              python311Packages.python-vagrant
              python311Packages.libvirt
            ];
          };
        }
    );
}
