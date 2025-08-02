{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  home.username      = "mairbek";
  home.homeDirectory = "/Users/mairbek";

  # Environment variables unique to this machine.
  home.sessionVariables = {
    MAIRBEK_DOTFILES_MACHINE = "m-conduit";
  };

  programs.git = {
    # override with work email
    userEmail = "mairbek@conduit.xyz";
  };
}
