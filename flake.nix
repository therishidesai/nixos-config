{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: let
    mkSystem = name: system: extraConfig: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        (./machines + "/${name}/configuration.nix")
        (./machines + "/${name}/hardware-configuration.nix")
      ] ++ [ extraConfig ];
    };
  in {
    nixosConfigurations = {
      # Thelio Desktop
      ah64-thelio = mkSystem "ah64-thelio" "x86_64-linux" {};
      # Framework Laptop
      ah64-framework = mkSystem "ah64-framework" "x86_64-linux" {};
      # Dell XPS Laptop
      ah64-xps = mkSystem "ah64-xps" "x86_64-linux" {};
    };
  };
}
