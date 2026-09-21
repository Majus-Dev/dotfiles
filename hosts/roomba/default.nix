{
  self,
  withSystem,
  lib',
  ...
}: {
  flake.nixosConfigurations.roomba = let
    hostFeatures = lib'.useFeatures self [
      "easyeffects"
      "steam"
      "controllers"
      "ffxiv"
      {
        minecraft = {
          launcher = "modrinth";
        };
      }
      {
        modding = {
          games = ["unity" "celeste" "outer wilds"];
        };
      }
      "obs"
    ];
  in
      lib'.mkHost {
      inherit self withSystem;
      configuration = _: {
        imports = with self.nixosModules;
          [
            ./hardware-configuration.nix
            host
            homeManager
            majus
          ]
          ++ hostFeatures.nixos;

        home-manager.users.majus.imports = hostFeatures.home;

        #features.niri.overrides = {
        #  outputs = {
        #    "DP-2" = {
        #      mode = "3440x1440@143.998";
        #      position = _: {
        #        props = {
        #          x = 0;
        #          y = 0;
        #        };
        #      };
        #      focus-at-startup = _: {};
        #      hot-corners = {
        #        off = _: {};
        #      };
        #    };
        #    "DP2" = {
        #      mode = "1080x1920@60.000";
        #      position = _: {
        #        props = {
        #          x = 2560;
        #          y = 300;
        #        };
        #      };
        #      hot-corners = {
        #        off = _: {};
        #      };
        #    };
        #  };
        #  workspaces = {
        #    "gaming" = _: {
        #      props = _: {
        #        open-on-output = "DP-1";
        #      };
        #    };
        #  };
        #};

        system.stateVersion = "24.05";
        networking.hostName = "roomba";

        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
      };
    };
}
