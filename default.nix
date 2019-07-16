{ reflex-platform ? import ./reflex-platform {} }:

reflex-platform.project ({ pkgs, ... }: {


  overrides = self: super: {
    jsaddle-warp = pkgs.haskell.lib.dontCheck super.jsaddle-warp;
  };

  packages = {
    client = ./client;
    jsaddle = ./jsaddle;
    jsaddle-warp = ./jsaddle-warp;
    websockets = ./websockets;
#    wai-websockets = ./wai-websockets;
#    wai = ./wai;
  };


  shells = {
    ghc = ["client"];
    ghcjs = ["client"];
  };
})

