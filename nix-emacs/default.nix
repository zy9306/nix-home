let
  sources = import ../nix/sources.nix;
  nixpkgs = sources."nixpkgs-release-20.09";
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
  # 28.0.50
  emacsGcc = pkgs.emacsGcc.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
  emacsGit = pkgs.emacsGit.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
  emacsUnstable = pkgs.emacsUnstable.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ ["--program-transform-name='s/^ctags$/ctags.emacs/'"];
  });
}
