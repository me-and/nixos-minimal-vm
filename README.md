# NixOS minimal VM

This repo tracks a minimal [NixOS][] virtual machine configuration, as a
starting point for demos and tests.

[NixOS]: https://nixos.org

This branch is for demonstrating a bug in kdePackages.drkonqi.  To reproduce the behaviour:

1.  Start the VM.
2.  Log in (just press Return at the login prompt).
3.  Open a Konsole window.
4.  Wait a minute, then run `systemctl --user status drkonqi-coredump-pickup.service`.  Note the service is running despite there being nothing to do.
5.  Wait 30 minutes, then run `systemctl --user status drkonqi-coredump-pickup.service`.  Note that the service now reports as failed due to hitting the 30 minute timeout.

For another behaviour test, you can run `sleep infinity & kill -QUIT "$!"` in the Konsole window.  This will create a `sleep` process then trigger it to generate a coredump.  That, in turn, will give the drkonqui pickup service something to do, after which point it will exit cleanly as it ought.
