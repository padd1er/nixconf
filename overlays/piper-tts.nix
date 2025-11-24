final: prev: {
  piper-tts = prev.python3Packages.buildPythonApplication rec {
    pname = "piper-tts";
    version = "1.3.0";
    format = "wheel";
    src = prev.fetchurl {
      url = "https://files.pythonhosted.org/packages/2b/73/3d29175cfd93e791baaef3335819778d3f8c8898e2fe16cd0cc8b8163f84/piper_tts-1.3.0-cp39-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.manylinux_2_28_x86_64.whl";
      sha256 = "sha256-I0wlR0ZVsm80GLhFIsgVxD6bG8ih/bE8KyhRQpDBZfA=";
    };
    propagatedBuildInputs = with prev.python3Packages; [
      numpy
      onnxruntime
      packaging
      coloredlogs
      humanfriendly
    ];
    nativeBuildInputs = with prev; [
      makeWrapper
      autoPatchelfHook
    ];
    buildInputs = with prev; [
      stdenv.cc.cc.lib
      glibc
      zlib
      espeak-ng
    ];
    doCheck = false;
    postInstall = ''
      if [ -f $out/${prev.python3.sitePackages}/piper/libespeakbridge.so ]; then
        patchelf --set-rpath "${
          prev.lib.makeLibraryPath [
            prev.stdenv.cc.cc.lib
            prev.glibc
            prev.zlib
            prev.espeak-ng
          ]
        }" $out/${prev.python3.sitePackages}/piper/libespeakbridge.so
      fi
    '';
    postFixup = ''
      wrapProgram $out/bin/piper \
        --set LD_LIBRARY_PATH "${
          prev.lib.makeLibraryPath [
            prev.stdenv.cc.cc.lib
            prev.glibc
            prev.zlib
            prev.espeak-ng
          ]
        }" \
        --prefix PATH : ${prev.espeak-ng}/bin \
        --set ESPEAK_DATA_PATH "${prev.espeak-ng}/share/espeak-ng-data"
    '';
    meta = with prev.lib; {
      description = "Fast, local neural text to speech system";
      homepage = "https://github.com/rhasspy/piper";
      license = licenses.mit;
      platforms = platforms.linux;
      maintainers = [ ];
    };
  };
}
