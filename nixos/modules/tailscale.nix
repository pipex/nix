{ ... }: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # DNS is left to tailscaled, which registers a split-DNS resolvconf record
  # for the tailnet and leaves DHCP-provided resolvers in place. Setting
  # networking.nameservers here would pin a static resolvconf record at
  # metric 1 and, since glibc reads at most MAXNS (3) nameservers, silently
  # drop every LAN resolver.

  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    # Always allow traffic from your Tailscale network
    trustedInterfaces = [ "tailscale0" ];
    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ 41641 ];
  };

  # Force tailscaled to use nftables (Critical for clean nftables-only systems)
  # This avoids the "iptables-compat" translation layer issues.
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];
}
