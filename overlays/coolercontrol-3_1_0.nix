final: prev:
let
  version = "3.1.0";
  src = prev.fetchFromGitLab {
    owner = "coolercontrol";
    repo = "coolercontrol";
    rev = version;
    hash = "sha256-cdJEiWALqSBF8egd1uSKJO/LkVkwYER5y/7R9lPF/D4=";
  };
in
{
  coolercontrol = prev.coolercontrol // {
    coolercontrold = prev.coolercontrol.coolercontrold.overrideAttrs (
      finalAttrs: prevAttrs: {
        inherit version src;
        sourceRoot = "${src.name}/coolercontrold";
        cargoHash = "sha256-8piv20iTwEWvVF+zDdtynW7bExW3FY7J3T/+MMb+wEQ=";

        nativeBuildInputs = prevAttrs.nativeBuildInputs ++ [ final.protobuf ];

        # Must override cargoDeps to use the new source
        cargoDeps = final.rustPlatform.fetchCargoVendor {
          inherit src;
          sourceRoot = "${src.name}/coolercontrold";
          name = "${finalAttrs.pname}-${version}";
          hash = finalAttrs.cargoHash;
        };
      }
    );
    coolercontrol-ui-data = prev.coolercontrol.coolercontrol-ui-data.overrideAttrs (
      finalAttrs: prevAttrs: {
        inherit version src;
        sourceRoot = "${src.name}/coolercontrol-ui";
        npmDepsHash = "sha256-v5YMMcSFjaCsjKaAv58v4vmXqAvxHDhhdj7tvvIjDnc=";

        # Must override npmDeps to use the new source
        npmDeps = final.fetchNpmDeps {
          inherit src;
          sourceRoot = "${src.name}/coolercontrol-ui";
          name = "${finalAttrs.pname}-${version}-npm-deps";
          hash = finalAttrs.npmDepsHash;
        };
      }
    );
    coolercontrol-gui = prev.coolercontrol.coolercontrol-gui.overrideAttrs (_: {
      inherit version src;
    });
  };
}
