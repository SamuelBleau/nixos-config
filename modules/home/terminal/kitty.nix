{ config, pkgs, lib, theme, ... }:

with lib;

{
  programs.kitty = mkIf (config.meeast.terminal.default == "kitty") {
    enable = true;
    
    font = {
      name = "Hack Nerd Font";
      size = 12;
    };
    
    settings = {
      # Rat color scheme
      foreground = theme.text.primary;
      background = theme.ui.background;
      selection_foreground = theme.ui.background;
      selection_background = theme.primary.purple;
      
      # Cursor colors
      cursor = theme.primary.purple;
      cursor_text_color = theme.ui.background;
      cursor_shape = "block";
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15.0";
      
      # URL colors
      url_color = theme.primary.purpleDark;
      url_style = "single";
      
      # Border and window
      window_border_width = "2px";
      window_margin_width = 8;
      window_padding_width = 12;
      active_border_color = theme.primary.purple;
      inactive_border_color = theme.ui.border;
      bell_border_color = theme.status.warning;
      
      # Transparency and blur
      background_opacity = toString config.meeast.terminal.opacity;
      background_blur = 20;
      dynamic_background_opacity = true;
      
      # Tab styling
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_bar_min_tabs = 2;
      tab_switch_strategy = "previous";
      tab_fade = "0.25 0.5 0.75 1";
      tab_separator = " ┇";
      tab_powerline_style = "slanted";
      tab_activity_symbol = "🐀";
      tab_title_template = " {fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title} ";
      
      # Tab colors
      active_tab_foreground = theme.ui.background;
      active_tab_background = theme.primary.purple;
      active_tab_font_style = "bold";
      inactive_tab_foreground = theme.text.secondary;
      inactive_tab_background = theme.ui.surface;
      inactive_tab_font_style = "normal";
      tab_bar_background = theme.ui.background;
      tab_bar_margin_color = theme.ui.background;
      
      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
      
      # Bell
      enable_audio_bell = false;
      visual_bell_duration = "0.1";
      visual_bell_color = theme.status.warning;
      window_alert_on_bell = true;
      bell_on_tab = "🔔 ";
      command_on_bell = "none";
      
      # Mouse
      mouse_hide_wait = "3.0";
      focus_follows_mouse = false;
      pointer_shape_when_grabbed = "arrow";
      default_pointer_shape = "beam";
      pointer_shape_when_dragging = "beam";
      
      # Terminal behavior
      term = "xterm-kitty";
      shell_integration = "enabled";
      allow_remote_control = true;
      update_check_interval = 0;
      # Startup session
      startup_session = "~/.config/kitty/startup.session";
      clipboard_control = "write-clipboard write-primary read-clipboard-ask read-primary-ask";
      clipboard_max_size = 512;
      
      # Scrollback
      scrollback_lines = 10000;
      scrollback_pager = "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
      scrollback_pager_history_size = 0;
      scrollback_fill_enlarged_window = false;
      wheel_scroll_multiplier = "5.0";
      wheel_scroll_min_lines = 1;
      touch_scroll_multiplier = "1.0";
      
      # Advanced
      editor = "nvim";
      close_on_child_death = false;
      allow_hyperlinks = true;
      term_no_mouse = false;
      copy_on_select = false;
      strip_trailing_spaces = "never";
      select_by_word_characters = "@-./_~?&=%+#";
      click_interval = "0.5";
      mouse_map = "middle release ungrabbed paste_from_clipboard";
      
      # Window management
      remember_window_size = true;
      initial_window_width = 100;
      initial_window_height = 30;
      enabled_layouts = "tall:bias=50;full_size=1;mirrored=false";
      window_resize_step_cells = 2;
      window_resize_step_lines = 2;
      window_logo_path = "none";
      window_logo_position = "bottom-right";
      window_logo_alpha = "0.5";
      resize_debounce_time = "0.1";
      resize_draw_strategy = "static";
      resize_in_steps = false;
      confirm_os_window_close = 0;
      
      # Color palette (16 colors)
      color0 = theme.ui.background; # black
      color1 = theme.status.error; # red
      color2 = theme.status.success; # green
      color3 = theme.status.warning; # yellow
      color4 = theme.primary.purpleDark; # blue / dark purple
      color5 = theme.primary.purple; # magenta / purple
      color6 = theme.primary.gray; # cyan / gray
      color7 = theme.text.primary; # white
      color8 = theme.ui.surface; # bright black
      color9 = theme.status.error; # bright red
      color10 = theme.status.success; # bright green
      color11 = theme.status.warning; # bright yellow
      color12 = theme.primary.purpleDark; # bright blue / dark purple
      color13 = theme.primary.purple; # bright magenta
      color14 = theme.primary.gray; # bright cyan
      color15 = theme.text.primary; # bright white
    };
    
    keybindings = {
      # Navigation
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+q" = "close_os_window";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+." = "move_tab_forward";
      "ctrl+shift+," = "move_tab_backward";
      "ctrl+shift+alt+t" = "set_tab_title";
      
      # Windows
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+n" = "new_os_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+f" = "move_window_forward";
      "ctrl+shift+b" = "move_window_backward";
      "ctrl+shift+`" = "move_window_to_top";
      "ctrl+shift+r" = "start_resizing_window";
      "ctrl+shift+1" = "first_window";
      "ctrl+shift+2" = "second_window";
      "ctrl+shift+3" = "third_window";
      "ctrl+shift+4" = "fourth_window";
      "ctrl+shift+5" = "fifth_window";
      "ctrl+shift+6" = "sixth_window";
      "ctrl+shift+7" = "seventh_window";
      "ctrl+shift+8" = "eighth_window";
      "ctrl+shift+9" = "ninth_window";
      "ctrl+shift+0" = "tenth_window";
      
      # Font size
      "ctrl+shift+equal" = "change_font_size all +2.0";
      "ctrl+shift+plus" = "change_font_size all +2.0";
      "ctrl+shift+minus" = "change_font_size all -2.0";
      "ctrl+shift+backspace" = "change_font_size all 0";
      
      # Clipboard
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "shift+insert" = "paste_from_selection";
      "ctrl+shift+o" = "pass_selection_to_program firefox";
      
      # Scrolling
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+j" = "scroll_line_down";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";
      "ctrl+shift+h" = "show_scrollback";
      
      # Search
      "ctrl+shift+g" = "show_last_command_output";
      "ctrl+shift+/" = "launch --location=hsplit --allow-remote-control kitty +kitten search";
      
      # Miscellaneous
      "ctrl+shift+f11" = "toggle_fullscreen";
      "ctrl+shift+f10" = "toggle_maximized";
      "ctrl+shift+u" = "kitten unicode_input";
      "ctrl+shift+f2" = "edit_config_file";
      "ctrl+shift+escape" = "kitty_shell window";
      "ctrl+shift+a>m" = "set_background_opacity +0.1";
      "ctrl+shift+a>l" = "set_background_opacity -0.1";
      "ctrl+shift+a>1" = "set_background_opacity 1";
      "ctrl+shift+a>d" = "set_background_opacity default";
      "ctrl+shift+delete" = "clear_terminal reset active";
    };
  };
  
  # Create custom shell prompt for Rat theme
  home.file.".config/kitty/rat-startup.sh" = {
    text = ''
      #!/usr/bin/env bash
      
      # Rat terminal startup script
      clear
      
    '';
    executable = true;
  };

  # Create startup session file
  home.file.".config/kitty/startup.session".text = ''
    # Kitty startup session - run Rat script
    launch zsh -c "~/.config/kitty/rat-startup.sh; exec zsh"
  '';
}
