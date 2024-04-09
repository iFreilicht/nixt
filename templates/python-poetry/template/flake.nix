{
  description = "Python poetry project";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    let
      systems = with flake-utils.lib.system; [ x86_64-linux aarch64-linux x86_64-darwin aarch64-darwin ];
    in
    flake-utils.lib.eachSystem systems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell =
          pkgs.mkShell
            {
              buildInputs = [
                pkgs.poetry
              ];
              shellHook = ''
                if [ -f pyproject.toml ]; then
                  poetry env use python3;
                  source $(poetry env info --path)/bin/activate;
                  poetry install;
                else
                  echo -e "$(tput setaf 1)--- $(tput smso) ERROR $(tput rmso) ---\n"
                  echo -e "No pyproject.toml found!\n"
                  echo -e "To create a new project, delete this directory again, and follow the instructions at $(tput setaf 4)https://github.com/iFreilicht/nixt/blob/main/templates/python-poetry/README.md"
                  echo -e "$(tput setaf 1)\n---------------$(tput sgr0)"
                fi
              '';
            };
      });
}


