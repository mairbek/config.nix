{ config, pkgs, lib, ... }:

{
  home.stateVersion = "24.05";

  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/tmux.nix
  ];
}
