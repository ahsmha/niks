with import <nixpkgs> {};

let
  version = "2.10";

  helloApp = stdenv.mkDerivation {
    name = "hello-${version}";

    src = fetchurl {
      url = "mirror://gnu/hello/hello-${version}.tar";
      sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
    };

    doCheck = true;
  };
in
stdenv.mkDerivation {
  name = "hello-environment";
  buildInputs = [ helloApp ];
