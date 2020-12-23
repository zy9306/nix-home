let
  sources = import ../nix/sources.nix;
  nixpkgs = sources."nixpkgs-release-20.09";
  emacs-overlay = sources."emacs-overlay";
  emacs-overlay-emacs-gcc-20201217 = sources."emacs-overlay-emacs-gcc-20201217";
  emacs-overlay-emacs-gcc-20201017 = sources."emacs-overlay-emacs-gcc-20201017";
  pkgs = import nixpkgs {
    overlays = [
    (import (builtins.fetchTarball {
      url = emacs-overlay.url;
    }))
    ];
  };
  pkgs-emacs-gcc-20201217 = import nixpkgs {
    overlays = [
    (import (builtins.fetchTarball {
      url = emacs-overlay-emacs-gcc-20201217.url;
    }))
    ];
  };
  pkgs-emacs-gcc-20201017 = import nixpkgs {
    overlays = [
    (import (builtins.fetchTarball {
      url = emacs-overlay-emacs-gcc-20201017.url;
    }))
    ];
  };
in
{
  # rename ctags to ctags.emacs
  # 28.0.50
  emacsGcc = pkgs.emacsGcc.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
  emacsGcc20201217 = pkgs-emacs-gcc-20201217.emacsGcc.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
  emacsGcc20201017 = pkgs-emacs-gcc-20201017.emacsGcc.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });

  emacsGit = pkgs.emacsGit.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
  emacsUnstable = pkgs.emacsUnstable.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
}
