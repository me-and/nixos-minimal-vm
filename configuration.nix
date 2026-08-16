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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
