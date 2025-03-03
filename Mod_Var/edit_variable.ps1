# Define the root directory path where the search will begin
$rootPath = "root path"

# Define the name of the variable we're looking to update in the XML files
$variableName = "varname"

# Function to update the value of a specific variable (e.g., fInitialDriveForce) in handling.meta files
function Update-DriveForce {
    param (
        [string]$filePath,  # Path to the XML file (handling.meta) to be updated
        [string]$varName    # Name of the variable we want to modify
    )

    # Display the file being updated
    Write-Host "Updating file: $filePath"

    try {
        # Load the handling.meta file as XML
        [xml]$xmlDoc = Get-Content -Path $filePath

        # Find all XML nodes within the file that have a "value" attribute
        $nodes = $xmlDoc.SelectNodes("//CHandlingDataMgr/HandlingData/Item/*[@value]")

        # Initialize a flag to check if the variable is found
        $foundVariable = $false

        # Loop through all nodes to find the specific variable
        foreach ($node in $nodes) {
            # Check if the current node's name matches the variable name
            if ($node.Name -eq $varName) {
                # Retrieve the current value of the variable as a double
                $currentValue = [double]$node.value

                # Decrease the variable's value by 0.05
                $newValue = $currentValue - 0.05

                # Update the XML node's value with the new value formatted to five decimal places
                $node.value = $newValue.ToString("0.00000")

                # Display the updated value in the console
                Write-Host "${varName}: $currentValue -> $newValue"

                # Set the flag to true since the variable was found and updated
                $foundVariable = $true
            }
        }

        # Save the updated XML file if the variable was found
        if ($foundVariable) {
            $xmlDoc.Save($filePath)
        } else {
            # Print a message if the variable was not found in the current file
            Write-Host "Variable ${varName} not found in file: $filePath"
        }
    } catch {
        # Catch and display errors that occur while processing the file
        Write-Host "Error processing file: $filePath - $($_.Exception.Message)"
    }
}

# Function to recursively traverse directories to locate handling.meta files
function Traverse-Directories {
    param (
        [string]$folderPath,  # Root directory to start searching
        [string]$varName      # Name of the variable to be updated
    )

    # Display the directory currently being traversed
    Write-Host "Traversing directory: $folderPath"

    # Find all handling.meta files in the directory and its subdirectories
    $handlingFiles = Get-ChildItem -Path $folderPath -Recurse -Filter "handling.meta"

    # Process each handling.meta file found
    foreach ($handlingFile in $handlingFiles) {
        # Call the Update-DriveForce function for each file
        Update-DriveForce -filePath $handlingFile.FullName -varName $varName
    }
}

# Start the directory traversal process from the root path provided
Traverse-Directories -folderPath $rootPath -varName $variableName
