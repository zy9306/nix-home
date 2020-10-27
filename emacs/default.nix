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
  emacsGcc = pkgs.emacsGcc;
  emacsGit = pkgs.emacsGit;
  emacsUnstable = pkgs.emacsUnstable;
}
