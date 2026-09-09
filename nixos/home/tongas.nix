{ pkgs, lib, ... }: {
  imports = [
    ../../home/common/core.nix
    ../../home/common/shell.nix
    ../../home/starship.nix
    ./shell.nix
  ];

  home = {
    username = "tongas";
    homeDirectory = "/home/tongas";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  # The agent commits under its own GitHub identity. No GPG key is
  # provisioned for this account, so commit signing stays off.
  programs.git = {
    enable = true;
    lfs.enable = true;

    ignores = [
      "node_modules/"
      "result"
      ".direnv*"
      ".envrc"
    ];

    settings = {
      user.name = "tongas-ai";
      user.email = "101528915+tongas-ai@users.noreply.github.com";

      core.editor = "nvim";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      log.date = "iso";
    };
  };

  home.packages = with pkgs; [
    # c/c++ toolchain
    #
    # gcc owns the generic `cc`/`c++`/`cpp` names; clang and binutils are
    # lowPrio so their overlapping wrappers (`cc`, `ld`, `as`, ...) lose the
    # collision instead of breaking the profile build. `clang`/`clang++` and
    # the binutils tools (`ar`, `nm`, `objdump`, `strip`) stay on PATH.
    gcc
    (lib.lowPrio clang)
    (lib.lowPrio binutils)
    clang-tools # clangd, clang-format, clang-tidy
    gnumake
    cmake
    ninja
    meson
    pkg-config
    autoconf
    automake
    libtool
    m4
    gettext # autopoint, for autoreconf on i18n projects
    bison
    flex
    patch
    gdb

    # typescript
    nodejs
    pnpm
    typescript
    typescript-language-server
    tsx

    # rust
    rustc
    cargo
    clippy
    rustfmt
    rust-analyzer

    # nix
    nixd
    alejandra
    statix
    deadnix

    # shell
    shellcheck
    shfmt
    bats

    # containers
    podman-compose
  ];
}
