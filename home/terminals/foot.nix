{
  pkgs,
  lib,
  ...
}: let
  catppuccinDrv = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/009cd57bd3491c65bb718a269951719f94224eb7/catppuccin-mocha.conf";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
  theme = import ../lib/theme {};
  inherit (theme.terminal) font fontItalic size opacity;
in {
  programs.foot = {
    enable = true;
    settings = {
      main = let
        defineFont = let
          inherit (lib.attrsets) filterAttrs mapAttrsToList;
          inherit (lib.strings) concatStringsSep;
        in
          {
            font,
            style ? null,
            size ? size,
            features ? ["calt" "dlig" "liga" "kern"],
          }:
            concatStringsSep ":" (mapAttrsToList (name: value:
              if name == "font"
              then toString value
              else
                concatStringsSep
                "=" [name (toString value)]) (filterAttrs (name: value: value != null) {
              inherit font style size;
              fontfeatures = concatStringsSep " " features;
            }));
      in {
        font = defineFont {inherit font size;};
        font-bold = defineFont {
          inherit font size;
          style = "Bold";
        };
        font-italic = defineFont {
          inherit size;
          font = fontItalic;
          style = "Italic";
        };
        font-bold-italic = defineFont {
          inherit size;
          font = fontItalic;
          style = "BoldItalic";
        };
        box-drawings-uses-font-glyphs = false;
        selection-target = "clipboard";
        include = "${catppuccinDrv}";
      };

      scrollback = {
        lines = 10000;
      };

      key-bindings = {
        spawn-terminal = "none";
      };

      mouse-bindings = {
        primary-paste = "none";
      };

      url = {
        launch = "xdg-open \${url}";
        protocols = "http, https, ftp, ftps, file";
      };

      colors = {
        alpha = opacity;
      };
    };
  };
}
