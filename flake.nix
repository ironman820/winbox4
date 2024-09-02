{
  inputs.std = {
    inputs.devshell.url = "github:numtide/devshell";
    url = "github:divnix/std";
  };
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    std,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      systems = ["x86_64-linux"];
      cellsFrom = ./cells;
      cellBlocks = with std.blockTypes; [
        (devshells "shell")
        (runnables "apps")
        (installables "packages")
        (functions "overlays")
      ];
    }
    {
      devShells = std.harvest inputs.self ["mine" "shell"];
      packages = std.harvest inputs.self [["mine" "packages"]];
      overlays = std.harvest self [["mine" "overlays"]];
    };
}
