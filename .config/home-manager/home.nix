{ config, pkgs, ... }:

{
  home.username = "owozsh";
  home.homeDirectory = "/home/owozsh";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    ripgrep
    tmux
    direnv
    clipman
    nodejs
    ruby
    python3
    gcc
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
    kitty
    alacritty
    devenv
    zsh-forgit
    oh-my-zsh
    zsh
    zsh-completions
    zsh-syntax-highlighting
  ];

  home.file = {
    ".config/nvim" = {
        source = "/home/owozsh/Developer/dotfiles/.config/nvim";
      };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "home-manager switch";
      config = "nvim ~/.config/home-manager/home.nix";
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
    initExtra = ''
        export FZF_DEFAULT_COMMAND="fd . ."
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd -t d --hidden --follow --search-path $HOME/Developer"

        bindkey -s '^k' 'cd $(fd -t d --hidden --follow --search-path $HOME/Developer | fzf)\nclear\n'
        bindkey -s '^f' '^ucd $(ls -p | grep / | cat | fzf)\nclear\n'
        bindkey -s '^n' '^ucd ~/Home/Notes\nclear\nnvim\n'
        bindkey -s '^e' '^unvim $(ls -p | grep -v / | cat | fzf)\n'
    '';
    oh-my-zsh = {
        enable = true;
	theme = "robbyrussell";
        plugins = [ "git" "asdf" "direnv" ];
    };    
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs.git = {
    enable = true;
    userName  = "Vítor Barroso";
    userEmail = "contact@owozsh.dev";
  };

  programs.home-manager.enable = true;
}
