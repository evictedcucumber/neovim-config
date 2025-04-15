{
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [ zsh stylua luajitPackages.luacheck pre-commit ];

        shellHook = ''
          if [[ "$(basename "$0")" != "zsh" ]]; then
              exec ${pkgs.zsh}/bin/zsh -l
          fi
        '';
      };

    };
}
