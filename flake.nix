{
  description = "Monarchic logo export tooling";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          export-pngs = pkgs.writeShellApplication {
            name = "export-pngs";
            runtimeInputs = [
              pkgs.resvg
            ];
            text = ''
              exec "${pkgs.bash}/bin/bash" "${./export_pngs.sh}" "$@"
            '';
          };

          default = self.packages.${system}.export-pngs;
        }
      );

      apps = forAllSystems (system: {
        export-pngs = {
          type = "app";
          program = "${self.packages.${system}.export-pngs}/bin/export-pngs";
          meta.description = "Export Monarchic logo PNGs from logo.svg";
        };

        default = self.apps.${system}.export-pngs;
      });

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            packages = [
              pkgs.resvg
            ];
          };
        }
      );
    };
}
