{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    wezterm
    # inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

}
