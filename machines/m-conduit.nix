{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  home.username      = "mairbek";              # ← non-empty
  home.homeDirectory = "/Users/mairbek";       # ← full path

  # Environment variables unique to this box
  home.sessionVariables = {
    CONDUIT_ENV = "dev";
  };
}
