{ config, pkgs, ... }:

{
  home.username = "spectre";
  home.homeDirectory = "/home/spectre";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    firefox
    vlc
    qalculate-qt
    xournalpp
    libreoffice
    zathura
    tidal-hifi
    fzf
    zoxide
    bat
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    ls = "ls --color=auto";
    rebuild = "sudo nixos-rebuild switch --flake .#";
    home-rebuild = "home-manager switch --flake .#${config.home.username}";
  };

  xdg.userDirs =
  let
    homeDir = config.home.homeDirectory;
  in {
    enable = true;
    desktop = "${homeDir}/desktop";
    documents = "${homeDir}/documents";
    download = "${homeDir}/downloads";
    music = "${homeDir}/music";
    pictures = "${homeDir}/pictures";
    videos = "${homeDir}/videos";
    publicShare = "${homeDir}/public";
    templates = "${homeDir}/templates";
  };

  home.file.".config" = {
    source = ./dotfiles;
    recursive = true;
  };

  programs.home-manager.enable = true;

  programs.bash.enable = true;
  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.git = {
    enable = true;
    userName = "<name>";
    userEmail = "<email>";
    extraConfig = {
      core = {
        editor = "nvim";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      editor = "nvim";
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Macchiato";
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 20;
    };
  };

  programs.btop = {
    enable = true;
  };
}
