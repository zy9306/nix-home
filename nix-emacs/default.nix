let
  sources = import ../nix/sources.nix;
  nixpkgs = sources."nixpkgs-unstable";
  emacs-overlay = sources."emacs-overlay";
  pkgs = import nixpkgs {
    overlays = [
    (import (builtins.fetchTarball {
      url = emacs-overlay.url;
    }))
    ];
  };
in
{
  # rename ctags to ctags.emacs
  emacsGcc = pkgs.emacsGcc.overrideAttrs (old: {
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
