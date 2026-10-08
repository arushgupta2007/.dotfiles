{ pkgs, lib, ... }:
with lib;
let
  browser = [ "brave-browser.desktop" "chromium.desktop" "floorp.desktop" ];
  text = [ "codium.desktop" "org.gnome.TextEditor.desktop" ];
  image = [ "com.interversehq.qView.desktop" ];
  audio = [ "vlc.desktop" ];
  video = [ "vlc.desktop" ];
  directory = [
    "nautilus.desktop"
    "org.gnome.Nautilus.desktop"
  ];
  office = [ "libreoffice.desktop" ];
  pdf = [ "zatura.desktop" ];
  terminal = [ "kitty.desktop" ];
  archive = [ "org.gnome.FileRoller.desktop" ];

  mimeAssosiation = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;

    "text/plain" = text;

    "image/bmp" = image;
    "image/gif" = image;
    "image/jpeg" = image;
    "image/jpg" = image;
    "image/png" = image;
    "image/svg+xml" = image;
    "image/tiff" = image;
    "image/vnd.microsoft.icon" = image;
    "image/webp" = image;

    "video/mp2t" = video;
    "video/mp4" = video;
    "video/mpeg" = video;
    "video/ogg" = video;
    "video/webm" = video;
    "video/x-flv" = video;
    "video/x-matroska" = video;
    "video/x-msvideo" = video;
    "video/quicktime" = video;

    "inode/directory" = directory;

    "application/vnd.oasis.opendocument.text" = office;
    "application/vnd.oasis.opendocument.spreadsheet" = office;
    "application/vnd.oasis.opendocument.presentation" = office;
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = office;
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = office;
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = office;
    "application/msword" = office;
    "application/vnd.ms-excel" = office;
    "application/vnd.ms-powerpoint" = office;
    "application/rtf" = office;

    "application/pdf" = pdf;

    "terminal" = terminal;

    "application/zip" = archive;
    "application/rar" = archive;
    "application/7z" = archive;
    "application/*tar" = archive;
  };
in
{
  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = mimeAssosiation;
  xdg.mimeApps.defaultApplications = mimeAssosiation;

  home.sessionVariables = {
    # prevent wine from creating file associations
    WINEDLLOVERRIDES = "winemenubuilder.exe=d";
  };
}

# { pkgs, lib, ... }:
# with lib;
# let
#   defaultApps = {
#     browser = [ "brave-browser.desktop" ];
#     text = [ "org.gnome.TextEditor.desktop" ];
#     image = [ "com.interversehq.qView.desktop" ];
#     audio = [ "mpv.desktop" ];
#     video = [ "mpv.desktop" ];
#     directory = [
#       "nautilus.desktop"
#       "org.gnome.Nautilus.desktop"
#     ];
#     office = [ "libreoffice.desktop" ];
#     pdf = [ "org.gnome.Evince.desktop" ];
#     terminal = [ "kitty.desktop" ];
#     archive = [ "org.gnome.FileRoller.desktop" ];
#   };
#
#   mimeMap = {
#     text = [ "text/plain" ];
#     image = [
#       "image/bmp"
#       "image/gif"
#       "image/jpeg"
#       "image/jpg"
#       "image/png"
#       "image/svg+xml"
#       "image/tiff"
#       "image/vnd.microsoft.icon"
#       "image/webp"
#     ];
#     audio = [
#       "audio/aac"
#       "audio/mpeg"
#       "audio/ogg"
#       "audio/opus"
#       "audio/wav"
#       "audio/webm"
#       "audio/x-matroska"
#     ];
#     video = [
#       "video/mp2t"
#       "video/mp4"
#       "video/mpeg"
#       "video/ogg"
#       "video/webm"
#       "video/x-flv"
#       "video/x-matroska"
#       "video/x-msvideo"
#     ];
#     directory = [ "inode/directory" ];
#     browser = [
#       "text/html"
#       "x-scheme-handler/about"
#       "x-scheme-handler/http"
#       "x-scheme-handler/https"
#       "x-scheme-handler/unknown"
#     ];
#     office = [
#       "application/vnd.oasis.opendocument.text"
#       "application/vnd.oasis.opendocument.spreadsheet"
#       "application/vnd.oasis.opendocument.presentation"
#       "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
#       "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
#       "application/vnd.openxmlformats-officedocument.presentationml.presentation"
#       "application/msword"
#       "application/vnd.ms-excel"
#       "application/vnd.ms-powerpoint"
#       "application/rtf"
#     ];
#     pdf = [ "application/pdf" ];
#     terminal = [ "terminal" ];
#     archive = [
#       "application/zip"
#       "application/rar"
#       "application/7z"
#       "application/*tar"
#     ];
#   };
#
#   associations =
#     with lists;
#     listToAttrs (
#       flatten (mapAttrsToList (key: map (type: attrsets.nameValuePair type defaultApps."${key}")) mimeMap)
#     );
# in
# {
#   xdg.configFile."mimeapps.list".force = true;
#   xdg.mimeApps.enable = true;
#   xdg.mimeApps.associations.added = associations;
#   xdg.mimeApps.defaultApplications = associations;
#
#   home.packages = with pkgs; [ junction ];
#
#   home.sessionVariables = {
#     # prevent wine from creating file associations
#     WINEDLLOVERRIDES = "winemenubuilder.exe=d";
#   };
# }
