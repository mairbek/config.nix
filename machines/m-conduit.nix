{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  home.username = "mairbek";
  home.homeDirectory = "/Users/mairbek";

  # Environment variables unique to this machine.
  home.sessionVariables = {
    MAIRBEK_DOTFILES_MACHINE = "m-conduit";
  };

  programs.git.settings = {
    # override with work email
    user.email = "mairbek@conduit.xyz";
    commit.gpgsign = true;
    signing = {
      key = "1CFC99FE9A558EA3ABFF71421511D513BA410D74";
      signByDefault = true;
    };
  };
}
