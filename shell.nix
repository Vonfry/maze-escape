{ nixpkgs ? import <nixpkgs> {} }:


let
  inherit (nixpkgs) haskellPackages;
  maze-escape = import ./. { inherit haskellPackages; };
in
with haskellPackages;
maze-escape.env.overrideAttrs (oldAttrs: {
  buildInputs = oldAttrs.buildInputs ++ [
    cabal-install cabal2nix haskell-language-server
  ];
})
