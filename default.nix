{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc8104" }:
nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./.nix/maze.nix { }
