{
  inputs,
  ...
}:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.danksearch.homeModules.default
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    # Core DMS features.
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };

  programs.dsearch = {
    enable = true;
    config = {
      listen_addr = ":43654";
      max_file_bytes = 20971520; # 20 MiB
      # 4 workers is enough for typical workloads on a 16 GB laptop
      # and keeps memory pressure reasonable while DMS itself runs.
      worker_count = 4;

      index_paths = [
        {
          path = "~/Documents";
          max_depth = 0;
          exclude_hidden = false;
          exclude_dirs = [ ];
        }
        {
          path = "~/Desktop/Projects";
          max_depth = 8;
          exclude_hidden = true;
          exclude_dirs = [
            "node_modules"
            "venv"
            "target"
            ".git"
            "dist"
            "build"
          ];
        }
      ];
    };
  };

  home.sessionVariables = {
    DMS_SCREENSHOT_EDITOR = "swappy";
  };
}
