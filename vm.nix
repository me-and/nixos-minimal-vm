# Configuration to make building the VM work.
{
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [ "${modulesPath}/virtualisation/qemu-vm.nix" ];

  # Run the VM in the terminal rather than having a GUI.
  virtualisation.graphics = false;
  virtualisation.qemu.options = [
    "-serial"
    "mon:stdio"
  ];
  environment =
    let
      resize = pkgs.writeShellScriptBin "resize" ''
        if [[ -e /dev/tty ]]; then
            old="$(stty -g)"
            stty raw -echo min 0 time 5
            printf '\033[18t' >/dev/tty
            IFS=';t' read -r _ rows cols _ </dev/tty
            stty "$old"
            stty cols "$cols" rows "$rows"
        fi
      '';
    in
    {
      systemPackages = [ resize ];
      loginShellInit = lib.getExe resize;
    };
}
