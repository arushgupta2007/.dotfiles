{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    # Python
    (python3.withPackages (python-pkgs: with python-pkgs; [
      # select Python packages here
      numpy
      pandas
      tqdm
      matplotlib
      scipy
      requests
      sympy
      pillow
      plotly
      jsonpickle
      dbus-python

      black
    ]))
    (pkgs.writeShellScriptBin "python" ''
      export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
      exec ${pkgs.python3}/bin/python "$@"
    '')
  ];
}

