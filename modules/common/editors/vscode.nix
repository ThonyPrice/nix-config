{ config, pkgs, lib, ... }: {

  options.vscode.enable = lib.mkEnableOption "Enable VSCode";

  config = lib.mkIf config.vscode.enable {
    unfreePackages = [ "vscode" ];
    home-manager.users.${config.user} = {

      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            # Look and Feel
            catppuccin.catppuccin-vsc
            vscodevim.vim
            # Utils
            humao.rest-client
          ];

          userSettings = {
            "[nix]"."editor.tabSize" = 2;
            "vim.useSystemClipboard" = true;
            "workbench.colorTheme" = "Catppuccin Macchiato";
          };

        };

      };

    };

  };

}
