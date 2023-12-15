{ config, pkgs, ... }:
{
  networking.hostName = "ah64-thelio";
  services.xserver.videoDrivers = [ "nvidia" ];
  nix.buildMachines = [
    {
      hostName = "big_arm_2";
      system = "aarch64-linux";
      maxJobs = 16;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [ ];
    }
    # {
    #   hostName = "big_arm";
    #   system = "aarch64-linux";
    #   maxJobs = 8;
    #   supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    #   mandatoryFeatures = [ ];
    # }
  ];

  nix.distributedBuilds = true;
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = [ pkgs.cudatoolkit ];
}
