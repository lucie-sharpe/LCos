{ ... }:

{
  boot = {
    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      useOSProber = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
    loader.efi = {
      efiSysMountPoint = "/boot";
    };
  };
}

