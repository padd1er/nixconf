{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.pl_PL
    hunspellDicts.en_US
    hunspellDicts.ru_RU
  ];
}
