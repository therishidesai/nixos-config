{ config, pkgs, ... }:
{
  networking.hostName = "ah64-xps";
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.cudaSupport = true;
  environment.systemPackages = [ pkgs.cudatoolkit ];
  hardware.opengl.enable = false;
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  services.xserver.xkbOptions = "ctrl:swapcaps";
}
