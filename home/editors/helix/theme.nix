{lib, ...}: let
  theme = import ../../lib/theme {};
  augment = v: v // lib.optionalAttrs (theme.terminal.opacity != 1.0 && !forceOpaque) {"ui.background" = "";};

  forceOpaque = false;
in {
  programs.helix.themes = {
    onedark = augment {
      inherits = "onedark";
    };
  };
}
