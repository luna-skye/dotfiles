{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.fish ];
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
}
