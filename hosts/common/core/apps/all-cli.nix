{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages =
    (with pkgs; [
      age # TODO:remove when confirmed rage is working
      rage
      atuin
      bat
      bottom
      curl
      delta
      exiftool
      eza
      fd
      fzf
      git
      gnugrep
      gnumake
      gping
      gtrash
      jq
      just
      killall
      lazydocker
      lazygit
      lf
      nix-output-monitor
      nix-search-cli
      nvd
      procs
      ripgrep
      shfmt
      sops
      ssh-to-age
      starship
      stow
      superfile
      superfile
      unar
      unzip
      wget
      yazi
      zellij
      zip
      zoxide
      usbutils
    ])
    ++ (with inputs.nixpkgs-stable.legacyPackages."${pkgs.stdenv.hostPlatform.system}"; [
    ]);
}
