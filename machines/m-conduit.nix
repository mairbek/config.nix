{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  # Environment variables unique to this box
  home.sessionVariables = {
    CONDUIT_ENV = "dev";
  };
}
