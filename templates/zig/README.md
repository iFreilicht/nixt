# zig

## Add nix to an existing project

```sh
nix flake init -t github:iFreilicht/nixt#zig
direnv allow # or nix develop
```

## Create a new project with nix

Based on [zig's Gettings Started Guide](https://ziglang.org/learn/getting-started)

```sh
mkdir hello-world
cd hello-world
nix run nixpkgs#zig init
nix flake init -t github:iFreilicht/nixt#zig
direnv allow # or nix develop
```