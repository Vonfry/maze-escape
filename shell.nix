{ nixpkgs ? import <nixpkgs> {} }:


let
  maze = p: import ./. { haskellPackages = p; };
in
with nixpkgs.haskellPackages;
shellFor {
  packages = p: with p; [ (maze p) ];
  buildInputs = [ cabal-install cabal2nix haskell-language-server ];
}
