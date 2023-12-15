{ config, pkgs, ... }:
{
  networking.hostName = "ah64-xps";
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.cudaSupport = true;
  environment.systemPackages = [ pkgs.cudatoolkit ];
}
