# Reset PowerShell Script (reset.ps1)

# Get all the files in the current directory
$files = Get-ChildItem -Path .\ -File | Where-Object { $_.Name -ne 'root.ps1' -and $_.Name -ne 'reset.ps1' -and $_.Name -ne 'reset.ps1' }

# Get all the directories in the current directory
$directories = Get-ChildItem -Path .\ -Directory | Where-Object { $_.Name -ne 'steps' }

# Display the files and directories to be deleted
Write-Output "The following files will be deleted:"
$files | ForEach-Object { Write-Output $_.FullName }
Write-Output "The following directories will be deleted:"
$directories | ForEach-Object { Write-Output $_.FullName }

# Prompt the user for confirmation
$confirmation = Read-Host -Prompt 'Are you sure you want to proceed? (yes/no)'

if ($confirmation -eq 'yes') {
    # Delete the files
    $files | ForEach-Object { Remove-Item -Path $_.FullName }

    # Delete the directories
    $directories | ForEach-Object { Remove-Item -Path $_.FullName -Recurse }

    Write-Output "Reset completed."
} else {
    Write-Output "Reset cancelled."
}
