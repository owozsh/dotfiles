# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    gh
    git
    neovim
    eza
    neofetch
    bat
    nnn
    fzf
    fd
    asdf-vm
    nixpkgs.texlive.combined.scheme-full
    pkgs.zsh-forgit
    pkgs.oh-my-zsh
    pkgs.zsh
    pkgs.zsh-completions
    pkgs.zsh-powerlevel10k
    pkgs.zsh-syntax-highlighting
    pkgs.zsh-history-substring-search
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch";
      config = "sudo nvim /etc/nixos/configuration.nix";
      dcu = "docker compose up";
      cdd = "cd ~/Developer; clear";
      ls="eza --icons";

      ga="git add .";
      gcam="git commit -am";
      gpull="git pull";
      gpush="git push";
      gb="git checkout";
      gbb="git checkout -b";
    };
    ohMyZsh = {
        enable = true;
	theme = "robbyrussell";
        plugins = [ "git" "asdf" "forgit" ];
    };    
  };

  users.defaultUserShell = pkgs.zsh;

  users.users.nixos = {
	shell = pkgs.zsh;
  };
}
