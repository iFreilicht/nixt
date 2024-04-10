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
    (flake-utils.lib.eachSystem systems
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShell =
            pkgs.mkShell
              {
                buildInputs = with pkgs; [
                  (python3.withPackages
                    (ps: with ps; [ semver ]))
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
        }) //
    (
      let
        nextStepsText = ''

            Next steps:

            1. If you're in a git repository:
              - Add `.direnv` to your `.gitignore` file
              - Run `git add flake.nix`, otherwise the next step *will fail*!
            3. Decide whether you want to use direnv or not and then either:
              - run `direnv allow` to always enable the environment when you enter the project directory
              - run `nix develop` to enable the environment manually
            4. Follow the instructions that will be presented to you after entering the environment
        '';
      in
      {
        templates = {

          empty = {
            path = ./templates/empty/template;
            description = "Empty project";
            welcomeText = ''
              __You just added Nix to your project!__
            ''
            + nextStepsText;
          };

          python-poetry = {
            path = ./templates/python-poetry/template;
            description = "Python project with poetry";
            welcomeText = ''
              __You just added Nix to your python project!__
            ''
            + nextStepsText;
          };

          nodejs_21 = {
            path = ./templates/node/nodejs_21/template;
            description = "Node.js project with node 21";
            welcomeText = ''
              __You just added Nix to your Node.js project!__
            ''
            + nextStepsText;
          };
        };
      }
    )
    );
}


