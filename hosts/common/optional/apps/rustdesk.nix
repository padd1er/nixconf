{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # rustdesk
    # rustdesk-flutter
    inputs.nixpkgs-stable.legacyPackages."${pkgs.stdenv.hostPlatform.system}".rustdesk-flutter
    (writeShellScriptBin "rustdesk-x11" ''
      export DISPLAY=:0
      export XAUTHORITY=$HOME/.Xauthority
      unset WAYLAND_DISPLAY
      unset XDG_SESSION_TYPE
      exec ${
        inputs.nixpkgs-stable.legacyPackages."${pkgs.stdenv.hostPlatform.system}".rustdesk-flutter
      }/bin/rustdesk "$@"
    '')

  ];
}
