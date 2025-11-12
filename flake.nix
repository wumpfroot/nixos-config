{
  description = "A very basic flake with Musnix support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    musnix.url  = "github:musnix/musnix";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, musnix, home-manager, ... }@inputs:
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
          ./configuration.nix
          musnix.nixosModules.musnix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wump = import ./home.nix;
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
