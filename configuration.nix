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
}
