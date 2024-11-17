#!/bin/bash

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/sync-app"
LOG_FILE="$CONFIG_DIR/sync-app.log"
CONFIG_FILE="$CONFIG_DIR/sync-list.conf"
STATUS_FILE="$CONFIG_DIR/sync-status.conf"
VERBOSE=false

# Ensure the configuration directory and files exist
mkdir -p "$CONFIG_DIR"
touch "$CONFIG_FILE" "$STATUS_FILE"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

info() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

generate_task_name() {
    echo "sync-task-$(date '+%Y%m%d%H%M%S')"
}

add_sync() {
    local source="$1"
    local destination="$2"
    local task_name

    if [[ ! -d "$source" ]]; then
        log "Error: Source directory $source does not exist."
        exit 1
    fi

    if [[ ! -d "$destination" ]]; then
        log "Error: Destination directory $destination does not exist."
        exit 1
    fi

    task_name=$(generate_task_name)
    echo "$task_name: $source -> $destination" >> "$CONFIG_FILE"
    info "Added sync task: $task_name ($source -> $destination)"
}

check_status() {
    local task_name="$1"
    grep -q "^$task_name: running" "$STATUS_FILE" 2>/dev/null
}

update_status() {
    local task_name="$1"
    local status="$2"
    local pid="$3"

    sed -i "\|^$task_name:|d" "$STATUS_FILE" 2>/dev/null
    if [[ -n "$pid" ]]; then
        echo "$task_name: $status (PID: $pid)" >> "$STATUS_FILE"
    else
        echo "$task_name: $status" >> "$STATUS_FILE"
    fi
}

stop_task() {
    local task_name="$1"
    local pid

    # Extract the correct PID of the inotifywait process
    pid=$(grep "^$task_name:" "$STATUS_FILE" | grep -o 'PID: [0-9]*' | awk '{print $2}')
    if [[ -n "$pid" ]]; then
        info "Stopping sync task: $task_name (PID: $pid)"
        kill "$pid"
        update_status "$task_name" "stopped"
        info "Sync task $task_name has been stopped (PID: $pid)."
    else
        info "No running inotifywait process found for task: $task_name."
    fi
}

remove_sync() {
    local task_name="$1"

    if grep -q "^$task_name:" "$CONFIG_FILE" 2>/dev/null; then
        stop_task "$task_name"

        if pgrep -f "inotifywait.*$task_name" >/dev/null; then
            info "Failed to stop running process for task: $task_name. Task entry will not be removed."
        else
            sed -i "\|^$task_name:|d" "$CONFIG_FILE" 2>/dev/null
            sed -i "\|^$task_name:|d" "$STATUS_FILE" 2>/dev/null
            info "Removed sync task: $task_name"
        fi
    else
        info "Sync task not found: $task_name"
    fi
}

start_task() {
    local task_name="$1"
    local source="$2"
    local destination="$3"

    if check_status "$task_name"; then
        info "Task $task_name is already running."
        return
    fi

    info "Starting sync task: $task_name ($source -> $destination)"
    
    # Start inotifywait in the background and capture its PID
    (inotifywait -m -r -e modify,create,delete,move "$source" |
    while read -r path action file; do
        if [[ "$VERBOSE" == true ]]; then
            log "Detected $action on $file in $source. Syncing to $destination..."
        fi
        rsync -av "$source" "$destination" >> "$LOG_FILE" 2>&1
    done) &

    # Capture the actual inotifywait PID using pgrep
    sleep 0.5  # Allow time for inotifywait to start
    pid=$(pgrep -f "inotifywait -m -r -e modify,create,delete,move $source")

    if [[ -n "$pid" ]]; then
        update_status "$task_name" "running" "$pid"
        info "Sync task $task_name started (PID: $pid)."
    else
        info "Failed to start sync task $task_name."
    fi
}

start_sync() {
    local mode="$1"

    if [[ "$mode" == "all" ]]; then
        while read -r line; do
            task_name=$(echo "$line" | cut -d ':' -f 1)
            source=$(echo "$line" | cut -d ' ' -f 2)
            destination=$(echo "$line" | cut -d ' ' -f 4)
            start_task "$task_name" "$source" "$destination"
        done < "$CONFIG_FILE"
    else
        task_name="$mode"
        if grep -q "^$task_name:" "$CONFIG_FILE" 2>/dev/null; then
            source=$(grep "^$task_name:" "$CONFIG_FILE" | cut -d ' ' -f 2)
            destination=$(grep "^$task_name:" "$CONFIG_FILE" | cut -d ' ' -f 4)
            start_task "$task_name" "$source" "$destination"
        else
            info "Task $task_name not found."
        fi
    fi
}

list_syncs() {
    if [[ ! -s "$CONFIG_FILE" ]]; then
        echo "No sync tasks configured."
    else
        echo "Configured Sync Tasks:"
        cat "$CONFIG_FILE"
    fi
}

status_sync() {
    if [[ ! -s "$STATUS_FILE" ]]; then
        echo "No sync tasks configured or running."
    else
        echo "Current Sync Task Status:"
        cat "$STATUS_FILE"
    fi
}

case "$1" in
    add)
        add_sync "$2" "$3"
        ;;
    list)
        list_syncs
        ;;
    remove)
        remove_sync "$2"
        ;;
    start)
        if [[ "$2" == "--verbose" ]]; then
            VERBOSE=true
            start_sync "$3"
        else
            start_sync "$2"
        fi
        ;;
    stop)
        stop_task "$2"
        ;;
    status)
        status_sync
        ;;
    *)
        log "Usage: $0 {add <source> <destination> | list | remove <task_name> | start [--verbose] <all | task_name> | stop <task_name> | status}"
        exit 1
        ;;
esac

