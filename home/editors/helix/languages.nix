{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
in {
  programs.helix.languages = {
    language = let
      # XXX: Some languages don't auto-format by default, even when auto-format is enabled globally
      withAutoFormat = map (langConfig: {auto-format = true;} // langConfig);
      prettierLangs = map (lang: {
        name = lang;
        formatter = {
          command = getExe pkgs.nodePackages.prettier;
          args = ["--parser" lang];
        };
      }) ["css" "scss" "html"];
    in
      withAutoFormat ([
          {
            name = "nix";
          }
          {
            name = "toml";
            formatter = {
              command = getExe pkgs.taplo;
              args = ["fmt" "-"];
            };
          }
          {
            name = "typst";
            formatter = {
              command = getExe pkgs.typstfmt;
            };
            auto-format = false;
          }
        ]
        ++ prettierLangs);

    language-server = {
      bash-language-server = {
        command = getExe pkgs.nodePackages.bash-language-server;
        args = ["start"];
      };

      nil = {
        command = getExe pkgs.nil;
        config.nil.formatting.command = [(getExe pkgs.alejandra) "-q"];
      };

      rust-analyzer = {
        command = getExe pkgs.rust-analyzer;
      };

      taplo = {
        command = getExe pkgs.taplo;
        args = ["lsp" "stdio"];
      };

      vscode-css-language-server = {
        command = getExe pkgs.nodePackages.vscode-css-languageserver-bin;
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
