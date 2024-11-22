
# 🚀 **Android Dev Tools**

![Android Dev Tools Logo](https://via.placeholder.com/800x200.png?text=Android+Dev+Tools+Logo)  
*(Replace this placeholder with your actual project logo)*

**Android Dev Tools** is a cross-platform desktop application designed to manage Android SDK tools efficiently. Built with **Flutter Web** and **Tauri**, it features a sleek, modern interface and lightweight backend functionality.

---

## 🔥 **Features**
- ✅ Download and install Android SDK tools.
- ✅ Automatically configure environment variables (`ANDROID_HOME`, `PATH`).
- ✅ Cross-platform compatibility: **Windows**, **Linux**, and **macOS**.
- ✅ Modern, responsive UI with **hot-reload** during development.
- ✅ Lightweight and secure with Tauri.

---

## 📋 **Requirements**

### System Requirements
- 📱 **Flutter** (with Web support enabled)
- ⚙️ **Rust** and **Tauri CLI**
- 🌐 Node.js and npm

### Dependencies
- 🦀 **Tauri Backend**: Rust crates (`reqwest`, `dirs`)
- 🌈 **Flutter Frontend**: Web build for Tauri integration

---

## 📂 **Setup Instructions**

### Step 1: Install Dependencies
1. Install **Flutter** and enable Web support:
   ```bash
   flutter channel stable
   flutter upgrade
   flutter config --enable-web
   ```

2. Install **Rust** and **Tauri CLI**:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   cargo install tauri-cli
   ```

3. Install **Node.js**:
   ```bash
   # Use your package manager or download from https://nodejs.org
   ```

---

### Step 2: Clone the Project
Clone this repository and navigate to the project directory:
```bash
git clone https://github.com/amajust/utilities.git
cd utilities/android-dev-tools
```

---

### Step 3: Configure the Project

#### Flutter Project
1. Navigate to the `flutter_ui` directory:
   ```bash
   cd flutter_ui
   ```
2. Build the Flutter Web output:
   ```bash
   flutter build web
   ```

#### Tauri Project
1. Navigate to the `src-tauri` directory:
   ```bash
   cd src-tauri
   ```
2. Ensure the `tauri.conf.json` is configured:
   ```json
   {
     "build": {
       "beforeBuildCommand": "flutter build web",
       "beforeDevCommand": "flutter build web",
       "frontendDist": "../flutter_ui/build/web"
     }
   }
   ```

---

### Step 4: Run the Application

#### Development Mode
Run the app in development mode:
```bash
npm run tauri dev
```

#### Production Build
Build the app for production:
```bash
npm run tauri build
```

---

## 🌳 **Project Structure**
```
/flutter_ui              # Flutter project for UI
    /build               # Generated Web files for Tauri
/src-tauri               # Tauri backend (Rust)
    /src                 # Rust source code
    tauri.conf.json      # Tauri configuration
```

---

## ⚖️ **License**
This project is licensed under the [MIT License](LICENSE).

