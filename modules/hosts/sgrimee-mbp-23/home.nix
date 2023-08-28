{pkgs, ...}: let
  user = "sgrimee";
in {
  home-manager.users.${user} = {
    imports = [
      ./packages.nix
    ];

    home = {
      sessionVariables = {
        HOMEBREW_CASK_OPTS = "--no-quarantine";
        #ARCHFLAGS = "-arch x86_64";
        CLICOLOR = 1;
        LANG = "en_US.UTF-8";
      };

      shellAliases = {
        code = "env VSCODE_CWD=\"$PWD\" open -n -b \"com.microsoft.VSCode\" --args $*"; # create a shell alias for vs code
        #nixswitch = "darwin-rebuild switch --flake .#";
        nixswitch = "nix run nix-darwin -- switch --flake .#"; # refresh nix env after config changes
        nixup = "nix flake update; nixswitch";
      };
    };
  };
}
