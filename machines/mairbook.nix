{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  home.username = "mairbek";
  home.homeDirectory = "/Users/mairbek";

  # Environment variables unique to this machine.
  home.sessionVariables = {
    MAIRBEK_DOTFILES_MACHINE = "mairbook";
  };

  programs.git.settings = {
    user.email = "mkhadikov@gmail.com";
    commit.gpgsign = true;
    gpg.format = "openpgp";
    user.signingkey = "F63B7E5365EC20AC134FF33B662CB6EC70C7B9BF";
  };
}
