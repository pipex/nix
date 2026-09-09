{ pkgs, ... }: {
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
