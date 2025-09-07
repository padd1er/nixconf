{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages =
    (with pkgs; [
      age
      atuin
      bat
      bottom
      curl
      delta
      # doas-sudo-shim # NOTE: this is a dirty hack to use some doas with nixos build/test/switch
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
    ])
    ++ (with inputs.nixpkgs-stable.legacyPackages."${pkgs.system}"; [

      # delta # NOTE: this is instead lf default rustdesk which is at 1.2.3 version and fails to build due to rust 1.80.0 https://github.com/NixOS/nixpkgs/issues/332957
    ]);
}
