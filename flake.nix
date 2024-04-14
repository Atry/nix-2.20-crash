{
  inputs = {
    poetry-add-requirements-txt = {
      url = "github:tddschn/poetry-add-requirements.txt";
      flake = false;
    };
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs: {
    packages = builtins.mapAttrs (system: pkgs: {
      default = 
        (inputs.poetry2nix.lib.mkPoetry2Nix {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        }).mkPoetryApplication {
          projectDir = inputs.poetry-add-requirements-txt;
          preferWheels = true;
        };
    }) inputs.nixpkgs.legacyPackages;
    

  };
}

