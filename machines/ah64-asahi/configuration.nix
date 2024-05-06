{ config, pkgs, ... }:
{
   # Asahi config
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ah64-asahi";
  networking.networkmanager.enable = true;

  services.xserver.xkbOptions = "ctrl:swapcaps";
}
