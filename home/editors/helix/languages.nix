{ pkgs, ... }: {
  programs.helix.languages = {
    language = let
      prettier = lang: {
        command = "${pkgs.nodePackages.prettier}/bin/prettier";
        args = [ "--parser" lang ];
      };
      prettierLangs = map (e: {
        name = e;
        formatter = prettier e;
      });
      langs = [ "css" "scss" "html" ];
    in [ ] ++ prettierLangs langs;

    language-server = {
      bash-language-server = {
        command =
          "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server";
        args = [ "start" ];
      };

      vscode-css-language-server = {
        command =
          "${pkgs.nodePackages.vscode-css-languageserver-bin}/bin/css-languageserver";
        args = [ "--stdio" ];
        config = {
          provideFormatter = true;
          css.validate.enable = true;
          scss.validate.enable = true;
        };
      };
    };
  };
}
