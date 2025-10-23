# Templates for most versions of node

> *NOTE:* Most newer versions are supported right now. 13 and below don't evaluate locally, I'll have to fix that later.

Run `nix flake show github:iFreilicht/nixt` for a list of available versions.

All of these work the same:

## Add nix to an existing project

```sh
nix flake init -t github:iFreilicht/nixt#nodejs.21
direnv allow # or nix develop
```

## Create a new project with nix

This is just an example, remember to replace `project-name` with your desired project name.

```sh
git init project-name
cd project-name
nix flake init -t github:iFreilicht/nixt#nodejs.21
direnv allow # or nix develop
```

You will be able to select which package manager to use after entering the environment for the first time.

## Searching nixpkgs for node versions

Unfortunately, all resources I know off for searching nixpkgs by version are either offline or out-of-date.
So I wrote a script that does this.

Make sure you have a full copy of the nixpkgs git repository cloned. Assuming it's `~/repos/nixpkgs`, run:

```sh
$ ./search_node_versions.py ~/repos/nixpkgs
```

Last time I ran it, the output was:

```
Release branches to select:
nodejs_0:       origin/release-15.09    (0.12.7)
nodejs_4:       origin/release-17.09    (4.8.7)
nodejs_5:       origin/release-16.03    (5.9.0)
nodejs_6:       origin/release-18.09    (6.17.0)
nodejs_7:       origin/release-17.03    (7.10.1)
nodejs_8:       origin/release-18.09    (8.15.1)
nodejs_9:       origin/release-18.03    (9.11.2)
nodejs_10:      origin/release-21.05    (10.24.1)
nodejs_11:      origin/release-19.03    (11.14.0)
nodejs_12:      origin/release-21.11    (12.22.12)
nodejs_13:      origin/release-20.03    (13.8.0)
nodejs_14:      origin/release-22.11    (14.21.3)
nodejs_16:      origin/release-23.05    (16.20.2)
nodejs_17:      origin/release-21.11    (17.7.2)
nodejs_18:      origin/release-24.11    (18.20.8)
nodejs_19:      origin/release-22.11    (19.6.1)
nodejs_20:      origin/release-25.05    (20.19.5)
nodejs_21:      origin/release-23.11    (21.7.2)
nodejs_22:      origin/release-25.05    (22.19.0)
nodejs_23:      origin/release-24.11    (23.11.1)
nodejs_24:      origin/release-25.05    (24.9.0)
```