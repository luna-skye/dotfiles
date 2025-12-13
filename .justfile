# Build system generation, activate and make it the boot default
build:
  nh os switch .


# Build system generation, without activation or making it the boot default
dry:
  nh os test . --dry


# Build system generation, activate it, but don't make it boot default
test:
  nh os test .


# Checks that the flake successfully evaluates
check:
  nix flake check --no-build --show-trace .


# Checks that the flake successfully evaluates, aborts and shows trace on warning
check-trace:
  nix flake check --no-build --show-trace . --option abort-on-warn true


# Update all inputs
update:
  nix flake update


# Show all nix config profile history
profiles:
  nix profile history --profile /nix/var/nix/profiles/system


# Show all available generations
generations:
  nixos-rebuild list-generations


# Removes all generations older than one (1) week
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d


# Garbage collect unused nix store entries
gc:
  sudo nix-collect-garbage --delete-old


# Pull from git and display commit messages
pull:
  git pull --ff-only --log


# Open Nixpkgs in REPL
pkgs:
  nix repl -f flake:nixpkgs


# Open flake in REPL
repl:
  nix repl --expr 'builtins.getFlake "'$(pwd)'"'


# Generate files for a new NixOS host
new-host name:
  mkdir -p "./hosts/{{name}}"
  nixos-generate-config --dir "./hosts/{{name}}"
  mv "./hosts/{{name}}/hardware-configuration.nix" "./hosts/{{name}}/hardware.nix"
  cp "./.templates/host.nix" "./hosts/{{name}}/configuration.nix"
  sed -i "s/%name%/{{name}}/g" "./hosts/{{name}}/configuration.nix"


# Generate files for a new Home Manager user
new-user name:
  mkdir -p "./users/{{name}}"
  cp "./.templates/user.nix" "./users/{{name}}/default.nix"
  sed -i "s/%name%/{{name}}/g" "./users/{{name}}/default.nix"
