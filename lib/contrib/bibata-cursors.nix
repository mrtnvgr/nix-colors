{ pkgs }:
{ scheme }:

pkgs.stdenv.mkDerivation {
  name = "generated-bibata-cursors-${scheme.slug}";

  src = pkgs.fetchFromGitHub {
    owner = "ful1e5";
    repo = "Bibata_Cursor";
    rev = "v2.0.3";
    sha256 = "zCk7qgPeae0BfzhxxU2Dk1SOWJQOxiWyJuzH/ri+Gq4=";
  };

  buildInputs = with pkgs.python3Packages; [ clickgen attrs ];

  buildPhase = ''
    cat > render.json << EOF
    {
      "Bibata-Modern-Classic": {
        "dir": "svg/modern",
        "out": "bitmaps/Bibata-Modern-Classic",
        "fps": 1.2,
        "colors": [
          { "match": "#00FF00", "replace": "#${scheme.colors.base00}" },
          { "match": "#0000FF", "replace": "#${scheme.colors.base05}" },
          { "match": "#FF0000", "replace": "#${scheme.colors.base00}" }
        ]
      },

      "Bibata-Modern-Ice": {
        "dir": "svg/modern",
        "out": "bitmaps/Bibata-Modern-Ice",
        "fps": 1.2,
        "colors": [
          { "match": "#00FF00", "replace": "#${scheme.colors.base05}" },
          { "match": "#0000FF", "replace": "#${scheme.colors.base00}" },
          { "match": "#FF0000", "replace": "#${scheme.colors.base05}" }
        ]
      },

      "Bibata-Original-Classic": {
        "dir": "svg/original",
        "out": "bitmaps/Bibata-Original-Classic",
        "fps": 1.2,
        "colors": [
          { "match": "#00FF00", "replace": "#${scheme.colors.base00}" },
          { "match": "#0000FF", "replace": "#${scheme.colors.base05}" },
          { "match": "#FF0000", "replace": "#${scheme.colors.base00}" }
        ]
      },

      "Bibata-Original-Ice": {
        "dir": "svg/original",
        "out": "bitmaps/Bibata-Original-Ice",
        "fps": 1.2,
        "colors": [
          { "match": "#00FF00", "replace": "#${scheme.colors.base05}" },
          { "match": "#0000FF", "replace": "#${scheme.colors.base00}" },
          { "match": "#FF0000", "replace": "#${scheme.colors.base05}" }
        ]
      }
    }
    EOF

    ctgen build.toml -p x11 -d 'bitmaps/Bibata-Modern-Classic' -n 'Bibata-Modern-Classic' -c 'Black and rounded edge Bibata cursors.'
    ctgen build.toml -p x11 -d 'bitmaps/Bibata-Modern-Ice' -n 'Bibata-Modern-Ice' -c 'White and rounded edge Bibata cursors.'

    ctgen build.toml -p x11 -d 'bitmaps/Bibata-Original-Classic' -n 'Bibata-Original-Classic' -c 'Black and sharp edge Bibata cursors.'
    ctgen build.toml -p x11 -d 'bitmaps/Bibata-Original-Ice' -n 'Bibata-Original-Ice' -c 'White and sharp edge Bibata cursors.'
  '';

  installPhase = ''
    install -dm 0755 $out/share/icons
    cp -rf themes/* $out/share/icons/
  '';
}
