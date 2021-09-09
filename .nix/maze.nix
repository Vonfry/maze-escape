{ mkDerivation, base, lib }:
mkDerivation {
  pname = "maze";
  version = "0.1.0.0";
  src = ../.;
  libraryHaskellDepends = [ base ];
  testHaskellDepends = [ base ];
  license = lib.licenses.gpl3Plus;
}
