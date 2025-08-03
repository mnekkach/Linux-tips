#!/usr/bin/env bash

VERSION="1.0.0"
TIPS_SHARE_DIR="$HOME/.local/share/linux-tips"

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
