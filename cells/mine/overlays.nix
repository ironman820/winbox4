{
  cell,
  inputs,
}: rec {
  default = winbox;
  winbox = final: prev: {
    inherit (cell.apps) winbox;
  };
}
