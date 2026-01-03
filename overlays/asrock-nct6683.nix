final: prev: {
  linuxPackagesFor =
    kernel:
    (prev.linuxPackagesFor kernel).extend (
      lpFinal: lpPrev: {
        asrock-nct6683 = lpFinal.callPackage (
          {
            lib,
            stdenv,
            fetchFromGitHub,
            writeText,
          }:
          stdenv.mkDerivation rec {
            pname = "asrock-nct6683";
            version = "unstable-2024-10-01";
            src = fetchFromGitHub {
              owner = "branchmispredictor";
              repo = "asrock-nct6683";
              rev = "main";
              sha256 = "sha256-VfNg2cEPSYleR0TpsghQafVarYB/2dGAUICGb06E43Y=";
            };

            patches = [
              (writeText "asrock-x670e-steel-legend.patch" ''
                --- a/nct6683.c
                +++ b/nct6683.c
                @@ -456,6 +456,8 @@ static const struct customer_family_matcher customer_family_matches[] = {
                 	CUSTOMER_MATCHES_DMI_BOARD("ASRock", "A620I Lightning WiFi",
                 				   family_asrock_writable_pwm),
                 	CUSTOMER_MATCHES_DMI_BOARD("ASRock", "B550 Taichi Razer Edition",
                +				   family_asrock_writable_pwm),
                +	CUSTOMER_MATCHES_DMI_BOARD("ASRock", "X670E Steel Legend",
                 				   family_asrock_writable_pwm),
                 	CUSTOMER_MATCHES_CUSTOMER_ID(NCT6683_CUSTOMER_ID_INTEL,
                 				     family_intel_generic),
              '')
            ];

            nativeBuildInputs = lpFinal.kernel.moduleBuildDependencies;
            makeFlags = lpFinal.kernel.makeFlags ++ [
              "KERNELRELEASE=${lpFinal.kernel.modDirVersion}"
              "KERNEL_DIR=${lpFinal.kernel.dev}/lib/modules/${lpFinal.kernel.modDirVersion}/build"
              "INSTALL_MOD_PATH=$(out)"
            ];
            buildPhase = ''
              runHook preBuild
              make -C ${lpFinal.kernel.dev}/lib/modules/${lpFinal.kernel.modDirVersion}/build M=$(pwd) modules
              runHook postBuild
            '';
            installPhase = ''
              runHook preInstall
              make -C ${lpFinal.kernel.dev}/lib/modules/${lpFinal.kernel.modDirVersion}/build M=$(pwd) INSTALL_MOD_PATH=$out modules_install
              runHook postInstall
            '';
            meta = with lib; {
              description = "NCT6683 driver with writable PWM support for ASRock motherboards";
              homepage = "https://github.com/branchmispredictor/asrock-nct6683";
              license = licenses.gpl2Only;
              platforms = platforms.linux;
            };
          }
        ) { };
      }
    );
}
