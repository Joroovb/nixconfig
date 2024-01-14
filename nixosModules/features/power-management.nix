{ ... }:

{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;
  };
}
