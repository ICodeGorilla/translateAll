# Root PowerShell Script (root.ps1)

# Get all the step files in order
$steps = Get-ChildItem -Path .\steps\ -Filter *.ps1 | Sort-Object Name

# Iterate over the steps
foreach ($step in $steps) {
    # Execute the step
    & ".\steps\$($step.Name)"
}