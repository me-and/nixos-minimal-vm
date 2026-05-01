{ modulesPath, lib, ... }:
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
    ./vm.nix
  ];

  system.stateVersion = lib.trivial.release;

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialHashedPassword = "";
  };

  services.getty.autologinUser = "nixos";
  security.sudo.wheelNeedsPassword = false;
  programs.bash.logout = "sudo systemctl poweroff";

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
