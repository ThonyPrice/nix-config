{ config, pkgs, lib, ... }: {

  options.kubernetes.enable = lib.mkEnableOption "Kubernetes tools.";

  config = lib.mkIf config.kubernetes.enable {
    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        kubectl # Basic Kubernetes queries
        kubernetes-helm # Helm CLI
        kubectx # Kubernetes context manager
        kustomize # Kustomize CLI
      ];

      programs.zsh.shellAliases = {
        k = "kubectl";
      };

      # Terminal Kubernetes UI
      programs.k9s = {
        enable = true;
      };

    };

  };

}
