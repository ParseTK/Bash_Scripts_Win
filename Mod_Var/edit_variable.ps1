# Variables
$file_name = "your_filename.txt"  # Name of the file to find (replace with your file name)
$variable_name = "your_variable"  # Name of the variable to edit (replace with your variable name)
$search_directory = "C:\path\to\your\vehicles"  # Full path to the directory to search in (replace with your search directory)

# Find the file
$file_path = Get-ChildItem -Path $search_directory -Filter $file_name -Recurse -File | Select-Object -First 1
# Searches recursively in the specified directory for the file with the given name and selects the first matching file

if (-not $file_path) {
    Write-Host "File not found in $search_directory!"
    exit 1
    # Checks if the file was found; if not, prints a message and exits the script with an error code
}

# Edit the file
(Get-Content $file_path.FullName) | ForEach-Object {
    if ($_ -match "$variable_name\s*=\s*(\d+(\.\d+)?)") {
        $value = [double]$matches[1]
        # Captures the value of the variable using regular expressions

        $new_value = $value - ($value * 0.15)
        # Calculates the new value by subtracting 15% of the original value

        $_ = $_ -replace "$variable_name\s*=\s*\d+(\.\d+)?", "$variable_name=$new_value"
        # Replaces the old variable assignment with the new value
    }
    $_
    # Outputs the modified or unchanged line
} | Set-Content $file_path.FullName
# Writes the updated content back to the original file

Write-Host "Variable $variable_name in $file_name has been updated."
# Prints a message indicating that the variable in the specified file has been updated

