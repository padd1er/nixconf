{
  pkgs,
  overlays,
  ...
}:

{
  nixpkgs.overlays = [ overlays.piper-tts ];

  environment = {
    systemPackages = with pkgs; [
      piper-tts
      espeak-ng
    ];
  };
}
