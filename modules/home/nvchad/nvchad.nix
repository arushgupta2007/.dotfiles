{ pkgs, inputs, ... }:
{
    imports = [ inputs.nvchad4nix.homeManagerModules.default ];
    programs.nvchad = {
        enable = true;
        hm-activation = false;
    };
}
