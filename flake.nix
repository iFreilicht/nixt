{
  description = "Nixt - super basic Nix flake templates";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    let
      systems = with flake-utils.lib.system; [
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
      in
      {
        devShell =
          pkgs.mkShell
            {
              buildInputs = with pkgs; [
                python3
              ];
              shellHook = ''
                FLAKE_ROOT="$(git rev-parse --show-toplevel)"
                (
                  cd "$FLAKE_ROOT"
                  if [ -d git-hooks ]; then
                    rm -f .git/hooks/*
                    cp git-hooks/* .git/hooks/
                  else
                    echo -e "$(tput setaf 3)\n--- $(tput smso) WARNING $(tput rmso) ---\n"
                    echo -e "Could not install git hooks, please cd into the nixt repository and run $(tput setaf 2)'direnv allow'$(tput setaf 3) or $(tput setaf 2)'nix develop'$(tput setaf 3) there.\n"
                    echo -e "Determined FLAKE_ROOT='$FLAKE_ROOT', but that doesn't seem to be the root of the nixt repository!"
                    echo -e "$(tput setaf 3)\n-----------------\n$(tput sgr0)"
                  fi
                )
              '';
            };
      });
}


