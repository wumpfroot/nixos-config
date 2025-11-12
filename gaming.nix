{ pkgs, ... }:

{

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonplus
  ];

  programs.gamemode.enable = true;

}
