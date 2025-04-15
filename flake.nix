{
  inputs.nixpkgs.url = "nixpkgs/release-24.11";

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
