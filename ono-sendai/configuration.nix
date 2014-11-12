# ono-sendai is a Lenovo X230 Thinkpad.

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.luks.devices = [{
    name = "nixos";
    device = "/dev/sda3";
    preLVM = true;
  }];

  networking.hostName = "ono-sendai"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless.
  networking.interfaceMonitor.enable = false;
  networking.useDHCP = false;
  networking.wicd.enable = true;

  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
  environment.systemPackages = with pkgs; [
      lynx
      emacs24
      mg
      haskellPackages.ghc
      haskellPackages.xmonad
      dhcp 
      pmutils
      xscreensaver
      xlibs.xmodmap
      git
      clang
      mercurial
      automake
      autoconf
      libtool
      dmenu
      gnupg
      cmus
  ];

  services.openssh.enable = true;
  services.upower.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.default = "xmonad";
  services.xserver.desktopManager.default = "none";
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  # load xmodmap, xscreensaver.
  services.xserver.displayManager.sessionCommands = ''
    # Export the config/themes for slimlock.
    export SLIM_THEMESDIR=/nix/store/b3p1w1bn3vz68ijpqbz6
    xmodmap $HOME/.xmodmaprc
    xscreensaver -no-splash &
  '';

  environment.shells = [
    "/nix/store/6p79b078lngvnd8paj50pyi7ylfpisij-system-path/bin/fish"
  ];

  time.timeZone = "PST8PDT";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];

}
