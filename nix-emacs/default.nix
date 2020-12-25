let
  sources = import ../nix/sources.nix;
  nixpkgs = sources."nixpkgs-release-20.09";
  emacs-overlay = sources."emacs-overlay";
  emacs-overlay-001083a = sources."emacs-overlay-001083a";
  emacs-overlay-7678979 = sources."emacs-overlay-7678979";
  pkgs = import nixpkgs {
    overlays = [
    (import (builtins.fetchTarball {
      url = emacs-overlay.url;
    }))
    ];
  };
  pkgs-emacs-001083a = import nixpkgs {
    overlays = [
    (import (builtins.fetchTarball {
      url = emacs-overlay-001083a.url;
    }))
    ];
  };
  pkgs-emacs-7678979 = import nixpkgs {
    overlays = [
    (import (builtins.fetchTarball {
      url = emacs-overlay-7678979.url;
    }))
    ];
  };
in
{
  # rename ctags to ctags.emacs
  # 28.0.50
  # emacsGcc
  emacsGcc = pkgs.emacsGcc.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
  emacsGcc20201217 = pkgs-emacs-001083a.emacsGcc.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
  emacsGcc20201017 = pkgs-emacs-7678979.emacsGcc.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });

  # emacsPgtkGcc
  emacsPgtkGcc20201213 = pkgs-emacs-001083a.emacsPgtkGcc.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });

  emacsPgtk20201122 = pkgs-emacs-001083a.emacsPgtk.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });

  # emacsGit
  emacsGit = pkgs.emacsGit.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
  emacsUnstable = pkgs.emacsUnstable.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
}
