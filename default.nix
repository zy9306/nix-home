# 此处添加需要构建的包,使用 ci 构建并推到缓存中

let
  emacs = import ./emacs;
in
{
  emacsGcc = emacs.emacsGcc;
  emacsGit = emacs.emacsGit;
  emacsUnstable = emacs.emacsUnstable;
}
