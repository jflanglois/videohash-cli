{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        flake-parts.flakeModules.easyOverlay
      ];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        overlayAttrs = {
          python3Packages = pkgs.python3Packages.overrideAttrs (old: {
            inherit (self'.packages) imagedominantcolor videohash;
          });
        };

        packages.imagedominantcolor = pkgs.callPackage ./nix/imagedominantcolor.nix {};
        packages.videohash = pkgs.callPackage ./nix/videohash.nix { inherit (self'.packages) imagedominantcolor; };
        packages.videohash-cli = pkgs.callPackage ./videohash-cli/default.nix { inherit (self'.packages) videohash; };
        packages.default = self'.packages.videohash-cli;
      };
    };
}
