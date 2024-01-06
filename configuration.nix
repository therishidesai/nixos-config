{ config, pkgs, ... }:
{
  # NixOS SystemState
  system.stateVersion = "23.11";
  
  # Nix
  nix = {
    settings = {
      trusted-users = [ "root" "rishi" ];
      auto-optimise-store = true;
      trusted-public-keys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
      substituters = [
        "https://cache.iog.io"
      ];
    };

    package = pkgs.nixFlakes;
    extraOptions = ''
      allowed-uris = http:// https:// ssh://
      experimental-features = nix-command flakes
      builders-use-substitutes = true
      '';
    
  };

  # udev rules
  services.udev.packages = [ pkgs.picoprobe-udev-rules ];

  # Networking
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;
  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Fonts
  fonts.packages = with pkgs; [
    mononoki
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment with i3.
  services.xserver.displayManager.defaultSession = "xfce+i3";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.desktopManager.xfce = {
    enable = true;
    noDesktop = true;
    enableXfwm = false;
  };
  services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rishi = {
    isNormalUser = true;
    description = "rishi";
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Kernel-dependent stuff
    config.boot.kernelPackages.bcc
    config.boot.kernelPackages.bpftrace
    config.boot.kernelPackages.perf
    compsize

    # Nix fun
    nix-index
    nix-tree

    # disk stuff
    parted
    snapper

    #vpn
    tailscale

    # utils
    acpi
    calc
    cloc
    curl
    direnv
    emacs29
    file
    htop
    inotify-tools
    iotop
    killall
    lsof
    moreutils
    par
    pstree
    pv
    s-tui
    simg2img # Android sparse image -> image conversion
    tmux
    tree
    usbutils
    vim # for xxd
    wget
    zsh
    bat # cat clone for nvim-fzf-commands
    eza
    fd # find clone for nvim-fzf-commands
    fzf

    # compression
    gzip
    libarchive
    unzip
    xz
    zip
    zstd

    # devel
    awscli
    bintools
    can-utils
    clang
    codespell
    colordiff
    dtc
    elfutils
    flamegraph
    gcc
    gdb
    gnumake
    haskell-language-server
    hlint
    man-pages
    patchelf
    picocom
    rust-analyzer
    git
    git-filter-repo
    git-lfs
    neovim-unwrapped
    ripgrep

    # ...apps?
    evince
    gimp
    gnome.file-roller
    gnome.gnome-calculator
    meld
    mpv
    optipng
    zathura
    brave
    ffmpeg
    firefox-bin
    signal-desktop
    slack

    # ui/desktop environment
    alacritty
    conky
    globalprotect-openconnect
    i3
    i3lock
    networkmanagerapplet
    pango
    pavucontrol
    picom
    rofi
    scrot
    xclip
    xfce.ristretto
    xfce.thunar
    xfce.tumbler
    xfce.xfce4-clipman-plugin
    xfce.xfce4-notifyd
    xfce.xfce4-power-manager
    xfce.xfce4-screenshooter
  ];
}
