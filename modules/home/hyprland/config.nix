{ pkgs, inputs, ... }: 
{
  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # plugins = [ inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo ];
    settings = {
      # autostart
      exec-once = [
        "systemctl --user import-environment &"
        "hash dbus-update-activation-environment 2>/dev/null &"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"
        "nm-applet &"
        "wl-clip-persist --clipboard both"
        "swaybg -m fill -i $(find ~/Pictures/wallpapers/ -maxdepth 1 -type f) &"
        "hyprctl setcursor Bibata-Modern-Ice 24 &"
        "poweralertd &"
        "waybar &"
        "swaync &"
        "wl-paste --watch cliphist store &"
        "hypridle &"
        # "hyprlock"

        ## App auto start
        "[workspace 1 silent] brave"
        "[workspace 2 silent] kitty"
      ];

      input = {
        kb_layout = "us";
        kb_options ="ctrl:nocaps"; 
        numlock_by_default = true;
        follow_mouse = 2;
        float_switch_override_focus = 0;
        mouse_refocus = 1;
        sensitivity = 0.4;
        touchpad = {
          natural_scroll = true;
        };
      };

      general = {
        "$mainMod" = "SUPER";
        layout = "dwindle";
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgb(98971a) rgb(cc241d) 45deg";
        "col.inactive_border" = "0x00000000";

        snap = {
          enabled = true;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = true;
        enable_swallow = true;
        focus_on_activate = true;
        middle_click_paste = true;
      };


      decoration = {
        rounding = 10;
        active_opacity = 0.95;
        inactive_opacity = 0.85;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 2;
          passes = 2;
          # size = 4;
          # passes = 2;
          brightness = 1;
          contrast = 1.400;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        shadow = {
          enabled = true;
          range = 20;
          ignore_window = true;
          offset = "0 2";
          color = "rgba(00000055)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];

        animation = [
          # Windows
          "windowsIn, 1, 3, easeOutCubic, popin 30%" # window open
          "windowsOut, 1, 3, fluent_decel, popin 70%" # window close.
          "windowsMove, 1, 2, easeinoutsine, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn, 1, 3, easeOutCubic" # fade in (open) -> layers and windows
          "fadeOut, 1, 2, easeOutCubic" # fade out (close) -> layers and windows
          "fadeSwitch, 0, 1, easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow, 1, 10, easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim, 1, 4, fluent_decel" # the easing of the dimming of inactive windows
          "border, 1, 2.7, easeOutCirc" # for animating the border's color switch speed
          "borderangle, 1, 30, fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces, 1, 4, easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };

      bind = [
        # show keybinds list
        "$mainMod, F1, exec, show-keybinds"

        # keybindings
        "$mainMod, Return, exec, kitty"
        "ALT, Return, exec, kitty --title float_kitty"
        "$mainMod SHIFT, Return, exec, nautilus"
        "$mainMod, B, exec, hyprctl dispatch exec '[workspace 1] brave'"
        "$mainMod, Q, killactive,"
        "$mainMod, F, fullscreen, 0"
        "$mainMod SHIFT, F, fullscreen, 1"
        "$mainMod, Space, togglefloating,"
        "$mainMod, D, exec, rofi -show drun"
        # "$mainMod, ALT, Escape, exec, swaylock"
        "$mainMod, Escape, exec, hyprlock"
        "$mainMod SHIFT, Escape, exec, power-menu"
        "$mainMod, P, pseudo,"
        "$mainMod SHIFT, J, togglesplit,"
        "$mainMod, T, exec, toggle_oppacity"
        "$mainMod SHIFT, B, exec, toggle_waybar"
        "$mainMod, C ,exec, hyprpicker -a"
        "$mainMod, W,exec, wallpaper-picker"
        "$mainMod, N, exec, swaync-client -t -sw"
        "$mainMod SHIFT, W, exec, vm-start"

        # screenshot
        "$mainMod, Print, exec, grimblast --notify --cursor --freeze save area ~/Pictures/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"
        ",Print, exec, grimblast --notify --freeze copy area"

        # switch focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # switch workspace
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, z, focuscurrentorlast"

        # same as above, but switch to the workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        "$mainMod CTRL, c, movetoworkspace, empty"

        # window control
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod CTRL, left, resizeactive, -80 0"
        "$mainMod CTRL, right, resizeactive, 80 0"
        "$mainMod CTRL, up, resizeactive, 0 -80"
        "$mainMod CTRL, down, resizeactive, 0 80"
        "$mainMod ALT, left, moveactive,  -80 0"
        "$mainMod ALT, right, moveactive, 80 0"
        "$mainMod ALT, up, moveactive, 0 -80"
        "$mainMod ALT, down, moveactive, 0 80"

        # media and volume controls
        ",XF86AudioRaiseVolume,exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
        ",XF86AudioLowerVolume,exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
        ",XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop, exec, playerctl stop"
        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"

        # laptop brigthness
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
        "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"

        # clipboard manager
        "$mainMod, V, exec, cliphist list | rofi -dmenu -theme-str 'window {width: 50%;}' | cliphist decode | wl-copy"
      ];

      # mouse binding
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # windowrule
      windowrule = [
        "float on, match:class qView"
        "center on, match:class qView"
        "size 1200 725, match:class qView"

        "float on, match:class imv"
        "center on, match:class imv"
        "size 1200 725, match:class mpv"

        "float on, match:title ^(float_kitty)$"
        "center on, match:title ^(float_kitty)$"
        "size 950 600, match:title ^(float_kitty)$"

        "float on, match:class audacious"

        "pin on, match:class rofi"

        "tile on,  match:class neovide"

        "idle_inhibit focus, match:class mpv"

        "float on, match:class udiskie"

        "float on, match:title ^(Transmission)$"
        "float on, match:title ^(Volume Control)$"
        "float on, match:title ^(Firefox — Sharing Indicator)$"
        "size 700 450, match:title ^(Volume Control)$"
        "move 40 55%, match:title ^(Volume Control)$"

        "opacity 1, match:title ^(KDE Connect Daemon)"
        "no_blur on, match:title ^(KDE Connect Daemon)"
        "no_shadow on, match:title ^(KDE Connect Daemon)"
        "float on, match:title ^(KDE Connect Daemon)"
        "pin on, match:title ^(KDE Connect Daemon)"
        "min_size 2256 1504, match:title ^(KDE Connect Daemon)"
        "move 50% 50%, match:title ^(KDE Connect Daemon)"

        "float on, match:title ^(Picture-in-Picture)$"
        "pin on, match:title ^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, match:title ^(.*imv.*)$"
        "opacity 1.0 override 1.0 override, match:title ^(.*mpv.*)$"
        "opacity 1.0 override 1.0 override,  match:class seprite"
        "opacity 1.0 override 1.0 override,  match:class nity"
        "opacity 1.0 override 1.0 override,  match:class loorp"
        "opacity 1.0 override 1.0 override,  match:class rave"
        "opacity 1.0 override 1.0 override,  match:class vince"
        "workspace 1,  match:class floorp$"
        "workspace 1,  match:class brave$"
        "workspace 6,  match:class discord$"
        "workspace 7,  match:class Gimp-2.10$"
        "workspace 8,  match:class Aseprite$"
        "workspace 8,  match:class Audacious$"
        "workspace 9,  match:class Spotify$"
        "idle_inhibit fullscreen,  match:class firefox$"
        "size 850 500, match:title ^(File Upload)$"
        "float on, match:class pavucontrol$"
        "float on, match:class SoundWireServer$"
        "float on, match:class .sameboy-wrapped$"
        "float on, match:class file_progress$"
        "float on, match:class confirm$"
        "float on, match:class dialog$"
        "float on, match:class download$"
        "float on, match:class notification$"
        "float on, match:class error$"
        "float on, match:class confirmreset$"
        "float on, match:title ^(Open File)$"
        "float on, match:title ^(File Upload)$"
        "float on, match:title ^(branchdialog)$"
        "float on, match:title ^(Confirm to replace files)$"
        "float on, match:title ^(File Operation Progress)$"

        "opacity 0.0 override, match:class xwaylandvideobridge$"
        "no_anim on, match:class xwaylandvideobridge$"
        "no_initial_focus on, match:class xwaylandvideobridge$"
        "max_size 1 1, match:class xwaylandvideobridge$"
        "no_blur on, match:class xwaylandvideobridge$"
      ];

      layerrule = [
        "blur on, match:namespace swaync-control-center"
        "blur on, match:namespace swaync-notification-window"
        "ignore_alpha 0, match:namespace swaync-control-center"
        "ignore_alpha 0, match:namespace swaync-notification-window"
      ];
    };

    extraConfig = "
      # monitor=,preferred,auto,auto
      monitor=eDP-1,2256x1504@60,0x0,1

      xwayland {
        force_zero_scaling = true
      }
    ";
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
    };
  };
}
