{ compiler ? "ghc883"
# Leave the next line to use a fairly recent nixos-unstable.
, nixpkgs ? import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs-channels/archive/16fc531784ac226fb268cc59ad573d2746c109c1.tar.gz") {}
# Comment the above and uncomment the following for bleeding-edge nixos-unstable. You might want to `cachix use manuelbaerenz` or wait a long time for builds.
# , nixpkgs ? import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs-channels/archive/c59ea8b8a0e7f927e7291c14ea6cd1bd3a16ff38.tar.gz") {}
# If you have a nix-channel installed locally which you want to use, uncomment and possibly edit the following line, and comment the lines above.
# , nixpkgs ? import <nixpkgs> {}
}:

let
  inherit (nixpkgs) pkgs;

  essence-of-live-coding = haskellPackages.callHackageDirect {
    pkg = "essence-of-live-coding";
    ver = "0.2.3";
    sha256 = "1hqjpc27k9qjnyhmbhk181pl87h7mc8jxbcc09wwd0f9kx6sq9is";
  } {};
  essence-of-live-coding-gloss = haskellPackages.callHackageDirect {
    pkg = "essence-of-live-coding-gloss";
    ver = "0.2.3";
    sha256 = "1wb0y7xpmfh5d5lpjqfg9k1vnzyqhkv73hvjvxp0qz3f2d4wf6qh";
  } {};
  essence-of-live-coding-pulse = haskellPackages.callHackageDirect {
    pkg = "essence-of-live-coding-pulse";
    ver = "0.2.3";
    sha256 = "1g3r1lzbh01sbpnvwmyxkl07cpgmrin22hp1wxy00g7bl3zwzr23";
  } {};
  essence-of-live-coding-warp = haskellPackages.callHackageDirect {
    pkg = "essence-of-live-coding-warp";
    ver = "0.2.3";
    sha256 = "196ld5hqfnmri9kxksyqy2s6jp6lnjfipa9709j2bc49i6g72hzv";
  } {};

  haskellPackages = pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: {
      inherit
        essence-of-live-coding
        essence-of-live-coding-gloss
        essence-of-live-coding-pulse
        essence-of-live-coding-warp
      ;
      http-client = super.http-client_0_7_1;
    };
  };

  myPkgs = haskellPackages.extend (pkgs.haskell.lib.packageSourceOverrides {
    essence-of-live-coding-tutorial = ./.;
    # Uncomment the following lines if you have forked essence-of-live-coding and insert the appropriate path
    # essence-of-live-coding = ../essence-of-live-coding/essence-of-live-coding;
    # essence-of-live-coding-gloss = ../essence-of-live-coding/essence-of-live-coding-gloss;
  });
in
myPkgs
