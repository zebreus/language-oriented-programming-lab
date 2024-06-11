{
  description = "Language oriented programming setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=refs/heads/master";
    allegro-express.url = "github:zebreus/allegro-express";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      allegro-express,
    }:
    flake-utils.lib.eachDefaultSystem (system: rec {
      name = "language-oriented-programming";
      packages.default = (
        with nixpkgs.legacyPackages.${system};
        stdenv.mkDerivation {
          name = name;

          src = ./.;

          buildInputs = [
            (sbcl.withPackages (
              ps: with ps; [
                bordeaux-threads
                usocket
                cl-json
                flexi-streams
                lisp-unit2
              ]
            ))
            (allegro-express.packages.${system}.default)

            nil
          ];
        }
      );
    });
}
