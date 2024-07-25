{ config, pkgs, ... }:
{
  # v4l2loopback
  boot= {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
    extraModprobeConfig = ''
        options v4l2loopback nr_devices=4 video_nr=4,5,6,7 card_label=v4l2lo0,v4l2lo1,v4l2lo2,v4l2lo3
      '';
  };

  # lxd for lxc
  virtualisation.lxd.enable = true;

  # docker
  virtualisation.docker.enable = true;

  users.users.rishi = {
    extraGroups = [ "lxd" "docker" ];
  };

  networking.hostName = "ah64-thelio";
  services.xserver.videoDrivers = [ "nvidia" ];
  services.fanout = {
    enable = true;
    fanoutDevices = 1;
    bufferSize = 16384; # Value is in bytes
  };

  # OpenGL
  hardware.opengl.enable = true;

  nix.buildMachines = [
    {
      hostName = "flyingbrick";
      system = "aarch64-linux";
      maxJobs = 64;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [ ];
    }
    {
      hostName = "turbo";
      system = "x86_64-linux";
      maxJobs = 64;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [ ];
    }
  ];

  nix.distributedBuilds = true;
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = [ pkgs.cudatoolkit ];
}
