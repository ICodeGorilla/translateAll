# Step 1: Prompt for Keys (step1_p.ps1)

# Check if the step has been applied
if ((Get-Content -Path .\progress.log -ErrorAction SilentlyContinue) -like "*step1_p applied*") {
    Write-Output "Step 1 has already been applied."
} else {
    # Prompt the user for keys
    $googleTranslateApiKey = Read-Host -Prompt 'Enter your Google Translate API key'

    # Save the keys to a config.json file
    $configContent = @"
{
  "googleTranslateApiKey": "$googleTranslateApiKey"
}
"@
    $configContent | Out-File -FilePath .\config.json -Encoding utf8

    # Mark the step as applied
    Add-Content -Path .\progress.log -Value "step1_p applied"
}
