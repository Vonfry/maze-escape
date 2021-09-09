{ nixpkgs ? import <nixpkgs> {} }:

let
  maze = import ./. { inherit nixpkgs; };
in

maze.envFunc { withHoogle = true; }
