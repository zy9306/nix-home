let
  sources = import ../nix/sources.nix;
  nixpkgs = sources."nixpkgs-release-20.09";
  pkgs = import nixpkgs {};
  emacs-native-comp = sources."emacs-native-comp";
  rev = emacs-native-comp."rev";
  sha256 = emacs-native-comp."sha256";
  libPath = with pkgs; lib.concatStringsSep ":" [
    "${lib.getLib libgccjit}/lib/gcc/${stdenv.targetPlatform.config}/${libgccjit.version}"
    "${lib.getLib stdenv.cc.cc}/lib"
    "${lib.getLib stdenv.glibc}/lib"
  ];
in
let
  emacsGccPGtk = builtins.foldl' (drv: fn: fn drv)
      pkgs.emacs
      [

        (drv: drv.override { srcRepo = true; })

        (
          drv: drv.overrideAttrs (
            old: {
              name = "emacsGccPGtk";
              version ="28.0.50";
              src = pkgs.fetchFromGitHub {
                owner = emacs-native-comp."owner";
                repo = emacs-native-comp."repo";
                inherit rev sha256;
              };

              configureFlags = old.configureFlags
                ++ ["--with-pgtk"];

              patches = [
                (pkgs.fetchpatch{
                  name="clean-env.patch";
                  url = "https://raw.githubusercontent.com/nix-community/emacs-overlay/master/patches/clean-env.patch";
                  sha256 = "0lx9062iinxccrqmmfvpb85r2kwfpzvpjq8wy8875hvpm15gp1s5";
                })
                (pkgs.fetchpatch{
                  name="tramp-detect-wrapped-gvfsd.patch";
                  url = "https://raw.githubusercontent.com/nix-community/emacs-overlay/master/patches/tramp-detect-wrapped-gvfsd.patch";
                  sha256 = "19nywajnkxjabxnwyp8rgkialyhdpdpy26mxx6ryfl9ddx890rnc";
                }
                )
              ];

              postPatch = old.postPatch + ''
                substituteInPlace lisp/loadup.el \
                --replace '(emacs-repository-get-version)' '"${rev}"' \
                --replace '(emacs-repository-get-branch)' '"master"'
              '';
            }
          )
        )
        (
          drv: drv.override {
              nativeComp = true;
            }
        )
      ];
in {

  inherit emacsGccPGtk;
  
  emacsGccPGtkWrapped = pkgs.symlinkJoin {
    name = "emacsGccPGtkWrapped";
    paths = [ emacsGccPGtk ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/emacs \
      --set LIBRARY_PATH ${libPath}
    '';
    meta.platforms = pkgs.stdenv.lib.platforms.linux;
    passthru.nativeComp = true;
    src = emacsGccPGtk.src;
  };
}
