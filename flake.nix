{
  description = "A very basic flake with Musnix support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    musnix.url  = "github:musnix/musnix";
    catppuccin.url = "github:catppuccin/nix/release-25.05";
  };

  outputs = { self, nixpkgs, musnix, catppuccin, ... }@inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [ musnix.overlay ];
    };

  in {
    packages.${system}.default = pkgs.hello;

    nixosConfigurations = {
      wumnix = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          musnix.nixosModules.musnix
          catppuccin.nixosModules.catppuccin
          ./configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
