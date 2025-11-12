{ config, pkgs, ... }:

{
  # Pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;
  services.pipewire.wireplumber.enable = true;

  services.pipewire.extraConfig.pipewire."pro-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 512;
      "default.clock.min-quantum" = 512;
      "default.clock.max-quantum" = 512;
    };
  };

  security.sudo.extraConfig = ''
    moritz  ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl
  '';

  musnix = {
    enable = true;
    alsaSeq.enable = false;
    rtirq.enable = true;
    rtirq.nameList = "rtc0 snd";
    rtirq.resetAll = 1;
    rtirq.prioLow = 0;
  };

  # CPU governor
  powerManagement.cpuFreqGovernor = "performance";

  # PAM
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  # Udev rules
  services.udev.extraRules = ''
    KERNEL=="rtc0", GROUP="audio"
    KERNEL=="hpet", GROUP="audio"
  '';

  # Disable cron
  services.cron.enable = false;
}
