{ config, lib, bead, pkgs, ... }: let
  cfg = config.bead.cli.btop;
  mkGraphSymbolOption = graphName: bead.mkEnumOption [ "default" "braille" "block" "tty" ] "tty" "Symbol type to render ${graphName} graphs with";
in {
  imports = [];


  options.bead.cli.btop = {
    updateRate = bead.mkNumberOption 100 "Metric polling speed in milliseconds";

    graphSymbol = {
      default = bead.mkEnumOption [ "braille" "block" "tty" ] "tty" "Symbol type to render default graphs with";

      cpu = mkGraphSymbolOption "default";
      mem = mkGraphSymbolOption "default";
      net = mkGraphSymbolOption "default";
      proc = mkGraphSymbolOption "default";
    };

    processes = {
      sorting = bead.mkEnumOption [ "pid" "program" "arguments" "threads" "user" "memory" "cpu lazy" "cpu responsive" ]
                "cpu lazy"
                "The default process sorting on startup";
      reversed = bead.mkBooleanOption false "Whether to default to reverse sorting proc list on startup";
      tree = bead.mkBooleanOption false "Whether to default to tree view mode for proc list on startup";

      colors = bead.mkBooleanOption true "Whether to enable process colors by default on startup";
      gradient = bead.mkBooleanOption true "Whether to enable gradients on process names by default on startup";

      perCore = bead.mkBooleanOption true "Whether cpu usage should be for the core the process is running from, or all available cores";
      memBytes = bead.mkBooleanOption true "Whether to display memory as bytes instead of percentage";
    };
  };


  config = {
    programs.btop = {
      settings = {
        update_ms = lib.mkDefault cfg.updateRate;

        graph_symbol      = lib.mkDefault cfg.graphSymbol.default;
        graph_symbol_cpu  = lib.mkDefault cfg.graphSymbol.cpu;
        graph_symbol_mem  = lib.mkDefault cfg.graphSymbol.mem;
        graph_symbol_net  = lib.mkDefault cfg.graphSymbol.net;
        graph_symbol_proc = lib.mkDefault cfg.graphSymbol.proc;

        cpu_graph_upper  = lib.mkDefault "user";
        cpu_graph_lower  = lib.mkDefault "system";
        cpu_invert_lower = lib.mkDefault true;

        proc_sorting   = cfg.process.sorting;
        proc_reversed  = cfg.process.reversed;
        proc_tree      = cfg.process.tree;
        proc_colors    = cfg.process.colors;
        proc_gradient  = cfg.process.gradient;
        proc_per_core  = cfg.process.perCore;
        proc_mem_bytes = cfg.process.memBytes;
      };
    };
  };
}
