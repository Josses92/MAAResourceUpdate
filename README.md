# MAAResourceUpdate

This repository contains a Windows batch script that automatically downloads, extracts, and updates the MAA main folder on your local drive. The script also remembers your chosen destination folder by saving it in your local AppData.

---

## English

### Introduction
This script is designed to update your local MAA folder by:
- Downloading a ZIP file from a remote GitHub repository ([https://github.com/MaaAssistantArknights/MaaResource](https://github.com/MaaAssistantArknights/MaaResource)).
- Extracting the ZIP file using .NET’s extraction functionality.
- Copying the updated files to a user-selected destination folder.
- Launching the `MAA.exe` application.

The destination folder is stored in `%LOCALAPPDATA%\MaaAssistant\destination.txt` so that you are not prompted every time—unless the folder no longer exists.

### Prerequisites
- **Operating System:** Windows (with PowerShell available)
- **.NET Framework:** Version 4.5 or later
- **Optional:** [Curl](https://curl.se/) (if installed, it is used to speed up downloads)

### Usage
1. **Download the .bat File:**  
   Download `MAA Update.bat` from this repository and save it anywhere you prefer on your local machine. This file will serve as your starter script whenever you wish to update or launch MAA.

2. **Run the Script:**  
   Double-click `MAA Update.bat` to run the script.
   - If a valid destination folder is not found, you will be prompted with a dialog:
     > "Please select the MAA main folder on your local drive:"
   - Select the folder where your MAA files are located.

3. **Script Process:**  
   The script will:
   - Download the latest repository ZIP file.
   - Extract the ZIP file.
   - Update the local folder with the new files.
   - Automatically launch `MAA.exe`.

4. **Persistence:**  
   Once you select the destination folder, the script remembers it (stored in `%LOCALAPPDATA%\MaaAssistant\destination.txt`), so you only need to set it once unless the folder is moved or deleted.

5. **Re-run as Needed:**  
   Use the `MAA Update.bat` file as your launch script whenever you want to update and run MAA.

### Contributing
Contributions, bug reports, and suggestions are welcome! Please feel free to open issues or pull requests.

---

## 中文

### 简介
本脚本用于自动更新您本地的 MAA 文件夹，其主要功能包括：
- 从远程 GitHub 仓库 ([https://github.com/MaaAssistantArknights/MaaResource](https://github.com/MaaAssistantArknights/MaaResource)) 下载 ZIP 文件。
- 使用 .NET 的解压功能解压该 ZIP 文件。
- 将更新后的文件复制到用户选择的目标文件夹中。
- 启动 `MAA.exe` 程序。

目标文件夹信息存储在 `%LOCALAPPDATA%\MaaAssistant\destination.txt` 中，因此除非该文件夹不存在，否则您无需每次都选择目标文件夹。

### 前提条件
- **操作系统：** Windows（需要安装 PowerShell）
- **.NET Framework：** 4.5 或更高版本
- **可选：** [Curl](https://curl.se/)（如果安装了，则用于加速下载）

### 使用方法
1. **下载 .bat 文件：**  
   从本仓库下载 `MAA Update.bat` 文件，并将其保存到您喜欢的位置。该文件将作为启动脚本，方便您在需要更新或启动 MAA 时使用。

2. **运行脚本：**  
   双击运行 `MAA Update.bat` 脚本。
   - 如果找不到有效的目标文件夹，系统会弹出对话框，提示：
     > “请选择您本地的 MAA 主文件夹：”
   - 选择存放 MAA 文件的文件夹。

3. **脚本流程：**  
   脚本将执行以下操作：
   - 下载最新的仓库 ZIP 文件。
   - 解压 ZIP 文件。
   - 更新本地文件夹中的文件。
   - 自动启动 `MAA.exe` 程序。

4. **记忆功能：**  
   一旦您选择了目标文件夹，脚本会将其记录在 `%LOCALAPPDATA%\MaaAssistant\destination.txt` 中，因此除非该文件夹被移动或删除，否则只需设置一次。

5. **按需启动：**  
   每当您需要更新并启动 MAA 时，只需运行该 `MAA Update.bat` 文件即可。

### 贡献
欢迎大家提交问题、建议或贡献代码！请随时提交 issue 或 pull request。

---

Enjoy using the MAAResource Update Script!
