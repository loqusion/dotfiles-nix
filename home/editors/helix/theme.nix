{lib, ...}: let
  theme = import ../../lib/theme {};
  inherit (theme.colors) catppuccin_variant;
  augment = v: v // lib.optionalAttrs (theme.terminal.transparent && !forceOpaque) {"ui.background" = "";};

  forceOpaque = false;
in {
  programs.helix.themes = {
    onedark = augment {
      inherits = "onedark";
    };
    catppuccin = augment {
      inherits = "catppuccin_${catppuccin_variant}";
    };
  };
}
