{
  inputs.nixpkgs.url = "nixpkgs/release-24.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            zsh
            stylua
            luajitPackages.luacheck
            pre-commit
          ];

          shellHook = ''
            if [[ "$(basename "$0")" != "zsh" ]]; then
                exec ${pkgs.zsh}/bin/zsh -l
            fi
          '';
        };

      });
}
