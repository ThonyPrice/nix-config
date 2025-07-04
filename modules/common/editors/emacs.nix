{ config, pkgs, lib, ... }: {

  options.emacs.enable = lib.mkEnableOption "Enable common Emacs";

  config = lib.mkIf config.emacs.enable {

    # NOTE: Work in progress -> Migrate this to NixOS modules,
    # Emacs installation on MacOS is now managed by Homebrew
    # environment.systemPackages = with pkgs; [ pkgs.emacs-unstable ];

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        # Doom Emacs dependecies
        clang
        cmake
        coreutils
        emacs-all-the-icons-fonts
        fd
        gnutls
        ripgrep
        ncurses5 # Including tic, used to compile termfont
      ];

      # Configure dedicated terminfo to support emacsclient in Kitty
      # See https://github.com/kovidgoyal/kitty/issues/1141#issuecomment-779447050
      home.file.terminfo = {
        target = "${config.homePath}/.config/terminfo/xterm-emacs.ti";
        text = ''
          xterm-emacs|xterm with 24-bit direct color mode for Emacs,
            use=xterm,
            setb24=\E[48\:2\:\:%p1%{65536}%/%d\:%p1%{256}%/%{255}%&\
              %d\:%p1%{255}%&%dm,
            setf24=\E[38\:2\:\:%p1%{65536}%/%d\:%p1%{256}%/%{255}%&\
              %d\:%p1%{255}%&%dm,
        '';
      };

      home.sessionVariables = {
        EDITOR = "TERM=xterm-emacs emacsclient -t $@";
      };

      # Create quick aliases for launching Emacs
      programs.zsh = {
        shellAliases = {
          e = "TERM=xterm-emacs emacsclient -t $@";
          emacs-capture = ''
            TERM=xterm-emacs emacsclient -t -F "((name . \"capture\"))" -e "(menu-bar-mode 1)" -e "(my/org-capture-frame)"
          '';
        };
      };

    };

    # Compile custom terminfo
    # system.activationScripts.postUserActivation.text = ''
      # ${pkgs.ncurses5}/bin/tic -x -o ~/.terminfo ${config.homePath}/.config/terminfo/xterm-emacs.ti
    # '';

  };

}
