{
  description = "Empty nix project"; # TODO: Edit this to fit your project

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      systems = with flake-utils.lib.system; [
        # Add or remove systems from this list if your project can be developed on them or not
        # See https://github.com/numtide/flake-utils/blob/main/allSystems.nix for a complete list
        x86_64-linux
        aarch64-linux
        x86_64-darwin
        aarch64-darwin
      ];
    in
    flake-utils.lib.eachSystem systems (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            # TODO: Add your development dependencies here, check https://search.nixos.org/packages to find the proper names
            hello
          ];
          # TODO: Add commands you want to run before the environment is entered here
          # Do not run a new shell here, direnv and nix develop will do that for you
          shellHook = ''
            echo -e "$(tput setaf 3)\n--- $(tput smso) WARNING $(tput rmso) ---\n"
            echo -e "Please open the newly created $(tput setaf 4)flake.nix$(tput setaf 3) file and have a look at the $(tput setaf 2)# TODO$(tput setaf 3) comments!\n"
            echo -e "Once you're done, remove the lines that printed these warnings from the shellHook."
            echo -e "$(tput setaf 3)\n-----------------\n$(tput sgr0)"
          '';
        };
      }
    );
}
