# C (autotools) project

A simple environment for building C-libraries and applications that use autotools and make.

If the README of the project you want to build asks you to run these commands:

```sh
./autogen.sh
./configure
make
```

You'll likely want to use this template.

## Add nix to an existing project

```sh
nix flake init -t github:iFreilicht/nixt#c
direnv allow # or nix develop
```

## Create a new project with nix

This is just an example, remember to replace `project-name` with your desired project name.

```sh
git init project-name
cd project-name
nix flake init -t github:iFreilicht/nixt#c
direnv allow # or nix develop
```
