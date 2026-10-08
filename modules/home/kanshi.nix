{ pkgs, ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "Default";
        profile.exec = [ ''notify-send "eDP-1" "Single-Monitor Setup Established"'' ];
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "2256x1504@60";
            position = "0,0";
          }
        ];
      }

      {
        profile.name = "DP-3";
        profile.exec = [ ''notify-send "DP-3 Connected" "Multi-Monitor Setup Established"'' ];
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "2256x1504@60";
            position = "0,0";
          }
          {
            criteria = "DP-3";
            position = "2256,0";
          }
        ];
      }

      {
        profile.name = "DP-4";
        profile.exec = [ ''notify-send "DP-4 Connected" "Multi-Monitor Setup Established"'' ];
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "2256x1504@60";
            position = "0,0";
          }
          {
            criteria = "DP-4";
            position = "2256,0";
          }
        ];
      }
    ];
  };
}

