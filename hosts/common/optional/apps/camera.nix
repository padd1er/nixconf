{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # anker camera
    cameractrls
    cameractrls-gtk4
  ];
}
