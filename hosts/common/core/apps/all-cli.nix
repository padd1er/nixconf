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
    ++ (with inputs.nixpkgs-stable.legacyPackages."${pkgs.system}"; [

      # delta # NOTE: this is instead lf default rustdesk which is at 1.2.3 version and fails to build due to rust 1.80.0 https://github.com/NixOS/nixpkgs/issues/332957
    ]);
}
