# deploy dotfiles for current host
build:
  @sudo nixos-rebuild switch --flake .


# deploy dotfiles for current host but with a headache
debug:
  @sudo nixos-rebuild switch --flake . --show-trace --verbose


# quick deploy without rebuild nix system
test:
  @sudo nixos-rebuild switch --fast --flake .


# checks that the dotfiles flake successfully evaluates
check:
  @nix flake check --no-build --show-trace .


# update nix flake inputs
update:
  @nix flake update


# show all nix config profile history
history:
  @nix profile history --profile /nix/var/nix/profiles/system


# removes all generations older than one (1) week
clean:
  @sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d


# garbage collect unused nix store entries
gc:
  @sudo nix-collect-garbage --delete-old


# open nixpkgs flake in Nix REPL
pkgs:
  @nix repl -f flake:nixpkgs


# open this flake in Nix REPL
repl:
  @nix repl --expr 'builtins.getFlake "'$(pwd)'"'
