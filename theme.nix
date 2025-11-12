{ config, pkgs, ... }:

{
  # Import the Catppuccin NixOS module
  imports = [
    /nix/store/xj774cg7msasl1xmlsb8fz48zisrk2ih-whiskers-2.5.1/module.nix
  ];

  # Enable Catppuccin
  catppuccin.enable = true;

  # Choose the flavor variant
  catppuccin.flavor = "macchiato"; # latte, frappe, macchiato, mocha

  # Choose the accent
  catppuccin.accent = "sky"
}
