default:
    echo 'Hello, world!'

up:
    nix flake update

test:
    nixos-rebuild --impure --flake . test |& nom 

switch:
    nixos-rebuild --impure --flake . switch |& nom && nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)

debug:
    nixos-rebuild --impure --flake --show-trace --verbose . switch |& nom

repl:
    nix repl -f flake:nixpkgs

clean:
    nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d && nix-collect-garbage --delete-old
