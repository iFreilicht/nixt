# nixt, super basic Nix flake tempaltes

If you want to use [Nix](https://nixos.org/) in an existing project, or just get a basic project going from scratch without
any decisions being made on your behalf, these templates are for you.

There's no magic, just a `flake.nix` and `.envrc` for [direnv](https://direnv.net/) integration.

This allows you to automatically install and lock the dependencies of your project that you **can't** specify in your existing package manager,
— like the package manager itself, external tools like `awk` or `gnused`, or even tools from other language ecosystems —
without changing *anything else* about how your project is built or deployed.

## Getting started

Make sure you have Nix (and optionally direnv) installed and the experimental features `flakes` and `nix-command` enabled. *(TODO: add instructions for newcomers)*

Add a template to your existing repository (where `<template>` is the name of the template):

```
nix flake init -t github:iFreilicht/nixt#<template>
```

Then, **if you want to use direnv**, add `.direnv` to your `.gitignore` and run `direnv allow`.

Otherwise, **if you don't want to use direnv**, remove the generated `.envrc` file, and run `nix develop`.

When creating a new project from scratch, check [Docs for each template](#docs-for-each-template) to see specific instructions.

## Philosophy

Your (and your fellow contributors') first contact with Nix should be fun and enriching.
These templates are optimised for the usecase of adding Nix to an existing project in node, python or another language
that already has its own package managers.
Therefore, these templates only contain a `flake.nix` and an `.envrc` file and only define a `devShell` output that
gives you a reproducible development environment you can enter automatically with direnv or manually with `nix develop`.

While Nix can also be used as a tool for
[building](https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-build),
[containerizing](https://nixos.org/manual/nixpkgs/unstable/#sec-pkgs-dockerTools) or
[distributing](https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix#installables) your project and can even
[replace your language-specific package manager completely](https://nixos.org/manual/nixpkgs/unstable/#buildpythonapplication-function),
these are advanced usecases that you can discover later in your journey with Nix.

This means that, after adding the template of your choosing from this repo to your project with the instructions above:

* all external dependencies of your project can be locked and installed automatically
* the version of your package manager itself is locked, too (similar to [asdf-vm](https://asdf-vm.com/))
* the build and deployment process of your project does not change at all

