# modules/git.nix
{ lib, pkgs, config, ... }:

let
  username = lib.mkDefault "Mairbek Khadikov";
  email    = lib.mkDefault "mairbek@conduit.xyz";
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
    ];

    ##–– Extra git-config not covered by first-class options ––––
    extraConfig = {
      init.defaultBranch = "master";
      core.editor        = "vim";
      core.autocrlf      = "input";
      merge.conflictStyle= "zdiff3";
      diff.colorMoved    = "default";
      push.autoSetupRemote = true;
    };

    ##–– Commit signing (comment out if you don’t sign) –––––––––
    # signing = {
    #   key            = "0xDEADBEEF";  # GPG key ID
    #   signByDefault  = true;
    # };

    ##–– Credential helper: macOS keychain, or cache on Linux ––
    # Use lib.mkIf so the same module works on every OS.
    # credential.helper = lib.mkIf (pkgs.stdenv.isDarwin) "osxkeychain"
    #                      (lib.mkIf pkgs.stdenv.isLinux  "cache --timeout=7200");
  };
}
