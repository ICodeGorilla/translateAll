# Step 0: Install Prerequisites (step0_no.ps1)

# Check if the step has been applied
if ((Get-Content -Path .\progress.log -ErrorAction SilentlyContinue) -like "*step0_no applied*") {
    Write-Output "Step 0 has already been applied."
} else {
    # Check if Node.js and npm are installed
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        Write-Output "Node.js is not installed. Please install Node.js and npm before proceeding."
        Exit
    }

    # Install Angular CLI
    npm install -g @angular/cli

    # Check if Angular CLI is now installed
    if (-not (Get-Command ng -ErrorAction SilentlyContinue)) {
        # Get the npm global bin folder path
        $npmGlobalBin = npm bin -g
        
        # Get the current PATH environment variable
        $currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
        
        # Check if npm global bin is already in PATH
        if ($currentPath -notlike "*$npmGlobalBin*") {
            # Add npm global bin directory to PATH environment variable
            [System.Environment]::SetEnvironmentVariable("Path", "$currentPath;$npmGlobalBin", [System.EnvironmentVariableTarget]::Machine)
            Write-Output "npm global bin folder has been added to the system PATH. Please restart your PowerShell session."
        } else {
            Write-Output "Angular CLI could not be installed. Please check your npm installation and try again."
        }
        Exit
    }

    # Mark the step as applied
    Add-Content -Path .\progress.log -Value "step0_no applied"
}