{
  description = "Pixtern development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    {
      devShells = nixpkgs.lib.genAttrs
        [
          "aarch64-darwin"
          "x86_64-darwin"
          "x86_64-linux"
          "aarch64-linux"
        ]
        (system:
          let
            pkgs = import nixpkgs { inherit system; };
          in
          {
            default = pkgs.mkShell {
              name = "pixtern-shell";

              packages = with pkgs; [
                nodejs_22
                bun
              ];

              shellHook = ''
                echo "🚀 Node: $(node -v)"
                echo "⚡ Bun: $(bun --version)"
              '';
            };
          }
        );
    };
}
