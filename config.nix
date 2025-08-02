{ config, pkgs, lib, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    jq
    tmux-mem-cpu-load
  ];

  imports = [
    ./modules/git.nix
    ./modules/tmux.nix
  ];
}
