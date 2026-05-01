# NixOS minimal VM

This repo tracks a minimal [NixOS][] virtual machine configuration, as a
starting point for demos and tests.

[NixOS]: https://nixos.org

To start the VM, assuming you have Nix flakes configured, you should be able to
just run

    nix run github:me-and/nixos-minimal-vm

## vsftpd branch

This is a reproducer for NixOS/nixpkgs#515531.
