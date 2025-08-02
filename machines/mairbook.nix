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
      commit.gpgsign = true;
      signing = {
        key            = "F63B7E5365EC20AC134FF33B662CB6EC70C7B9BF";
        signByDefault  = true;
      };
    };
  };
} 