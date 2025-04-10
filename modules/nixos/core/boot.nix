{ ... }:

{
  boot = {
    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      useOSProber = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      memtest86.enable = true;
    };
    loader.efi = {
      efiSysMountPoint = "/boot";
    };

    plymouth.enable = true;
  };
}

