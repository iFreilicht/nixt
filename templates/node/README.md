# Templates for most versions of node

All of these work the same:

## Add nix to an existing project

```sh
nix flake init -t github:iFreilicht/nixt#nodejs_21
direnv allow # or nix develop
```

## Create a new project with nix

This is just an example, remember to replace `project-name` with your desired project name.

```sh
git init project-name
cd project-name
nix flake init -t github:iFreilicht/nixt#nodejs_21
direnv allow # or nix develop
```

You will be able to select which package manager to use after entering the environment for the first time.

## Searching nixpkgs for node versions

Make sure you have a full copy of the nixpkgs git repository cloned. Assuming it's `~/repos/nixpkgs`, run:

```sh
$ ./search_node_versions.py ~/repos/nixpkgs
```

Last time I ran it, the output was:

```
Release branches to select:
nodejs_0: origin/release-15.09
nodejs_4: origin/release-17.09
nodejs_5: origin/release-16.03
nodejs_6: origin/release-18.09
nodejs_8: origin/release-18.09
nodejs_7: origin/release-17.03
nodejs_9: origin/release-18.03
nodejs_10: origin/release-21.05
nodejs_11: origin/release-19.03
nodejs_12: origin/release-21.11
nodejs_13: origin/release-20.03
nodejs_14: origin/release-22.11
nodejs_16: origin/release-23.05
nodejs_17: origin/release-21.11
nodejs_18: origin/release-23.11
nodejs_19: origin/release-22.11
nodejs_20: origin/release-23.11
nodejs_21: origin/release-23.11
```