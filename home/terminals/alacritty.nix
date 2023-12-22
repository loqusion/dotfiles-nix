{pkgs, ...}: let
  catppuccin = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/alacritty/3c808cbb4f9c87be43ba5241bc57373c793d2f17/catppuccin-mocha.yml";
    hash = "sha256-28Tvtf8A/rx40J9PKXH6NL3h/OKfn3TQT1K9G8iWCkM=";
  };
  theme = import ../lib/theme {};
  inherit (theme.terminal) font fontItalic size opacity;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {inherit opacity;};
      font = {
        inherit size;
        normal.family = font;
        italic.family = fontItalic;
        bold_italic.family = fontItalic;
      };

      imports = [catppuccin];
    };
  };
}
