{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  home.username      = "mairbek";
  home.homeDirectory = "/Users/mairbek";

  # Environment variables unique to this machine.
  home.sessionVariables = {
    MAIRBEK_DOTFILES_MACHINE = "mairbook";
  };

  programs.git = {
    userEmail = "mkhadikov@gmail.com";
    extraConfig = {
      signing = {
        key            = "AC0AAD64943B8374";
        signByDefault  = true;
      };
    };
  };
} 