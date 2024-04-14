{
  inputs = {
    poetry-add-requirements-txt = {
      url = "github:tddschn/poetry-add-requirements.txt/710dde128b3746e7269e423f46f1e0e432c47043";
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

