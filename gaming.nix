{ pkgs, ... }:

{

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonplus
    heroic
  ];

  programs.gamemode.enable = true;

}
