#!/usr/bin/env bash

nix-shell https://github.com/sgillespie/nixos-yubikey-luks/archive/master.tar.gz --run "$(
  cat <<'EOF'
  SLOT=2
  SALT_LENGTH=16
  SALT="$(dd if=/dev/random bs=1 count=$SALT_LENGTH 2>/dev/null | rbtohex)"
  CHALLENGE="$(echo -n $SALT | openssl dgst -binary -sha512 | rbtohex)"
  echo "Touch your YubiKey when it blinks..."
  RESPONSE=$(ykchalresp -2 -x $CHALLENGE 2>/dev/null)
  KEY_LENGTH=512
  ITERATIONS=1000000
  LUKS_KEY="$(echo | pbkdf2-sha512 $(($KEY_LENGTH / 8)) $ITERATIONS $RESPONSE | rbtohex)"
  echo ""
  echo ""
  echo -ne "$SALT\n$ITERATIONS" > generated.salt
  echo "Salt and iterations are saved to generated.salt file"
  echo -n "$LUKS_KEY" | hextorb > generated.key
  echo "Key is saved in a binary format to generated.key file"
  echo ""
  echo ""
  echo "Copy generated.salt file to /boot/crypt-storage/<name>"
  echo "Add generated.key to your LUKS device with 'cryptsetup luksAddKey <device> <key>'"
  echo "Remove generated.key after you have added it to your LUKS device 'rm generated.key'"
  echo ""
  echo ""
  echo "!!! WARNING !!!"
  echo "Each LUKS device should have its own salt and binary key"
  echo "Do not forget to point to a salt file inside your 'boot.initrd.luks.devices.<name>.yubikey.storage.path'"

EOF
)"
