{ ... }:

{
  boot = {
    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      useOSProber = true;
      efiSupport = true;
    };
  };
}

