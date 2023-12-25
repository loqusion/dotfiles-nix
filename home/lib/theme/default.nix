{...}: rec {
  terminal = let
    jetbrains = "JetBrainsMono NF";
    maple = "Maple Mono SC NF";
    victor = "Victor Mono NF";
  in {
    font = jetbrains;
    fontItalic = maple;
    opacity = 0.9;
    size = 12.5;
  };

  dark = true;

  colors =
    if dark
    then {
      catppuccin_variant = "mocha";
    }
    else {
      catppuccin_variant = "latte";
    };
}
