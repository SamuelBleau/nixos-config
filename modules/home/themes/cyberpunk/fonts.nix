{ config, pkgs, lib, ... }:

{
  # Cyberpunk fonts configuration
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    # Primary cyberpunk fonts
    jetbrains-mono    # Terminal and code
    # orbitron         # UI elements (futuristic) - commented out as package might not exist
    
    # Supporting fonts
    noto-fonts
    noto-fonts-emoji
    font-awesome
    liberation_ttf
    
    # Icon fonts for waybar
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    
    # Additional cyberpunk-style fonts
    fira-code        # Alternative code font with ligatures
    source-code-pro  # Clean monospace
  ];
  
  # Font configuration
  home.file.".config/fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <!-- Cyberpunk font preferences -->
      <alias>
        <family>monospace</family>
        <prefer>
          <family>JetBrains Mono</family>
          <family>Fira Code</family>
          <family>Source Code Pro</family>
        </prefer>
      </alias>
      
      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>Noto Sans</family>
        </prefer>
      </alias>
      
      <!-- Enable ligatures for supported fonts -->
      <match target="font">
        <test name="family" compare="eq">
          <string>JetBrains Mono</string>
        </test>
        <edit name="fontfeatures" mode="append">
          <string>liga on</string>
          <string>calt on</string>
        </edit>
      </match>
    </fontconfig>
  '';
}