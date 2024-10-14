# DNSify

DNSify is a simple application that allows users to switch DNS servers to access Spotify in regions where it may be restricted. The application supports both Windows and Linux platforms.

## Features
- Automatically checks a list of DNS servers for connectivity to Spotify.
- Resets DNS settings to the original configuration upon exit.
- User-friendly interface and easy to use.

## Installation

### For Windows Users

1. **Download the Script**:
   - Download the PowerShell script: [Download DNSify For Windows](https://github.com/AwlirezaZ/DNSify/blob/main/DNSify.ps1).
2. **Open PowerShell**:
   - Open the folder where you downloaded and saved the script.
   - On the top-left corner of the folder, click on **File**.
   - Hover your mouse over **Open Windows PowerShell**, then click **Open Windows PowerShell as administrator** from the drop-down menu. (You can also navigate to the directory that you saved the script via **cd** command)

3. **Unblock the Script**:
   - Right-click on the `DNSify.ps1` file and select **Properties**.
   - In the **General** tab, check the **Unblock** checkbox at the bottom (if available).
   - Click **Apply** and then **OK** to close the window.

4. **Set Execution Policy (if needed)**:
   - If you encounter a permission error, run the following command:
     ```powershell
     Set-ExecutionPolicy RemoteSigned -Scope Process
     ```

5. **Execute the Script**:
   - Run the script:
     ```powershell
     .\DNSify.ps1
     ```

### For Linux Users

1. **Download the Script**:
   - Download the Bash script: [Download DNSify For Linux](https://github.com/AwlirezaZ/DNSify/blob/main/DNSify.sh) .

2. **Open Terminal**:
   - Launch your terminal application.

3. **Make the Script Executable**:
   - Navigate to the directory where the script is located. For example:
     ```bash
     cd /path/to/script/
     ```
   - Make the script executable:
     ```bash
     chmod +x DNSify.sh
     ```

4. **Run the Script**:
   - Execute the script with elevated privileges:
     ```bash
     sudo ./DNSify.sh
     ```

## Usage

1. **Run the Application**:
   - On Windows, run the PowerShell script.
   - On Linux, run the Bash script.

2. **Check DNS Servers**:
   - The application will check the listed DNS servers for connectivity to Spotify.

3. **Close the Application**:
   - Press `CTRL + C` or close the terminal/PowerShell window to stop the application. The DNS settings will automatically revert to the original configuration.

## Troubleshooting
- Ensure that you have the necessary permissions to change DNS settings.
- If you encounter issues, check your network configuration and try different DNS servers in the list.


## Author
@lireza @hmadi A.K.A AwlirezaZ
