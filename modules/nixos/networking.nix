{ ... }:
{
  networking.hostName = "nixos";
	networking.networkmanager.enable = true;
	networking.firewall = {
		enable = true;
		allowedTCPPorts = [ 8081 ];
	};
}

