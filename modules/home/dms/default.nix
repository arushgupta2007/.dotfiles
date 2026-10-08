{ pkgs, lib, inputs, ...}: 
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.danksearch.homeModules.default
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dankMaterialShell changes
    };
    
    # Core features
    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    # enableClipboard = true;            # Clipboard history manager
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;  
  };

  programs.dsearch = {
    enable = true;
    
    config = {
      listen_addr = ":43654";
      max_file_bytes = 20971520;  # 20MB
      worker_count = 8;
      
      index_paths = [
        {
          path = "~/Documents";
          max_depth = 0;  # No limit
          exclude_hidden = false;
          exclude_dirs = [ ];
        }
        {
          path = "~/Desktop/Projects";
          max_depth = 8;
          exclude_hidden = true;
          exclude_dirs = [ "node_modules" "venv" "target" ".git" "dist" "build" ];
        }
        {
          path = "~/StudioProjects";
          max_depth = 8;
          exclude_hidden = true;
          exclude_dirs = [ "node_modules" "venv" "target" ".git" "dist" "build" ];
        }
      ];
    };
  };

  home.sessionVariables = {
    DMS_SCREENSHOT_EDITOR = "swappy";
  };
}

