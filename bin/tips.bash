#!/usr/bin/env bash

VERSION=1.0.0
CONFIG_DIR="$HOME/.linux-tips"
TIPS_SHARE_DIR="$HOME/.local/share/linux-tips"

LAST_CHECK_FILE="$CONFIG_DIR/last_update_check"
UPDATE_INTERVAL_DAYS=15

mkdir -p "$CONFIG_DIR"

# --- Function to check updates ---
check_updates() {
    local now last_check days_diff
    now=$(date +%s)

    # If file doesn't exist, force check
    if [ ! -f "$LAST_CHECK_FILE" ]; then
        echo "last_update_check does not exist"
        echo "$now" > "$LAST_CHECK_FILE"
        last_check=0
    else
        last_check=$(cat "$LAST_CHECK_FILE")
    fi

    # Calculate difference in days
    days_diff=$(( (now - last_check) / 86400 ))

    if [ "$days_diff" -ge "$UPDATE_INTERVAL_DAYS" ]; then
        # TODO: Write the date in the last_update_check file after the update is done.
        #       Move the next line after the update was performed
        #echo "$now" > "$LAST_CHECK_FILE" # Update last check timestamp

        # Fetch remote version
        REMOTE_VERSION=$(curl -s https://raw.githubusercontent.com/mnekkach/linux-tips/main/VERSION)

        if [ -n "$REMOTE_VERSION" ] && [ "$REMOTE_VERSION" != "$VERSION" ]; then
            echo "⚠️  A new version of Linux Tips is available: $REMOTE_VERSION (current: $VERSION)"
            echo "Run: tips --update to upgrade"
            echo
            read -n 1 -s -r -p "Press any key to continue..."
            echo
        fi
    fi
}



show_help() {
    cat <<EOF
Linux Tips - Command line tips

Usage:
  tips [topic]        Show tips for the given topic
  tips --list         List all available tips
  tips --version      Show the current version
  tips --help         Show this help message
EOF
}

show_list() {
    if [ -d "$TIPS_SHARE_DIR" ]; then
        echo "-----------------------------"
        echo "Available tips:"
        echo "-----------------------------"
        ls -1 "$TIPS_SHARE_DIR" | nl | sed 's/^\s*\([0-9]\+\)\s\(.*\)$/\1| \2/'
    else
        echo "ERROR :: Tips directory not found at $TIPS_SHARE_DIR"
    fi
}

# Handle no arguments
if [ $# -eq 0 ]; then
    echo "No argument supplied. Use --help for usage."
    exit 1
fi

# Handle options
case "$1" in
    --version)
        echo "Linux Tips version $VERSION"
        exit 0
        ;;
    --help)
        show_help
        exit 0
        ;;
    --list)
        show_list
        exit 0
        ;;
esac

check_updates
# Handle tips for a specific topic
TOPIC="$1"
FILE="$TIPS_SHARE_DIR/$TOPIC-tips"

if [ -f "$FILE" ]; then
    cat "$FILE"
else
    echo "ERROR :: Tips for '$TOPIC' do not exist!"
    echo
    show_list
    exit 1
fi
