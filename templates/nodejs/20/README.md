# nodejs.20

## Add nix to an existing project

```sh
nix flake init -t github:iFreilicht/nixt#nodejs.20
direnv allow # or nix develop
```

## Create a new project with nix

This is just an example, remember to replace `project-name` with your desired project name.

```sh
git init project-name
cd project-name
nix flake init -t github:iFreilicht/nixt#nodejs.20
direnv allow # or nix develop
```

You will be able to select which package manager to use after entering the environment for the first time.