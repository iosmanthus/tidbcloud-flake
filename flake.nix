{
  description = "dev shell for tidbcloud projects";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShell = pkgs.mkShell {
            hardeningDisable = [ "all" ];
            buildInputs = with pkgs;[
              go_1_20
              gcc
              gopls
              kubectl
              python3
              # For protobuf code generation
              buf
              # For pulumi stack
              nodejs
              gnumake
            ];
          };
        }
      );
}
