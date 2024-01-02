{ config, pkgs, ... }:
{
  networking.hostName = "ah64-thelio";
  services.xserver.videoDrivers = [ "nvidia" ];
  # OpenGL
  hardware.opengl.enable = true;

  nix.buildMachines = [
    {
      hostName = "flyingbrick";
      system = "aarch64-linux";
      maxJobs = 16;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [ ];
    }
  ];

  nix.distributedBuilds = true;
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = [ pkgs.cudatoolkit ];
}
