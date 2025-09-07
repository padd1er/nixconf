default:
    just --list --unsorted

backup:
    cp flake.lock flake.lock-bak_$(date +'%Y-%m-%d_%H-%M-%S')

revert:
    mv "$(ls -1t flake.lock-bak* | head -n 1)" flake.lock

update: backup
    nix flake update

test:
    nixos-rebuild --flake . test |& nom

build:
    nixos-rebuild --flake . build |& nom

switch:
    nixos-rebuild --flake . switch |& nom && nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)

debug:
    nixos-rebuild --flake --show-trace --verbose . switch |& nom

repl:
    nix repl -f flake:nixpkgs

clean:
    nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d && nix-collect-garbage --delete-old
