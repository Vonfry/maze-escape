{ mkDerivation, base, hspec, lib, mtl }:
mkDerivation {
  pname = "maze";
  version = "0.1.0.0";
  src = ../.;
  libraryHaskellDepends = [ base mtl ];
  testHaskellDepends = [ base hspec ];
  license = lib.licenses.gpl3Plus;
}
