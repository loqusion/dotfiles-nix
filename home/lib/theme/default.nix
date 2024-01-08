{...}: rec {
  terminal = let
    jetbrains = "JetBrainsMono NF";
    maple = "Maple Mono SC NF";
    victor = "Victor Mono NF";
  in rec {
    font = jetbrains;
    fontItalic = maple;
    transparent = true;
    opacity =
      if transparent
      then 0.9
      else 1.0;
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
