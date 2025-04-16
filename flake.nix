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
        name = "neovim-config";
        packages = with pkgs; [
          stylua
          luajitPackages.luacheck
          lua-language-server
          pre-commit
        ];
      };

    };
}
