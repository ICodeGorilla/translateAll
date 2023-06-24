# Step 0: Install Prerequisites (step0_no.ps1)

# Check if the step has been applied
if ((Get-Content -Path .\progress.log -ErrorAction SilentlyContinue) -like "*step0_no applied*") {
    Write-Output "Step 0 has already been applied."
} else {
    # Install Angular CLI
    npm install -g @angular/cli

    # Mark the step as applied
    Add-Content -Path .\progress.log -Value "step0_no applied"
}
