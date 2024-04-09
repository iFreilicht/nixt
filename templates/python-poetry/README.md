# python-poetry

## Add nix to an existing project

```sh
nix init -t github:iFreilicht/nixt#python-poetry
direnv allow # or nix develop
```

## Create a new project with nix

```sh
nix run nixpkgs#poetry -- new --src project-name
cd project-name
nix flake init -t github:iFreilicht/nixt#python-poetry
direnv allow # or nix develop
```