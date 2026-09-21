{
  pkgs,
  ...
}: {
  flake.nixosModules.wootility = _: {
    services.udev.extraRules = [./wootility.rules];
  };

  flake.homeModules.wootility = {pkgs, ...}: {
    home.packages = with pkgs; [wootility];
  };
}
