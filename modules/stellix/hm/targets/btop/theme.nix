{ lib, colors }: let
  colPrimary   = lib.attrsets.attrByPath [ "accent" colors.primary   ] "#FF0000" colors;
  colSecondary = lib.attrsets.attrByPath [ "accent" colors.secondary ] "#FF0000" colors;
in ''
# Theme: STELLIX
# By: STELLIX Nix Themes (written by Luna Skye)

# Main background, empty for terminal default, need to be empty if you want transparent background
theme[main_bg]="${colors.surface.crust}"

# Main text color
theme[main_fg]="${colors.surface.subtext0}"

# Title color for boxes
theme[title]="${colors.surface.subtext1}"

# Highlight color for keyboard shortcuts
theme[hi_fg]="${colPrimary}"

# Background color of selected item in processes box
theme[selected_bg]="${colPrimary}"

# Foreground color of selected item in processes box
theme[selected_fg]="${colors.surface.text}"

# Color of inactive/disabled text
theme[inactive_fg]="${colors.surface.overlay0}"

# Color of text appearing on top of graphs, i.e uptime and current network graph scaling
theme[graph_text]="${colors.surface.subtext0}"

# Background color of the percentage meters
theme[meter_bg]="${colors.surface.surface1}"

# Misc colors for processes box including mini cpu graphs, details memory graph and details status text
theme[proc_misc]="${colPrimary}"

# Cpu box outline color
theme[cpu_box]="${colPrimary}"

# Memory/disks box outline color
theme[mem_box]="${colSecondary}"

# Net up/down box outline color
theme[net_box]="${colors.accent.lightRed}"

# Processes box outline color
theme[proc_box]="${colors.accent.lightBlue}"

# Box divider line and small boxes line color
theme[div_line]="${colors.surface.overlay1}"

# Temperature graph colors
theme[temp_start]="${colors.accent.lightGreen}"
theme[temp_mid]="${colors.accent.lightYellow}"
theme[temp_end]="${colors.accent.lightRed}"

# CPU graph colors
theme[cpu_start]="${colors.accent.lightGreen}"
theme[cpu_mid]="${colors.accent.lightYellow}"
theme[cpu_end]="${colors.accent.lightRed}"

# Mem/Disk free meter
theme[free_start]="#ffa6d9"
theme[free_mid]="#ff79c6"
theme[free_end]="#ff33a8"

# Mem/Disk cached meter
theme[cached_start]="#b1f0fd"
theme[cached_mid]="#8be9fd"
theme[cached_end]="#26d7fd"

# Mem/Disk available meter
theme[available_start]="#ffd4a6"
theme[available_mid]="#ffb86c"
theme[available_end]="#ff9c33"

# Mem/Disk used meter
theme[used_start]="#96faaf"
theme[used_mid]="#50fa7b"
theme[used_end]="#0dfa49"

# Download graph colors
theme[download_start]="${colors.accent.lightGreen}"
theme[download_mid]="${colors.accent.lightYellow}"
theme[download_end]="${colors.accent.lightRed}"

# Upload graph colors
theme[upload_start]="${colors.accent.lightGreen}"
theme[upload_mid]="${colors.accent.lightYellow}"
theme[upload_end]="${colors.accent.lightRed}"

# Process box color gradient for threads, mem and cpu usage
theme[process_start]="${colors.accent.lightGreen}"
theme[process_mid]="${colors.accent.lightYellow}"
theme[process_end]="${colors.accent.lightRed}"
''
