{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    material-design-icons
    font-awesome
    nerd-fonts.sauce-code-pro
  ];

  environment.systemPackages = with pkgs; [
    # ghostty terminfo (for SSH sessions from ghostty)
    ghostty.terminfo

    # archives
    zip
    xz
    unzip

    # utils
    ripgrep
    jq
    curl
    git

    # terminal multiplexer
    tmux

    # TUI tools
    lazygit
    bottom
    gdu

    # development
    rustup
    nodejs
    go

    # python
    python3
    python3Packages.pip # per-user installs: pip install --user
    uv

    # shell tools
    shellcheck
    shfmt
    qemu
  ];

  environment.variables = {
    EDITOR = "nvim";
    RUSTUP_HOME = "$HOME/.rustup";
    CARGO_HOME = "$HOME/.cargo";
  };

  # Register zsh as a valid login shell (home-manager configures the rest)
  programs.zsh.enable = true;

  # allow dynamic libraries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # add missing dynamic libraries here
  ];


  # podman
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
