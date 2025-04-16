{ ... }:

services = {
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # libinput.enable = true; # Input Handling
  # fstrim.enable = true; # SSD Optimizer
  # gvfs.enable = true; # For Mounting USB & More
  # openssh.enable = true; # Enable SSH
  # blueman.enable = true; # Bluetooth Support
  # tumbler.enable = true; # Image/video preview
}