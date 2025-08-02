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
    # enableZshIntegration = true;
    silent = true;
  };

}
