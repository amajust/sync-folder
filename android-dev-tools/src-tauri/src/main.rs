pub(crate) use tauri::command;
use std::fs;
use std::path::PathBuf;
use reqwest;

#[command]
async fn download_sdk() -> Result<String, String> {
    let url = if cfg!(target_os = "windows") {
        "https://dl.google.com/android/repository/commandlinetools-win-8512546_latest.zip"
    } else {
        "https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip"
    };

    let home = dirs::home_dir().ok_or("Failed to find home directory")?;
    let sdk_dir = home.join("Android").join("Sdk");
    let zip_file = home.join("commandlinetools.zip");

    // Download SDK tools
    let response = reqwest::get(url).await.map_err(|e| e.to_string())?;
    let mut file = fs::File::create(&zip_file).map_err(|e| e.to_string())?;
    let content = response.bytes().await.map_err(|e| e.to_string())?;
    std::io::copy(&mut content.as_ref(), &mut file).map_err(|e| e.to_string())?;

    // Extract the file (Linux and Windows logic can be added here)
    Ok(format!("SDK downloaded to {:?}", sdk_dir))
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![download_sdk])
        .run(tauri::generate_context!())
        .expect("error while running Tauri application");
}

