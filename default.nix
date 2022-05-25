{ stdenv, lib, mkDerivation, fetchFromGitHub, qmake, qtbase }:

stdenv.mkDerivation rec {
  pname = "selectdefaultapplication";
  version = "19";

  src = fetchFromGitHub {
    owner = "sandsmark";
    repo = "selectdefaultapplication";
    rev = "${version}";
    sha256 = "0x60pg5nl5d73av494dg29hyfml7fbf2d03wm053vx1q8a3pxbyb";
  };

  nativeBuildInputs = [ qmake ];

  buildInputs = [ qtbase ];

  installPhase = ''
    mkdir -p $out/bin
    mv ./selectdefaultapplication $out/bin
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/sandsmark/selectdefaultapplication";
    description =
      "an ugly hack to be able to select default applications in linux in a better way";
    license = licenses.gpl2;
    maintainers = with maintainers; [ rawkode ];
    homepage = "https://github.com/sandsmark/selectdefaultapplication";
  };
}

