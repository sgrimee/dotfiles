{
  inputs,
  pkgs,
  system,
  unstable,
  ...
}: {
  home.packages = with pkgs; [
    # common packages, found in ~/.nix-profile/bin
    age
    alejandra
    coreutils-full
    curl
    du-dust
    glow # CLI markdown viewer
    hamlib_4
    home-manager
    htop
    inetutils
    joshuto
    killall
    less
    inputs.mactelnet.packages.${system}.mactelnet
    mc
    mitmproxy
    neofetch
    nixpkgs-fmt
    openssh
    pat
    podman
    progress
    ripgrep
    rnix-lsp
    rustscan
    rustup
    sops
    spotify-tui
    spotifyd
    ssh-to-age
    trippy
    unzip
    inputs.unstable.legacyPackages.${system}.vscode-langservers-extracted
    wget
    yt-dlp
    zellij
    zip
  ];
}
