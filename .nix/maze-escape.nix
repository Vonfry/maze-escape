{ mkDerivation, base, hspec, ilist, lib, mtl }:
mkDerivation {
  pname = "maze-escape";
  version = "0.1.0.0";
  src = ../.;
  libraryHaskellDepends = [ base ilist mtl ];
  testHaskellDepends = [ base hspec ilist mtl ];
  homepage = "https://gitlab.com/Vonfry/maze-escape";
  license = lib.licenses.gpl3Plus;
}
