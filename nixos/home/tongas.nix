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

  # Ensure the pi harness itself is installed globally via npm
  home.activation.install-pi-coding-agent = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if ! ${pkgs.nodejs}/bin/npm list -g @earendil-works/pi-coding-agent &>/dev/null; then
      ${pkgs.nodejs}/bin/npm install -g @earendil-works/pi-coding-agent@0.85.1
    fi
  '';

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
    # Both cc wrappers hardcode `meta.priority = 10`, so gcc and clang tie on
    # the names they share (`cc`, `c++`, `cpp`, plus the bintools symlinks each
    # wrapper copies into its own bin) and buildEnv refuses to pick a winner.
    # hiPrio makes gcc the generic `cc`; clang keeps `clang`/`clang++`.
    # No separate binutils: the cc wrapper already exposes ld/ar/nm/objdump/strip.
    (lib.hiPrio gcc)
    clang
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

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    coreutils
    ripgrep
    jq
    yq-go
    gnugrep
    socat
    nmap
    curl
  ];
}
