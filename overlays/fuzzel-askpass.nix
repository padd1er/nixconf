final: prev: {
  fuzzel-askpass = prev.writeShellScriptBin "fuzzel-askpass" ''
    #!/usr/bin/env bash

    prompt="$*"

    if [ -z "$prompt" ]; then
      prompt="🔒Password"
    fi

    if [[ "$prompt" =~ "Confirm user presence" ]] && [[ ! "$prompt" =~ "Enter PIN" ]]; then
      #NOTE: For yubikey tap-only confirmation, return empty immediately
      echo ""
      exit 0
    fi

    #NOTE: Shorten the prompt of yubikey for better visibility
    if [[ "$prompt" =~ "Enter PIN and confirm user presence" ]]; then
      prompt="🔒YubiKey PIN + TAP"
    fi

    prompt="''${prompt%:}"

    result=$(${final.fuzzel}/bin/fuzzel --dmenu --password \
      --cache /dev/null \
      --prompt="$prompt: " \
      --width=60 \
      --lines=1 \
      --keyboard-focus=on-demand \
      --no-exit-on-keyboard-focus-loss 2>/dev/null)
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
      echo "$result"
      exit 0
    else
      exit 1
    fi
  '';
}
