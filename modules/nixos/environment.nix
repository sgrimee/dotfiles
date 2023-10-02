{pkgs, ...}: {
  environment = {
    etc = {
      "foggy_forest.jpg".source = ../../files/foggy_forest.jpg;
    };

    # nixos only system packages, go to /run/current-system/sw
    systemPackages = with pkgs; [
      pciutils
      wirelesstools
    ];
  };
}
