#!/usr/bin/env python3

import sys
import subprocess as sp
import pathlib
import pprint
from dataclasses import dataclass
from semver import Version


@dataclass
class NodeVersion:
    file: str
    branch: str
    semver: Version

target_path = pathlib.Path(sys.argv[1])

if not target_path.exists() or not target_path.is_dir():
    print(f"Nixpkgs path {target_path} does not exist or is not a directory!")
    sys.exit(1)


# This path has been valid since release-13.10, which is the oldest release branch I could find in the repo
KNOWN_NODEJS_PATH = "./pkgs/development/web/nodejs"

# List all release branches
branches = sp.check_output(['git', 'branch', '-r', '--list', 'origin/release-*'], cwd=target_path).decode('utf-8').splitlines()
branches = [branch.strip() for branch in branches]

# Ensure the working tree is clean
git_status = sp.check_output(['git', 'status'], cwd=target_path).decode('utf-8')

if not "nothing to commit, working tree clean" in git_status:
    print(f"Working tree of {target_path} is not clean, please do what you must so it is!")
    sys.exit(1)


highest_versions = {}
for branch in branches:
    print(f"Branch: {branch}")
    # Checkout the branch
    sp.run(['git', 'checkout', branch], cwd=target_path, stdout=sp.DEVNULL, stderr=sp.DEVNULL, check=True)

    # Check if the nodejs package exists in the branch
    nodejs_path = target_path / KNOWN_NODEJS_PATH
    if not nodejs_path.exists():
        print(f"Path {KNOWN_NODEJS_PATH} does not exist in branch {branch}")
        continue

    # Get all available versions of nodejs in the branch with grep "version =" ./pkgs/development/web/nodejs/*
    try:
        raw_versions = sp.check_output(['egrep', '^\s*version = "'] + list(nodejs_path.glob('*'))).decode('utf-8').splitlines()
    except sp.CalledProcessError:
        print(f"Failed to get versions in branch {branch}\n")
        continue


    # Parse all versions in this branch
    versions_in_branch = []
    for version in raw_versions:
        [file, version] = version.split(": ")
        file = pathlib.Path(file).name
        version = version.strip().strip('version = ').strip(';').strip('"')
        if not Version.is_valid(version):
            print(f"Invalid version found in {file}: {version}")
            continue
        versions_in_branch.append(NodeVersion(file, branch, Version.parse(version)))

    # Update or create the highest versions for each major version
    for version in versions_in_branch:
        major = version.semver.major
        if highest_versions.get(major) is None or version.semver > highest_versions[major].semver:
            highest_versions[major] = version

    # Print the versions in this branch
    print("Versions:")
    for version in versions_in_branch:
        print(f"{version.file}: {version.semver}")

    print("\n")

print("\n---\n\n")
print("Highest versions (debug):")
pprint.pp(highest_versions)

print("\n\n---\n\n")

print("Release branches to select:")
for major, version in sorted(highest_versions.items(), key=lambda x: x[0]):
    print(f"nodejs_{major}:\t{version.branch}\t({version.semver})")