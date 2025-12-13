{ inputs, pkgs, ... }:

{
  home.packages = [ inputs.zenvim.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
