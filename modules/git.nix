# modules/git.nix
{
  lib,
  pkgs,
  config,
  ...
}:

{
  programs.git = {
    enable = true;

    ##–– Global ignore file ––––––––––––––––––––––––––––––––––––––
    ignores = [
      ".DS_Store"
      "*.log"
      "*.swp"
      ".direnv"
      ".cache"
      ".venv"
    ];

    ##–– Git settings ––––––––––––––––––––––––––––––––––––––––––––
    settings = {
      user.name = lib.mkDefault "Mairbek Khadikov";
      user.email = lib.mkDefault "mkhadikov@gmail.com";

      init.defaultBranch = "master";
      core.editor = "vim";
      core.autocrlf = "input";
      merge.conflictStyle = "zdiff3";
      diff.colorMoved = "default";
      push.autoSetupRemote = true;
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
      url."ssh://git@gist.github.com/".insteadOf = "https://gist.github.com/";

      alias = {
        co = "checkout";
        cob = "checkout -b";
        ac = "!git add -A && git commit -m";
        amend = "commit -a --amend";
        s = "status";
        fom = "fetch origin main";
        foms = "fetch origin master";
        c-p = "cherry-pick";
      };
    };
  };
}
