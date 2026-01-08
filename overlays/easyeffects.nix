final: prev: {
  easyeffects = prev.easyeffects.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
      prev.wrapGAppsHook3
    ];

    buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
      prev.gtk3
    ];

    postFixup = (oldAttrs.postFixup or "") + ''
      wrapProgram $out/bin/easyeffects \
        --prefix XDG_DATA_DIRS : "${prev.gtk3}/share/gsettings-schemas/${prev.gtk3.name}"
    '';
  });
}
