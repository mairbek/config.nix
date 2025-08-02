{
  description = "mairbek's nix dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... }@inputs:
  let
    user   = "mairbek";
    system = "aarch64-darwin";

    mkHome = extraModules:
      home-manager.lib.homeManagerConfiguration {
        pkgs    = import nixpkgs { inherit system; };
        modules = [ ./config.nix ] ++ extraModules;
      };
  in {
    homeConfigurations = {
      "m-conduit" = mkHome [ ./machines/m-conduit.nix ];
    };
  };
}
