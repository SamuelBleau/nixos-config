{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    font.size = 12;
    
    settings = {
      background_opacity = "0.80";
      confirm_os_window_close = 0;
      
      # Deep Purple theme colors - more violet focused
      foreground = "#e4e4e7";
      background = "#0f0b1a";
      selection_foreground = "#0f0b1a";
      selection_background = "#8b5cf6";
      
      # Cursor colors - bright violet
      cursor = "#c084fc";
      cursor_text_color = "#0f0b1a";
      
      # URL underline color when hovering
      url_color = "#a855f7";
      
      # Kitty window border colors - strong violet
      active_border_color = "#6b21a8";
      
      # Tab bar colors - violet gradient
      active_tab_foreground = "#f8fafc";
      active_tab_background = "#7c3aed";
      inactive_tab_foreground = "#a1a1aa";
      inactive_tab_background = "#3b1764";
      tab_bar_background = "#0f0b1a";
      
      # Colors for marks (selected text) - purple shades
      mark1_foreground = "#0f0b1a";
      mark1_background = "#a855f7";
      mark2_foreground = "#0f0b1a";
      mark2_background = "#c084fc";
      mark3_foreground = "#0f0b1a";
      mark3_background = "#ddd6fe";
      
      # The 16 terminal colors - enhanced purple palette
      
      # Black - deep purple
      color0 = "#0f0b1a";
      color8 = "#6b21a8";
      
      # Red - purple-tinted
      color1 = "#e879f9";
      color9 = "#f0abfc";
      
      # Green - purple-green
      color2 = "#a78bfa";
      color10 = "#c4b5fd";
      
      # Yellow - purple-yellow
      color3 = "#d8b4fe";
      color11 = "#e9d5ff";
      
      # Blue - purple-blue
      color4 = "#8b5cf6";
      color12 = "#a855f7";
      
      # Magenta/Purple - core purple
      color5 = "#7c3aed";
      color13 = "#8b5cf6";
      
      # Cyan - purple-cyan
      color6 = "#c084fc";
      color14 = "#ddd6fe";
      
      # White - light purple tint
      color7 = "#e4e4e7";
      color15 = "#f1f5f9";
      
      # Window styling - enhanced borders
      window_padding_width = 10;
      window_border_width = 3;
      draw_minimal_borders = true;
      window_margin_width = 2;
      single_window_margin_width = 2;
      
      # Tab styling - purple powerline
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
  };
}
