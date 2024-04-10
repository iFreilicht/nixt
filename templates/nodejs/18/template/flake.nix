{
  description = "Node.js project"; # TODO: Edit this to fit your project

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  # nixpkgs unstable only packages the latest few versions of nodejs, so to ensure old versions are available,
  # we need to use an older release as well. The new release is still available for up-to-date dev dependencies.
  inputs.nixpkgs_23_11.url = "github:NixOS/nixpkgs/release-23.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, nixpkgs_23_11, flake-utils }:
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
    flake-utils.lib.eachSystem systems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs_23_11 = import nixpkgs_23_11 {
          inherit system;
          overlays = [
            # Ensure that all packages depending on nodejs will use the version we want
            (self: super: {
              nodejs = super.nodejs_18;
            })
          ];
        };
      in
      {
        devShell =
          pkgs.mkShell
            {
              buildInputs = (with pkgs; [
                # TODO: Add your development dependencies here, check https://search.nixos.org/packages to find the proper names
                # The dependencies added here will be up-to-date, but independent of the installed nodejs version
              ]) ++ (with pkgs_23_11;[
                # TODO: Add dependencies that must use the older nodejs version here
                nodejs
                # yarn
                # nodePackages.pnpm
              ]);
              # TODO: Select which package manager to use for your project and uncomment its "install" line
              # Do not run a new shell here, direnv and nix develop will do that for you
              shellHook = ''
                # npm install
                # yarn install
                # pnpm install

                echo -e "$(tput setaf 3)\n--- $(tput smso) WARNING $(tput rmso) ---\n"
                echo -e "Please open the newly created $(tput setaf 4)flake.nix$(tput setaf 3) file and have a look at the $(tput setaf 2)# TODO$(tput setaf 3) comments!\n"
                echo -e "Once you're done, remove the lines that printed these warnings from the shellHook."
                echo -e "$(tput setaf 3)\n-----------------\n$(tput sgr0)"
              '';
            };
      });
}


