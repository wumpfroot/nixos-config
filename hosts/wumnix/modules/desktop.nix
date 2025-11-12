# Add desktop packages here
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    fastfetch
    brave
    efibootmgr
    zed-editor
    kdePackages.kdenlive
    kitty
  ];
}
