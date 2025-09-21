{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Unified Python environment with all piper-tts dependencies
    (python3.withPackages (ps: with ps; [
      numpy
      onnxruntime
      torch
      scipy
      librosa
      soundfile
      # Additional dependencies that might be needed
      pyyaml
      packaging
      requests
    ]))

    # Piper TTS and espeak-ng
    piper-tts
    espeak-ng
  ];
}