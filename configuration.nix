{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.plymouth.enable = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Define hostname
  networking.hostName = "nil";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set the time zone
  time.timeZone = "America/New_York";

  # Select internationalisation properties
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

  # Configure X11 settings
  services.xserver = {
    enable = true;

    # Input settings
    layout = "us";
    xkbVariant = "";
    xkbOptions = "ctrl:swapcaps";
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
    tapping = true;
        accelProfile = "flat";
      };
      mouse = {
        accelProfile = "flat";
      };
    };

    # Remove bloat
    excludePackages = with pkgs; [ xterm ];
  };

  # Apply xkb options outside of X11
  console.useXkbConfig = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5 = {
    enable = true;

    # Remove bloat
    excludePackages = with pkgs.libsForQt5; [
      elisa
      gwenview
      okular
      konsole
      kwalletmanager
      plasma-browser-integration
    ];
  };

  # Default user directories
  environment.etc = {
    "xdg/user-dirs.defaults".text = ''
      DESKTOP=desktop
      DOCUMENTS=documents
      DOWNLOAD=downloads
      PICTURES=pictures
      MUSIC=music
      VIDEOS=videos
      PUBLICSHARE=share
      TEMPLATES=templates
    '';
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account
  users.users.spectre = {
    isNormalUser = true;
    description = "spectre";
    extraGroups = [ "networkmanager" "wheel" "sudo" "audio" "video"];
    shell = pkgs.zsh;
  };

  # Add shells to /etc/shells
  environment.shells = [ pkgs.zsh ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    git
    wget
    zip
    unzip
    ffmpeg
    imagemagick
    wl-clipboard
    killall
    file
    pciutils
  ];

  # Install fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    (iosevka.override {
      privateBuildPlan = builtins.readFile dotfiles/iosevka/private-build-plans.toml;
      set = "custom";
    })
  ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  system.stateVersion = "22.11";
}
