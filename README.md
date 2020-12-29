![Build](https://github.com/zy9306/nix-home/workflows/Build/badge.svg)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [nix environment](#nix-environment)
    - [安装 nix](#安装-nix)
    - [cachix](#cachix)
    - [niv(用于锁定依赖)](#niv用于锁定依赖)
    - [一些常用命令](#一些常用命令)
        - [nix-shell 使用](#nix-shell-使用)
        - [构建](#构建)
        - [安装](#安装)
        - [查询](#查询)
        - [升级](#升级)
        - [删除](#删除)
        - [回滚](#回滚)
        - [安装时解决冲突和优先级](#安装时解决冲突和优先级)

<!-- markdown-toc end -->


# nix environment

`git clone --recurse-submodules git@github.com:zy9306/nix-home.git`

or

`git clone --recursive git://github.com/foo/bar.git` with version 1.9 of Git up until version 2.12.

or 

```
git clone git@github.com:zy9306/nix-home.git
cd private
git submodule update --init --recursive
```

## 安装 nix

> https://nixos.org/download.html#nix-quick-install

```shell
curl -L https://nixos.org/nix/install | sh
```

注意：必须以非 `root` 用户安装

## cachix

> https://app.cachix.org/cache/arcueid

其中 `arcueid` 为创建 cache 时填写的名字

- 配置 cachix

    参考 `Push binaries` 部分

- 使用 cachix

    参考 `Pull binaries` 部分

    注意: 如果是私有仓库, 需要 `cachix authtoken {your authtoken}`

- Github CI 配置

    > https://nix.dev/tutorials/continuous-integration-github-actions.html

- 其它 CI 配置

    > https://docs.cachix.org/continuous-integration-setup/index.html

- 详细文档

    > https://docs.cachix.org/installation.html

## niv(用于锁定依赖)

- `niv add NixOS/nixpkgs -n {名称} -b {分支名}`

    `niv add NixOS/nixpkgs -n nixpkgs-unstable -b nixpkgs-unstable`

- `niv add NixOS/nixpkgs -n {名称} -r {commitID}`

    `niv add NixOS/nixpkgs -n nixpkgs-528d35b -r 528d35bec0cb976a06cc0e8487c6e5136400b16b`

要查找某些包的旧版本存在于哪个 commit 可以使用,但并不一定全 https://lazamar.co.uk/nix-versions/


## 一些常用命令

### nix-shell 使用

可用于启用一个含指定 pkg 的 shell 环境或构造一个含相应编译依赖的环境。

```
nix-shell \
    [--arg name value] \
    [--argstr name value] \
    [ { --attr | -A } attrPath ] \
    [--command cmd] [--run cmd] \
    [--exclude regexp] \
    [--pure] \
    [--keep name] \
    { { --packages | -p } packages... | [path]}
```

- `nix-shell '<nixpkgs>' -p <pkg>`

    将启动一个 shell，该 shell 中包含 pkg。pkg 为 nixpkgs 中的属性名，可由 nix-env 查询得到。

- `nix-shell '<nixpkgs>' -p <pkg> --pure`

    --pure 的作用为不继承宿主机环境

### 构建

- `nix-build -A {attrPath} {paths}`

    构建一个包

    attrPath 为 nix 文件中定义的属性名/包名 paths 为 nix 文件路径

    nix-build 不加参数会构建所有属性

        nix-build -A emacsGcc ./emacs/default.nix

        nix-build --dry-run

### 安装

- `nix-env -iA {pkg} -f {paths}`

    从文件中安装一个包

    pkg 为 nix 文件中定义的属性名/包名 paths 为 nix 文件路径，或者 url

        nix-env -iA emacsGcc -f ./emacs

- `nix-env --install gcc-3.3.2`

- `nix-env -i -A gcc40mips`

- `nix-env -f ~/foo.nix -i '.*'`

    安装一个文件中的所有包

- `nix-env -iA emacsGcc -f ./emacs --dry-run`

    不实际安装，仅查看安装内容

### 查询

- `nix-env -qaP {pkg}`

    查询 pkg , 支持通配符

- `nix-env -qa -f {paths}`

    查询 nix 文件中的包

- `nix-env -q`

    To show installed packages

- `nix-env -qa '.*(firefox|chromium).*'`

    To show all packages with “firefox” or “chromium” in the name

### 升级

- `nix-env --upgrade gcc`

    升级

### 删除

- `nix-env --uninstall gcc`

    删除

- `nix-env -e '.*'`

    remove everything

### 回滚

- `nix-env --list-generations`

- `nix-env --rollback {generation}`

    配合 --list-generations 使用

### 安装时解决冲突和优先级

- `--set-flag`
    - `nix-env --set-flag keep true firefox`

        nix-env -u 里不会更新 firefox

    - `--preserve-installed`

        保留旧版本 firefox 配置文件的情况下安装新的 firefox

        - nix-env --set-flag active false firefox
        - nix-env --preserve-installed -i firefox-2.0.0.11
        - nix-env -q

          firefox-2.0.0.11 (the enabled one) firefox-2.0.0.9 (the disabled one)

    - `--set-flag priority`

        设置优先级，priority 越小优先级越高 nix-env --set-flag priority {priority} gcc
