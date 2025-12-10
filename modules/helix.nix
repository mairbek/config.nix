# modules/git.nix
{
  lib,
  pkgs,
  config,
  ...
}:

let
in
{
  home.packages = with pkgs; [
    rust-analyzer
 ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn_night_transparent";

      editor = {
        color-modes = true;
        cursorline = true;
        bufferline = "multiple";

        soft-wrap.enable = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";

        lsp = {
          display-inlay-hints = true;
          display-messages = true;
        };

        #   statusline = {
        #     left = [ "mode" "file-name" "spinner" "read-only-indicator" "file-modification-indicator" ];
        #     right = [ "diagnostics" "selections" "register" "file-type" "file-line-ending" "position" ];
        #     mode.normal = "";
        #     mode.insert = "I";
        #     mode.select = "S";
        #   };
      };

      # override keys here.
      keys = {
        normal = {
        };
        insert = {
        };
        select = {
        };
      };
    };

    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
      #   # https://github.com/helix-editor/helix/blob/master/runtime/themes/gruvbox.toml
      gruvbox_community = {
        inherits = "gruvbox";
        "variable" = "blue1";
        "variable.parameter" = "blue1";
        "function.macro" = "red1";
        "operator" = "orange1";
        "comment" = "gray";
        "constant.builtin" = "orange1";
        "ui.background" = { };
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        }
        {
          name = "rust";
          language-servers = [
            "rust-analyzer"
          ];
          auto-format = true;
        }
      ];
    };
  };
}
