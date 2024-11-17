# TO DO 
Need to check if this can be auto build for others distro with new one

# Sync App

This folder contains the `sync-app` project, a real-time directory synchronization tool using `inotifywait` and `rsync`.

## Features
- Monitors changes in a source directory.
- Synchronizes changes to a destination directory.
- Automatically installs dependencies if missing.

## Usage
```bash
sync-app -s /source/dir -d /destination/dir

