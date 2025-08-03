#!/usr/bin/env bash
# Uninstall script for linux-tips
# Features: confirmation + dry-run mode

INSTALL_BIN_DIR="$HOME/.local/bin"
TIPS_SHARE_DIR="$HOME/.local/share/linux-tips"
EXEC_NAME="tips" # Main executable name

DRY_RUN=false

# --- Check for --dry-run option ---
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "[DRY-RUN] No files will be deleted."
fi

echo "Preparing to uninstall linux-tips..."
echo "The following files/directories will be removed:"
echo " - $INSTALL_BIN_DIR/$EXEC_NAME (or tips.bash)"
echo " - $TIPS_SHARE_DIR"
echo

# --- Ask for confirmation ---
read -rp "Are you sure you want to uninstall linux-tips? (y/N) " answer
case "$answer" in
    [Yy]* ) echo "Proceeding with uninstallation...";;
    * ) echo "Aborted."; exit 0;;
esac

# --- Function to delete with optional dry-run ---
delete_file() {
    local target="$1"
    if [ -e "$target" ]; then
        if $DRY_RUN; then
            echo "[DRY-RUN] Would remove: $target"
        else
            echo "Removing: $target"
            rm -rf "$target"
        fi
    else
        echo "Not found: $target"
    fi
}

# --- Delete executable ---
if [ -f "$INSTALL_BIN_DIR/$EXEC_NAME" ]; then
    delete_file "$INSTALL_BIN_DIR/$EXEC_NAME"
elif [ -f "$INSTALL_BIN_DIR/tips.bash" ]; then
    delete_file "$INSTALL_BIN_DIR/tips.bash"
else
    echo "No executable found in $INSTALL_BIN_DIR"
fi

# --- Delete share directory ---
delete_file "$TIPS_SHARE_DIR"

echo
if $DRY_RUN; then
    echo "[DRY-RUN] Uninstallation simulated. No files were deleted."
else
    echo "linux-tips has been uninstalled successfully."
fi