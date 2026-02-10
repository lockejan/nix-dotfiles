# This overlay fixes inetutils format-security compilation errors on aarch64-darwin
# Uses postPatch instead of a patch file to avoid conflicts with existing patches
final: prev: {
  inetutils = prev.inetutils.overrideAttrs (oldAttrs: {
    postPatch = (oldAttrs.postPatch or "") + ''
      # Fix format-security errors in lib/openat-die.c
      # Add "%s" format specifier to error() calls with translated strings
      sed -i lib/openat-die.c \
        -e 's/error (exit_failure, errnum,$/error (exit_failure, errnum, "%s",/g'
    '';
  });
}
