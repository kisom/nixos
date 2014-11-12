# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "havamal"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless.
  networking.interfaceMonitor.enable = false;
  networking.useDHCP = false;
  networking.wicd.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "lat9w-16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
  environment.systemPackages = with pkgs; [
      lynx emacs24 mg haskellPackages.ghc haskellPackages.xmonad
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;
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


  # Enable power management via acpid.
  services.acpid.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   name = "guest";
  #   group = "users";
  #   uid = 1000;
  #   createHome = true;
  #   home = "/home/guest";
  #   shell = "/run/current-system/sw/bin/bash";
  # };

}
