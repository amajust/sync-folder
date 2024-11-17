
# 🔄 Sync-App

**Sync-App** is a simple and efficient file synchronization tool developed by Ama. It performs one-way synchronization from a source directory to a target directory, leveraging `inotify` for real-time file monitoring and `rsync` for efficient file transfers. The app is currently designed specifically for Arch Linux.

## ✨ Features

- 🗂️ **One-Way Sync:** Synchronizes files from the source to the target directory.
- 🔍 **Real-Time Monitoring:** Uses `inotify` to watch for changes in the source directory.
- ⚡ **Efficient File Transfer:** Utilizes `rsync` for fast and reliable synchronization.
- 🛠️ **Arch Linux Support:** Optimized for Arch Linux environments.
- 📂 **Configuration Management:** Automatically handles configuration and status files.

## 📦 Installation

Download the latest release artifact from GitHub Actions:

[Latest Artifact](https://github.com/amajust/utilities/actions/runs/11879337373/artifacts/2198249111)

Install the package using `pacman`:

```bash
sudo pacman -U /path/to/sync-app*.tar.zst
```

## 📋 Configuration Files

- **Config Directory:** `~/.config/sync-app/`
- **Task List File:** `~/.config/sync-app/sync-list.conf`
- **Status File:** `~/.config/sync-app/sync-status.conf`
- **Log File:** `~/.config/sync-app/sync-app.log`

## 🔧 Commands

### 1. Add a Sync Task

```bash
sudo sync-app add <source_directory> <destination_directory>
```

### 2. List All Sync Tasks

```bash
sudo sync-app list
```

### 3. Start Sync Tasks

```bash
sudo sync-app start all
```

or

```bash
sudo sync-app start <task_name>
```

### 4. Check Status of Sync Tasks

```bash
sudo sync-app status
```

### 5. Stop a Sync Task

```bash
sudo sync-app stop <task_name>
```

### 6. Remove a Sync Task

```bash
sudo sync-app remove <task_name>
```

### 7. Verbose Mode

```bash
sudo sync-app start --verbose all
```

### 8. View Log File

```bash
cat ~/.config/sync-app/sync-app.log
```

## 📝 Example Workflow

```bash
# Add a new sync task
sudo sync-app add /home/ama/Projects /backup/Projects

# Start the sync task
sudo sync-app start sync-task-20241117205000

# Check the status of all tasks
sudo sync-app status

# Stop the sync task
sudo sync-app stop sync-task-20241117205000

# Remove the sync task
sudo sync-app remove sync-task-20241117205000

# List all sync tasks (should show no tasks if removed)
sudo sync-app list
```

## 🛠️ Notes

- The `inotifywait` process monitors changes in the source directory and triggers synchronization using `rsync`.
- The app captures the PID of the `inotifywait` process to ensure correct task management.
- The configuration and status files are automatically managed, so manual editing is not required.

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## 🤝 Contributing

Contributions and issues are welcome! Please open an issue or submit a pull request on GitHub.

