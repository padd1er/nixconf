final: prev:

let
  version = "3.1.0";

  src = prev.fetchFromGitLab {
    owner = "coolercontrol";
    repo = "coolercontrol";
    rev = version;
    hash = prev.lib.fakeHash;
    # hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
in
{
  coolercontrol = prev.coolercontrol.overrideScope' (
    self: super: {
      coolercontrol-ui-data = super.coolercontrol-ui-data.override {
        inherit version src;
        npmDepsHash = prev.lib.fakeHash;
        # npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };

      coolercontrold = super.coolercontrold.override {
        inherit version src;
        cargoHash = prev.lib.fakeHash;
        # cargoHash = "sha256-CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC=";
      };

      coolercontrol-gui = super.coolercontrol-gui.override {
        inherit version src;
      };
    }
  );
}
