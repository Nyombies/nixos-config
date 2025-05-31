{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/sda2"; }
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
}
