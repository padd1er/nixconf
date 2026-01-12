{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    claude-code
    claude-monitor
    opencode
    gemini-cli
    codex
  ];
}
