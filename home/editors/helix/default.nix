{pkgs, ...}: {
  imports = [
    ./languages.nix
    ./theme.nix
  ];

  programs.helix = {
    enable = true;
    package = pkgs.helix;

    settings = {
      theme = "catppuccin";
      editor = {
        auto-format = true;
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
          rainbow-option = "dim";
        };
        line-number = "absolute";
        lsp.display-inlay-hints = true;
        middle-click-paste = false;
        smart-tab = {
          enable = true;
          supersede-menu = true;
        };
        statusline.center = ["position-percentage"];
        true-color = true;
      };
    };
  };
}
