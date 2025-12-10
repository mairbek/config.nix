{
  lib,
  pkgs,
  config,
  ...
}:

let
in
{
  home.packages = with pkgs; [
    curl
    wget
    jq
    yq-go
    cacert
    nixfmt-rfc-style
    nixfmt-tree
    cmatrix
    (python313.withPackages (
      p:
      (with p; [
        python-lsp-ruff
        python-lsp-server
        ipykernel
        pip
      ])
    ))
    uv
    ruff
  ];

  programs.zsh = {
    enable = true; # ← HM now owns ~/.zshrc & friends
    enableCompletion = true;
    autocd = true;
    history = {
      size = 10000;
      ignoreDups = true;
    };

    "oh-my-zsh" = {
      enable = true;
      theme = "robbyrussell";
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
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "master";
          hash = "sha256-Rtg8kWVLhXRuD2/Ctbtgz9MQCtKZOLpAIdommZhXKdE=";
        };
        file = "plugins/nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.1";
          sha256 = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
        };
      }
    ];
  };

  programs.ssh = {
    enable = true;

    # orbstack included
    includes = [ "~/.orbstack/ssh/config" ];

    # TODO(mairbek): what's the best way to generate ssh keys with nix?
    matchBlocks."github.com" = {
      identityFile = "~/.ssh/id_ed25519";
      extraOptions = {
        AddKeysToAgent = "yes";
        UseKeychain = "yes"; # macOS-specific
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
  home.sessionVariables = {
    SSL_CERT_FILE      = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    REQUESTS_CA_BUNDLE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    NIX_SSL_CERT_FILE  = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
  };

}
