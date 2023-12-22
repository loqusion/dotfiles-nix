{
  pkgs,
  lib,
  ...
}:
with lib; let
  # TODO: This isn't working
  catppuccinDrv = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/loqusion/catppuccin-foot/3df09b27935521bf71489821965c2fe0c2c8d672/catppuccin-mocha.ini";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
  theme = import ../lib/theme {};
  inherit (theme.terminal) font fontItalic size opacity;
  catppuccin = builtins.fromTOML (builtins.readFile catppuccinDrv);
in {
  programs.foot = {
    enable = true;
    settings =
      {
        main = {
          font = "${font}:size=${size}";
          font-italic = "${fontItalic}:size=${size}";
        };

        scrollback = {
          lines = 10000;
        };

        url = {
          launch = "xdg-open \${url}";
          protocols = "http, https, ftp, ftps, file";
        };

        # colors = {
        #   alpha = opacity;
        # };
      }
      // (debug.traceVal catppuccin);
  };
}
