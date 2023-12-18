{
  pkgs,
  lib,
  ...
}: {
  programs.helix.languages = {
    language = let
      prettier = lang: {
        command = "${pkgs.nodePackages.prettier}/bin/prettier";
        args = ["--parser" lang];
      };
      prettierLangs = map (lang: {
        name = lang;
        formatter = prettier lang;
      });
      langs = ["css" "scss" "html"];
    in
      [
        {
          name = "toml";
          formatter = {
            command = "${pkgs.taplo}/bin/taplo";
            args = ["fmt" "-"];
          };
        }
      ]
      ++ prettierLangs langs;

    language-server = {
      bash-language-server = {
        command = "${lib.getExe pkgs.nodePackages.bash-language-server}";
        args = ["start"];
      };

      nil = {
        command = lib.getExe pkgs.nil;
        config.nil.formatting.command = ["${lib.getExe pkgs.nixfmt}" "-q"];
      };

      taplo = {
        command = "${pkgs.taplo}/bin/taplo";
        args = ["lsp" "stdio"];
      };

      vscode-css-language-server = {
        command = "${lib.getExe pkgs.nodePackages.vscode-css-languageserver-bin}";
        args = ["--stdio"];
        config = {
          provideFormatter = true;
          css.validate.enable = true;
          scss.validate.enable = true;
        };
      };
    };
  };
}
