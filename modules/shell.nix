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
}
