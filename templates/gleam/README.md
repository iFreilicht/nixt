# Empty project

If you want to do everything yourself, or create a new template in this repository, this is the template to use.

## Add nix to an existing project

```sh
nix flake init -t github:iFreilicht/nixt#gleam
direnv allow # or nix develop
```

## Create a new project with nix

This is just an example, remember to replace `project-name` with your desired project name.
A new gleam project will automatically be created for you.

```sh
git init project-name
cd project-name
nix flake init -t github:iFreilicht/nixt#gleam
direnv allow # or nix develop
```