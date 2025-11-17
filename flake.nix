{
  description = "Wump NixOS flake with musnix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    musnix.url = "github:musnix/musnix";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, musnix, home-manager, ... }: {
    nixosConfigurations.wumnix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        musnix.nixosModules.musnix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.wump = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
