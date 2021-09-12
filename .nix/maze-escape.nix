{ mkDerivation, base, hspec, ilist, lib, mtl, utility-ht, containers }:
mkDerivation {
  pname = "maze-escape";
  version = "0.1.0.0";
  src = ../.;
  libraryHaskellDepends = [ base ilist mtl utility-ht containers ];
  testHaskellDepends = [ base hspec ilist mtl utility-ht containers ];
  homepage = "https://gitlab.com/Vonfry/maze-escape";
  license = lib.licenses.gpl3Plus;
}
