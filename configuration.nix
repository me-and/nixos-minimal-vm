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

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  nixpkgs.overlays = map import [ ./drkonqi.nix ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
