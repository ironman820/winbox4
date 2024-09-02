{
  cell,
  inputs,
}: let
  inherit (inputs) nixpkgs;
  desktopItem = nixpkgs.makeDesktopItem {
    name = "winbox";
    exec = "winbox";
    icon = "winbox";
    comment = "Mikrotik's WinBox router configuration application";
    desktopName = "Mikrotik WinBox";
    categories = ["X-Internet"];
  };
in rec {
  default = winbox;
  winbox = nixpkgs.stdenv.mkDerivation rec {
    name = "winbox";
    pname = name;
    version = "4.0beta3";
    buildInputs = with nixpkgs; [
      fontconfig
      freetype
      libGL
      libxkbcommon
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
      zlib
    ];
    desktopItems = [desktopItem];
    nativeBuildInputs = with nixpkgs; [
      autoPatchelfHook
      copyDesktopItems
    ];
    src = nixpkgs.fetchzip {
      sha256 = "sha256-IVQGImEtwpBepj4ualjAZBRM3qexdVnyhKYDGqbghOo=";
      stripRoot = false;
      url = "https://download.mikrotik.com/routeros/winbox/${version}/WinBox_Linux.zip";
    };

    unpackPhase = ''
      runHook preUnpack
      mkdir -p $out/bin
      cp -r $src/assets $out/bin/
      cp $src/WinBox $out/bin/winbox
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall
      install -D $src/assets/img/winbox.png $out/share/icons/hicolor/symbolic/apps/winbox.png
      runHook postInstall
    '';
    meta = with nixpkgs.lib; {
      homepage = "https://mt.lv/winbox4";
      description = "Mikrotik WinBox Application for Linux";
      platforms = platforms.linux;
      # license = licenses.unfreeRedistributable;
    };
  };
}
