{
  description = "mairbek's nix dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    user   = "mairbek";
    system = "aarch64-darwin";

    hmCli  = home-manager.packages.${system}.home-manager;

    mkHome = extraModules:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };

        modules =
          [
            ./config.nix

            # add the CLI to every profile’s ~/.nix-profile
            { home.packages = [ hmCli ]; }
          ]
          ++ extraModules;
      };
  in {
    homeConfigurations = {
      "m-conduit" = mkHome [ ./machines/m-conduit.nix ];
      "mairbook" = mkHome [ ./machines/mairbook.nix ];
    };
  };
}
