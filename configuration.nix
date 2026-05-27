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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  systemd.timers.test = {
    timerConfig = {
      OnCalendar = "*:*:00";
      AccuracySec = "1s";
      RandomizedOffsetSec = "60s";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
  systemd.services.test.serviceConfig = {
    Type = "oneshot";
    ExecStart = "/run/current-system/sw/bin/echo tick";
  };

  programs.bash.loginShellInit = "systemctl status test.timer";
}
