let
  pkgs = import <nixpkgs> { };

  python38 = pkgs.python38Full;
  python37 = pkgs.python37Full;
  python36 = pkgs.python36Full;
in { inherit python36 python37 python38; }
