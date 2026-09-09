{ sshKeys, ... }:
#############################################################
#
#  tongas - sandbox account for an AI agent (pi harness)
#
#  Deliberately unprivileged:
#    - not in `wheel`, so no sudo
#    - locked password, so SSH public keys are the only way in
#    - not in `nix.settings.trusted-users`
#    - not in the `podman` group: that group grants access to the
#      root podman socket, which is root-equivalent. Rootless
#      podman needs no group membership, only the subuid/subgid
#      ranges that `isNormalUser` allocates automatically.
#
#############################################################
{
  users.users.tongas = {
    isNormalUser = true;
    description = "AI agent sandbox";
    shell = "/run/current-system/sw/bin/zsh";

    # "!" is a locked password: no password login, no su/sudo auth.
    # Public key authentication is unaffected.
    hashedPassword = "!";

    extraGroups = [ ];
    openssh.authorizedKeys.keys = sshKeys;

    # Keep the tmux session and rootless podman containers alive
    # after the SSH session that started them ends.
    linger = true;
  };

  home-manager.users.tongas = import ../../home/tongas.nix;
}
