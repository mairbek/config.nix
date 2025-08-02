{ lib, pkgs, config, ... }:

let
in
{
  home.packages = with pkgs; [
    curl
    wget
    jq
    yq-go
  ];

  programs.zsh = {
    enable = true;                 # ← HM now owns ~/.zshrc & friends
    enableCompletion = true;
    autocd = true;
    history = {
      size  = 10000;
      ignoreDups = true;
    };

   "oh-my-zsh" = {
      enable = true;
      theme  = "robbyrussell";
      plugins = [ "git" ];
    };

    initContent = ''
      # Show “(nix)” in magenta when IN_NIX_SHELL is set
      function _nix_prompt_prefix {
        if [[ -n "$IN_NIX_SHELL" ]]; then
          PROMPT="%{$fg[magenta]%}(nix)%{$reset_color%} $PROMPT_BASE"
        else
          PROMPT="$PROMPT_BASE"
        fi
      }

      PROMPT_BASE="$PROMPT"
      autoload -Uz add-zsh-hook
      add-zsh-hook precmd _nix_prompt_prefix
    '';


    plugins = [
      {
        name = "nix-shell";
        src  = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo  = "zsh-nix-shell";
          rev   = "master";
          hash  = "sha256-Rtg8kWVLhXRuD2/Ctbtgz9MQCtKZOLpAIdommZhXKdE=";
        };
        file = "plugins/nix-shell/nix-shell.plugin.zsh";
      }
    ];
  };

  programs.ssh = {
    enable = true;

    # orbstack included
    includes = [ "~/.orbstack/ssh/config" ];

    # TODO(mairbek): what's the best way to generate ssh keys with nix?
    matchBlocks."github.com" = {
      identityFile   = "~/.ssh/id_ed25519";
      extraOptions = {
        AddKeysToAgent = "yes";
        UseKeychain    = "yes";      # macOS-specific
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # TODO(mairbek): enable when zsh is configured with nix
    enableZshIntegration = true;
    silent = true;
  };

}
