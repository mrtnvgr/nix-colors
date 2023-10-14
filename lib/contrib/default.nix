{ pkgs ? (builtins.trace "nix-colors/lib-contrib: using <nixpkgs> as pkgs because the pkgs parameter was not provided" (import <nixpkgs> { })) }:
rec {
  # Takes a scheme, resulting wallpaper height and width, plus logo scale, and ouputs the generated wallpaper path
  # Example:
  # wallpaper = nixWallpaperFromScheme {
  #   scheme = config.colorScheme;
  #   width = 2560;
  #   height = 1080;
  #   logoScale = 5.0;
  # };
  nixWallpaperFromScheme = import ./nix-wallpaper.nix { inherit pkgs; };

  # Takes a picture path and a scheme kind ("dark" or "light"), and outputs a colorscheme based on it
  # Please note the path must be accessible by your flake on pure mode
  # Example:
  # colorScheme = colorSchemeFromPicture {
  #   path = ./my/cool/wallpaper.png;
  #   kind = "dark";
  # };
  colorSchemeFromPicture = import ./from-picture.nix { inherit pkgs; };
  # Alias for backwards compat
  colorschemeFromPicture = colorSchemeFromPicture;

  # Takes a scheme, ouputs a generated materia GTK theme
  # Example:
  # gtk.theme.package = gtkThemeFromScheme {
  #   scheme = config.colorScheme;
  # };
  gtkThemeFromScheme = import ./gtk-theme.nix { inherit pkgs; };

  # Takes a scheme, ouputs a vim theme package.
  #
  # The output theme name will be "nix-" followed by the coloscheme's slug, and
  # should be set, for example, by adding "colorscheme nix-${config.colorScheme.slug}"
  # to your vimrc.
  #
  # Vim example:
  # programs.vim = {
  #   plugins = [
  #     (vimThemeFromScheme { scheme = config.colorScheme; })
  #   ];
  #   extraConfig = "colorscheme nix-${config.colorScheme.slug}";
  # };
  #
  # Neovim example:
  # programs.neovim.plugins = [{
  #   plugin = vimThemeFromScheme { scheme = config.colorScheme; };
  #   config = "colorscheme nix-${config.colorScheme.slug}";
  # }];
  vimThemeFromScheme = import ./vim-theme.nix { inherit pkgs; };

  # Takes a scheme, ouputs a script that applies this scheme to the current shell.
  # It also runs on ttys, and clears the screen when doing it (to look better).
  # If you'd rather not let it clean your screen, pass the argument { clearTty = false; }
  #
  # Example:
  # programs.fish = {
  #   interactiveShellInit = ''
  #     sh ${shellThemeFromScheme { scheme = config.colorScheme; }}
  #   '';
  # };
  shellThemeFromScheme = import ./shell-theme.nix { inherit pkgs; };

  # Takes a scheme, outputs customized bibata cursors
  # Example:
  # home.pointerCursor = {
  #   package = bibataCursorsFromScheme { scheme = config.colorScheme };
  #   name = "Bibata-Modern-Ice";
  # };
  bibataCursorsFromScheme = import ./bibata-cursors.nix { inherit pkgs; };
}
