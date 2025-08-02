{ pkgs, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [ jq ];

  imports = [
    ./modules/git.nix
    # ./modules/tmux.nix
  ];
}
