{ config, pkgs, ... }:

{

  imports = [
    #./git.nix
    #./kitty.nix
  ];


  home.username = "wump";
  home.homeDirectory = "/home/wump";

  nixpkgs.config.allowUnfree = true;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [];


  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
