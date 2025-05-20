{
  description = "Zig development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    zls.url = "github:zigtools/zls/";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachSystem (builtins.attrNames inputs.zig-overlay.packages) (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            zigpkgs = inputs.zig-overlay.packages.${prev.system};
          })
        ];
      };
      zigVersion = "master";
      zig = pkgs.zigpkgs.${zigVersion};
      zls = inputs.zls.packages.${system}.zls.overrideAttrs (old: {
        nativeBuildInputs = [zig];
      });
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          zig
          zls
        ];

        shellHook = ''
          echo 'zls' "$(zls --version)"
          echo 'zig' "$(zig version)"
        '';
      };
    });
}
