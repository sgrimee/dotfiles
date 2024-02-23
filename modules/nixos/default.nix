{
  host,
  inputs,
  user,
}: {
  # the following variables are passed to the imports (when they accept arguments):
  # config inputs lib modulesPath options overlays specialArgs stateVersion system

  imports = [
    ../hosts/${host}/system.nix
    ./authorized_keys.nix
    ./console.nix
    ./display.nix
    ./environment.nix
    ./fonts.nix
    ./greetd.nix
    ./hardware.nix
    ./i18n.nix
    ./iwd.nix
    ./keyboard.nix
    ./networking.nix
    ./nix.nix
    ./openssh.nix
    ./polkit.nix # used but sth else than wayland?
    ./printing.nix
    ./sound.nix
    ./time.nix
    ./touchpad.nix
    ./vscode-server.nix
  ];
}
