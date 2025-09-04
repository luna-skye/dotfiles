{ osConfig, lib, pkgs, ... }:

let
  hostCfg = osConfig.zen.apps.gaming;
  inherit (lib.lists) optional;

in {
  config = lib.mkIf (hostCfg.enable) {
    home.packages =
      optional (hostCfg.steam.enable)              pkgs.protontricks  ++
      optional (hostCfg.lutris.enable)             pkgs.lutris        ++
      optional (hostCfg.r2modman.enable)           pkgs.r2modman      ++

      optional (hostCfg.minecraft.atl.enable)      pkgs.atlauncher    ++
      optional (hostCfg.minecraft.prism.enable)    pkgs.prismlauncher ++
      optional (hostCfg.minecraft.modrinth.enable) pkgs.modrinth-app  ++
      builtins.attrValues { inherit (pkgs) 
        gamescope
        vulkan-tools
        libdrm
        ;
      } ++ [ pkgs.xorg.xrandr ];

    programs.mangohud = lib.mkIf (hostCfg.mangohud.enable) {
      enable = true;
      settings = {
        time = true;
        fps_limit = 165;
        fps_limit_method = "early";

        gpu_stats = true;
        gpu_temp = true;
        gpu_junction_temp = true;
        gpu_core_clock = true;
        gpu_mem_temp = true;
        gpu_mem_clock = true;
        gpu_load_change = true;
        gpu_load_value = "60,90";
        gpu_load_color = "39F900,FDFD09,B22222";
        gpu_fan = true;
        vram = true;

        cpu_stats = true;
        cpu_temp = true;
        # cpu_power = true; # doesn't seem to be working
        cpu_mhz = true;
        cpu_load_change = true;
        cpu_load_value = "60,90";
        cpu_load_color = "39F900,FDFD09,B22222";

        ram = true;
        swap = true;

        fps = true;
        fps_color_change = true;
        fps_value = "30,60";
        fps_color= "B22222,FDFD09,39F900";
        frametime = true;
        frame_timing = true;

        throttling_status_graph = true;

        font_size = 18;
        font_size_text = 14;
        round_corners = 4;
        cellpadding_y = 0.1;
        output_folder = "~/Documents/mangohud/";
      } // hostCfg.mangohud.settings;
    };
  };
}
