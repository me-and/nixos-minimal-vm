{ modulesPath, lib, ... }:
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
    ./vm.nix
  ];

  system.stateVersion = lib.trivial.release;

  users.users.vsftpdtest = {
    isSystemUser = true;
    group = "vsftpdtest";
    password = "12345";
  };
  users.groups.vsftpdtest = { };

  services.vsftpd = {
    enable = true;
    userlistEnable = true;
    userlist = [ "vsftpdtest" ];
    localUsers = true;
  };
  networking.firewall.allowedTCPPorts = [ 20 21 ];
}
