# Mikrotik Winbox v4 (Beta)

This flake is set to grab a copy of the latest beta from Mikrotik's website, and uses their icon to create a desktop file. The version update is a manual process, however I use winbox almost daily so I should be able to keep up with updates when Mikrotik releases them.

## Usage

Running or installation is fairly straight forward:

Running independently with flakes:

```bash
nix run github:ironman820/winbox4
```

If you use flakes already, you can also import the package into your existing configuration:

```nix
{
  inputs = {
    ...
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    winbox4 = {
      inputs.nixpkgs.follows = "unstable";
      url = "github:ironman820/winbox4";
    };
    ...
  };

  ...
}
```

Then you can install the packages by adding this to your `environment.systemPackages` declaration:
```nix
inputs.winbox4.packages.${pkgs.system}.winbox

# OR

inputs.winbox4.packages.x86_64-linux.winbox
```


This is a very brief overview of installing with flakes. This package was built with divnix/std, so it will pull in their library as an overlay. If you already use Hive/std, you might consider overriding the std input for this package:
```nix
inputs.std.follows = "std";
```

Also, the derivation is built off of `unstable` as that is what I use as a daily driver, you should be able to build with a stable release branch, as the application uses standard libraries, however I have not expressly tested that setup.

