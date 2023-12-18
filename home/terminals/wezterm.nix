{pkgs, ...}: {
  home.packages = [pkgs.wezterm];
  # programs.wezterm = {
  #   enable = true;
  #   package = pkgs.wezterm;
  # };
}
