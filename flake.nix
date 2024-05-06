{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixos-apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
  };

  outputs = { self, nixpkgs, nixos-apple-silicon, ... }@inputs: let
    mkSystem = name: system: extraModules: extraConfig: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        (./machines + "/${name}/configuration.nix")
        (./machines + "/${name}/hardware-configuration.nix")
      ] ++ extraModules ++ [ extraConfig ];
    };
  in {
    nixosConfigurations = {
      # M2 Macbook Asahi
      ah64-asahi = mkSystem "ah64-asahi" "aarch64-linux" [ nixos-apple-silicon.nixosModules.apple-silicon-support ] {};
      # Thelio Desktop
      ah64-thelio = mkSystem "ah64-thelio" "x86_64-linux" [] {};
      # Framework Laptop
      ah64-framework = mkSystem "ah64-framework" "x86_64-linux" [] {};
      # Dell XPS Laptop
      ah64-xps = mkSystem "ah64-xps" "x86_64-linux" [] {};
    };
  };
}
