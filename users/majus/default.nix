{
  self,
  lib',
  ...
}: let
  features
    {
      sops = {
        vaultPath = "git+ssh://git@github.com/Boiing587/vault";
        privateKeys = ["id_priv"];
      };
    }
    {
      ssh = {
        keys = [
          {
            name = "id_priv";
            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJFuposVT3zCdJsOE36vhz0N5gVYj5rom+gu4/qnKBLa"; # majus
          }
          {
            name = "id_nix";
            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOLOJZh9s8msIwJvG8utSJ0R2OlrLOzY7YXGQS2HVj1"; # nix
          }
        ];
      };
    }
    "fonts"
    "zsh"
    "flatpak"
    "xdg"
    "starship"
    "niri"
    # "hyprland"
    "hypridle"
    "hyprlock"
    "hyprpaper"
    {
      stylix = {
        wallpaper = ./wallpaper.jpg;
        cursor = "wii";
      };
    }
    "dms"
    "wezterm"
    "yazi"
    "nixvim"
    "fastfetch"
    "niks"
    "nix"
    "vicinae"
    "network"
    "cli"
    "git"
    "docker"
    "norwegian"
    "japanese"
    "pipewire"
    "zed"
    "zen"
    "discord"
    "tuigreet"
  ];
in {
  flake.nixosModules.majus = lib'.mkNixosUser {
    inherit self;
    username = "majus";
    features = features.nixos;
  };

  flake.homeModules.majus = {pkgs, ...}: {
    imports = features.home;

    home.stateVersion = "24.11";

    home.packages = with pkgs; [
      solidtime-desktop
    ];

    programs.git = {
      settings = {
        user = {
          name = "Majus-Dev"";
          email = "83781075+Majus-Dev@users.noreply.github.com";
        };
      };
    };
  };

  flake.homeConfigurations.majus = lib'.mkUser {
    inherit self;
    username = "majus";
    homeModule = self.homeModules.majus;
  };
}
