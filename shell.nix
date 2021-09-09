{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;
let
  hpkgs = haskellPackages;
  maze = import ./. { haskellPackages = hpkgs; };
in

mkShell {
  inputFrom = [ maze ];
  buildInputs = with hpkgs; [ haskell-language-server ];
}
