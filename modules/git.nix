# modules/git.nix
{ lib, pkgs, config, ... }:

let
  username = lib.mkDefault "Mairbek Khadikov";
  email    = lib.mkDefault "mkhadikov@gmail.com";
in
{
  programs.git = {
    enable    = true;
    userName  = username;
    userEmail = email;

    ##–– Global ignore file ––––––––––––––––––––––––––––––––––––––
    ignores = [
      ".DS_Store"
      "*.log"
      "*.swp"
      ".direnv"
    ];

    ##–– Extra git-config not covered by first-class options ––––
    extraConfig = {
      init.defaultBranch = "master";
      core.editor        = "vim";
      core.autocrlf      = "input";
      merge.conflictStyle= "zdiff3";
      diff.colorMoved    = "default";
      push.autoSetupRemote = true;
      url."ssh://git@github.com/" = {
        insteadOf = "https://github.com/";
      };
      url."ssh://git@gist.github.com/" = {
        insteadOf = "https://gist.github.com/";
      };
    };
  };
}
