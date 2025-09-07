{
  pkgs,
  ...
}:

{
  # TODO: add plugins
  # TODO: add some config
  environment.systemPackages = with pkgs; [ nushell ];

}
