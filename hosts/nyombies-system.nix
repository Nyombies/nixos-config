{ config, pkgs, ... }:

let
  themePath = ../themes/chili;
in {
  imports = [
    ../hardware-configuration.nix
  ];

  # Your config continues...
  environment.etc."sddm/themes/chili" = {
    source = themePath;
  };

  services.displayManager.sddm = {
    enable = true;
    theme = "chili";
  };

  networking.hostName = "nyombies";
  time.timeZone = "Europe/London";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # Enable basic networking
  networking.networkmanager.enable = true;

  # Optional: disable firewall during testing
  # services.networking.firewall.enable = false;

  # Ensure firmware is available for wireless/Bluetooth/etc.
  hardware.enableRedistributableFirmware = true;

  # Wayland and desktop session
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Let NetworkManager GUI work under Plasma
  programs.nm-applet.enable = true;

  #enable hyprland
  programs.hyprland = {
  enable = true;
   xwayland.enable = true;
   };

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    networkmanager
    networkmanagerapplet
    hyprland
    firefox
    kitty
    waybar
    rofi
    swww
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
    alsa-utils
  ];

  users.users.nyombies = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.bash;
  };

  system.stateVersion = "24.05";
  sound.enable = true;

  hardware.pulseaudio.enable = false;

services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
};

hardware.opengl.enable = true;
hardware.opengl.extraPackages = with pkgs; [
  vaapiIntel
  vaapiVdpau
  libvdpau
  intel-media-driver
];


  boot.kernelModules = [ "snd_hda_intel" ];

}
