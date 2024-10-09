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
   - Search for PowerShell in the Start menu and run it as an Administrator.

3. **Set Execution Policy (if needed)**:
   - If you encounter a permission error, run the following command:
     ```powershell
     Set-ExecutionPolicy RemoteSigned -Scope Process
     ```

4. **Execute the Script**:
   - Navigate to the directory where the script is located. For example:
     ```powershell
     cd C:\path\to\script\
     ```
   - Run the script:
     ```powershell
     .\dns.ps1
     ```

### For Linux Users

1. **Download the Script**:
   - Download the Bash script: .

2. **Open Terminal**:
   - Launch your terminal application.

3. **Make the Script Executable**:
   - Navigate to the directory where the script is located. For example:
     ```bash
     cd /path/to/script/
     ```
   - Make the script executable:
     ```bash
     chmod +x dns_switch.sh
     ```

4. **Run the Script**:
   - Execute the script with elevated privileges:
     ```bash
     sudo ./dns_switch.sh
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
Your Name Alireza Ahmadi
