{ inputs, pkgs, ... }:

{
  home.packages = [ inputs.zenvim.packages.${pkgs.system}.default ];
}
