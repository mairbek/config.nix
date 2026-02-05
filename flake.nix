{
  description = "mairbek's nix dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      claude-code,
      ...
    }@inputs:
    let
      user = "mairbek";
      system = "aarch64-darwin";

      hmCli = home-manager.packages.${system}.home-manager;

      # Override claude-code to 2.1.32
      claudeCodeOverlay = final: prev: {
        claude-code = final.stdenv.mkDerivation rec {
          pname = "claude-code";
          version = "2.1.32";

          src = final.fetchurl {
            url = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/${version}/darwin-arm64/claude";
            sha256 = "1lyrimvhavjd5s4p23i5fws9dlxrgbi4m7xwa5b0lj043h2w66l4";
          };

          dontUnpack = true;
          dontStrip = true;
          dontPatchELF = true;

          installPhase = ''
            mkdir -p $out/bin
            cp $src $out/bin/claude
            chmod +x $out/bin/claude
          '';

          meta = {
            description = "Claude Code CLI";
            mainProgram = "claude";
          };
        };
      };

      mkHome =
        extraModules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              claude-code.overlays.default
              claudeCodeOverlay
            ];
            config.allowUnfree = true;
          };

          modules = [
            ./config.nix

            # add the CLI to every profile’s ~/.nix-profile
            { home.packages = [ hmCli ]; }
          ]
          ++ extraModules;
        };
    in
    {
      homeConfigurations = {
        "m-conduit" = mkHome [ ./machines/m-conduit.nix ];
        "mairbook" = mkHome [ ./machines/mairbook.nix ];
      };
    };
}
