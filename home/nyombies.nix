{ config, pkgs, ... }:

{
  home.username = "nyombies";
  home.homeDirectory = "/home/nyombies";

  # Starship Prompt
programs.starship = {
  enable = true;
  settings = {
  format = "[](#e74c3c)$username[](fg:#e74c3c bg:#2ecc71 bold)$directory[](fg:#2ecc71 bg:#3498db bold)$git_branch[](fg:#3498db bg:#d0d0d0 bold)$git_status[](fg:#d0d0d0 bg:#a0a0a0 bold)$c$elixir$elm$golang$gradle$haskell$java$julia$nodejs$nim$rust$scala[](fg:#a0a0a0 bg:#707070 bold)$docker_context[](fg:#707070 bg:#404040 bold)$time[](fg:#404040)";

username = {
  show_always = true;
  style_user = "bg:#e74c3c fg:#000000 bold";
  style_root = "bg:#e74c3c fg:#000000 bold";
  format = "[$user]($style)";
  disabled = false;
};

os = {
  disabled = true;
  format = "[󰣇 ]($style)";
  style = "bg:#e74c3c fg:#000000 bold";
};

    directory = {
      style = "bg:#2ecc71 fg:#000000 bold";
      format = "[$path]($style)";
      truncation_length = 3;
      truncation_symbol = "…/";
      substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
      };
    };

    git_branch = {
      symbol = "";
      style = "bg:#3498db fg:#000000 bold";
      format = "[$symbol $branch]($style)";
    };

    git_status = {
      style = "bg:#d0d0d0 fg:#000000 bold";
      format = "[$all_status$ahead_behind]($style)";
    };

    c = {
      symbol = " ";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    elixir = {
      symbol = " ";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    elm = {
      symbol = " ";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    golang = {
      symbol = " ";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    gradle = {
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    haskell = {
      symbol = " ";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    java = {
      symbol = " ";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    julia = {
      symbol = " ";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    nodejs = {
      symbol = "";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    nim = {
      symbol = "󰆥 ";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    rust = {
      symbol = "";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    scala = {
      symbol = " ";
      style = "bg:#a0a0a0 fg:#000000 bold";
      format = "[$symbol ($version)]($style)";
    };

    docker_context = {
      symbol = " ";
      style = "bg:#707070 fg:#ffffff bold";
      format = "[$symbol $context]($style)";
    };

    time = {
      disabled = false;
      time_format = "%R";
      style = "bg:#404040 fg:#ffffff bold";
      format = "[♥ $time]($style)";
    };
  };
};

  # Bash
  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(starship init bash)"
    '';
  };

  # Packages
  home.packages = with pkgs; [
    neofetch
    kitty
    firefox
    waybar
    wofi
    dunst
    brightnessctl
    pavucontrol
    networkmanagerapplet
    hyprpaper
    grim slurp wl-clipboard
    libnotify
    alsa-utils
    discord
    webcord
    nerdfonts
    papirus-icon-theme
    hyprlock
    cliphist
  ];

  # Dunst notification daemon
  services.dunst.enable = true;

  # Bashrc with neofetch
  home.file.".bashrc".text = ''
    neofetch
  '';

  # Kitty Terminal Config
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    extraConfig = ''
      background #0a0a0a
      foreground #d0d0d0
      background_opacity 0.95
      cursor #ff2a2a
      hide_window_decorations yes
      enable_audio_bell no
      confirm_os_window_close 0
      window_padding_width 12
      window_padding_height 10

      color0 #000000
      color1 #ff2a2a
      color2 #5f875f
      color3 #af875f
      color4 #2a2a2a
      color5 #ba007c
      color6 #ff2a2a
      color7 #c0c0c0
      color8  #3a3a3a
      color9  #ff5f5f
      color10 #87af87
      color11 #ffd787
      color12 #5f87af
      color13 #af87af
      color14 #ff8700
      color15 #ffffff
    '';
  };

  # GTK icon theme
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # Waybar config
  xdg.configFile."waybar/config".source = ./waybar/config;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;

  # Home Manager state version
  home.stateVersion = "24.05";
}
