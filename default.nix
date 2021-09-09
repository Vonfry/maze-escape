{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:
haskellPackages.callPackage ./.nix/maze.nix { }
