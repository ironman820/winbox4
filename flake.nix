{
  inputs.std = {
    inputs.devshell.url = "github:numtide/devshell";
    url = "github:divnix/std";
  };
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {std, ...} @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./cells;
      cellBlocks = with std.blockTypes; [
        (devshells "shell")
        (runnables "apps")
      ];
    }
    {
      devShells = std.harvest inputs.self ["mine" "shell"];
      packages = std.harvest inputs.self [["mine" "apps"]];
    };
}
