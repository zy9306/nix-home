let
  pkgs = import <nixpkgs> { };
  stdenv = pkgs.stdenv;
  fetchFromGitHub = pkgs.fetchFromGitHub;
in {
  q = stdenv.mkDerivation {
    name = "q";
    src = ./.;
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp ${./utils/q.sh} $out/bin/q
    '';
  };

# 能编译安装但无法正常使用
#   proxychains-ng = stdenv.mkDerivation rec {
#     name = "proxychains-ng";
#     version = "4.14";
#
#     src = fetchFromGitHub {
#       owner = "rofl0r";
#       repo = "proxychains-ng";
#       rev = "v${version}";
#       sha256 = "03wk2xpxwc7kwlq6z9jf9df1vlh6p0dn0kf826fh1k7nfaa8c4py";
#     };
#   };
}
