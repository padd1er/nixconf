# final: prev: {
#   fuzzel-askpass = prev.writeShellScriptBin "fuzzel-askpass" ''
#     prompt="''${1:-🔒Password:}"
#     password=$(${final.fuzzel}/bin/fuzzel --dmenu --password --cache /dev/null \
#       --prompt-only="$prompt" --width=60 --lines=0 \
#       --keyboard-focus=on-demand --no-exit-on-keyboard-focus-loss)
#     if [ $? -eq 0 ]; then
#       echo "$password"
#       exit 0
#     else
#       exit 1
#     fi
#   '';
# }

final: prev: {
  fuzzel-askpass = prev.writeShellScriptBin "fuzzel-askpass" ''
    #!/usr/bin/env bash

    # Handle the prompt - SSH agent passes it as an argument or via DISPLAY
    prompt="$*"

    # If no prompt provided, use default
    if [ -z "$prompt" ]; then
      prompt="Password:"
    fi

    # Remove any trailing colons and add our own
    prompt="''${prompt%:}"

    # Call fuzzel and capture the result
    result=$(${final.fuzzel}/bin/fuzzel --dmenu --password \
      --cache /dev/null \
      --prompt="$prompt: " \
      --width=60 \
      --lines=0 \
      --keyboard-focus=on-demand \
      --no-exit-on-keyboard-focus-loss 2>/dev/null)

    exit_code=$?

    # Output the result to stdout (SSH agent reads from here)
    if [ $exit_code -eq 0 ]; then
      echo "$result"
      exit 0
    else
      exit 1
    fi
  '';
}
