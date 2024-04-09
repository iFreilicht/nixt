# python-poetry

## Add nix to an existing project

```sh
nix flake init -t github:iFreilicht/nixt#python-poetry
direnv allow # or nix develop
```

## Create a new project with nix

This is just an example, be sure to check out the docs of [`poetry new`](https://python-poetry.org/docs/cli/#new)
and remember to replace `project-name` with your desired project name.

```sh
nix run nixpkgs#poetry -- new --src project-name
cd project-name
git init
nix flake init -t github:iFreilicht/nixt#python-poetry
direnv allow # or nix develop
```