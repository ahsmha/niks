with import <nixpkgs> {};

let
  simplePackage = pkgs.writeShellScriptBin "whatIsMyIp" ''
    ${pkgs.curl}/bin/curl http://httpbin.org/get \
      | ${pkgs.jq}/bin/jq --raw-output .origin
  '';
in
stdenv.mkDerivation rec {
  name = "test-environment";
  buildInputs = [ simplePackage ];
}
