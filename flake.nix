# /etc/nixos/flake.nix

{
  description = "My NixOS config with flakes, home-manager and stylix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # or your chosen channel
    omarchy-nix = {
      url = "github:henrysipp/omarchy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, stylix, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        nixosConfigurations."hyprland-laptop" = pkgs.lib.nixosSystem {
          system = system;
          modules = [
            # Stylix NixOS module (see Stylix docs)
            stylix.nixosModules.stylix
            # Home-Manager NixOS module so home-manager is a NixOS module
            home-manager.nixosModules.home-manager
            # Your main system config (make a small config.nix next)
            ./configuration.nix
            ./config.nix

            omarchy-nix.nixosModules.default
            {
              omarchy = {
                # Replace with your user name!
                full_name = "user"
                email_address = "something for now"
                theme = "tokyo-night"
              };

              home-manager = {
                # Replace with your user name!
                users.your-username = {
                  imports = [omarchy-nix.homeManagerModules.default];
                }
              }
            }


          ];
          specialArgs = { inherit inputs; };
        };
      });
}
