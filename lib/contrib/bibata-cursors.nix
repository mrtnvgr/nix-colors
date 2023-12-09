{ pkgs }:
{ name, type, base, outline, watch_bg }:

pkgs.stdenv.mkDerivation {
  name = "generated-bibata-cursors-${name}";

  src = pkgs.fetchFromGitHub {
    owner = "ful1e5";
    repo = "Bibata_Cursor";
    rev = "f9704f65856d7675e27b7ce9b5d7833106f9771d";
    sha256 = "ujAKZMbfABaBiAogmtTqOx0LUpeb4cA532RWvf9DhdY=";
  };

  buildInputs = with pkgs.python3Packages; [ clickgen attrs ];

  buildPhase = ''
    cat > render.json << EOF
    {
      "${name}": {
        "dir": "svg/${type}",
        "out": "bitmaps/${name}",
        "fps": 1.2,
        "colors": [
          { "match": "#00FF00", "replace": "#${base}" },
          { "match": "#0000FF", "replace": "#${outline}" },
          { "match": "#FF0000", "replace": "#${watch_bg}" }
        ]
      }
    }
    EOF

    ctgen build.toml -p x11 -d 'bitmaps/${name}' -n '${name}' -c 'Nix-colors ${if type == "modern" then "rounded" else "sharp"} edge Bibata cursors.'
  '';

  installPhase = ''
    install -dm 0755 $out/share/icons
    cp -rf themes/* $out/share/icons/
  '';
}
