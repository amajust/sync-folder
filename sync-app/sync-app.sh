#!/bin/bash

# Application name and version
APP_NAME="sync-app"
VERSION="1.0.0"

# Function to display help message
function show_help() {
    echo "$APP_NAME v$VERSION"
    echo "Usage: $APP_NAME [options]"
    echo
    echo "Options:"
    echo "  -s, --source      Source directory to watch"
    echo "  -d, --destination Destination directory to sync"
    echo "  -h, --help        Show this help message"
    echo "  -v, --version     Show version information"
}

# Function to check dependencies
function check_dependencies() {
    for dep in inotifywait rsync; do
        if ! command -v $dep &> /dev/null; then
            echo "Error: '$dep' is not installed. Please install it and try again."
            exit 1
        fi
    done
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--source)
            SOURCE_DIR="$2"
            shift 2
            ;;
        -d|--destination)
            DEST_DIR="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--version)
            echo "$APP_NAME version $VERSION"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Validate input
if [[ -z "$SOURCE_DIR" || -z "$DEST_DIR" ]]; then
    echo "Error: Both source and destination directories are required."
    show_help
    exit 1
fi

# Check dependencies
check_dependencies

# Start monitoring and syncing
echo "Watching $SOURCE_DIR and syncing to $DEST_DIR..."
inotifywait -m -r -e modify,create,delete,move "$SOURCE_DIR" |
while read path action file; do
    echo "Detected $action on $file. Syncing..."
    rsync -av --delete "$SOURCE_DIR" "$DEST_DIR"
done

