# PowerShell 7.x

# Set the parent path
$parentPath = "E:\ConneyUSBDrives\USB20FD"

# Get a list of child folders in the parent path
$childFolders = (Get-ChildItem -Path $parentPath -Directory)

# Output the list of child folders
foreach ($folder in $childFolders){
    
    # Get all the TIF files in the directory
    $tifFiles = (Get-ChildItem -Path $folder -Recurse -Filter *.tiff)

    # Convert each TIF file to PNG format
    foreach ($tifFile in $tifFiles) {

        # Output the TIF file name
        Write-Host "Deleting $tifFile"

        # Load the TIF file using .NET Framework's System.Drawing.Bitmap class
        $image = New-Object System.Drawing.Bitmap($tifFile.FullName)

        # Save the image as PNG using the same filename, but with the .png extension
        $pngFile = [System.IO.Path]::ChangeExtension($tifFile.FullName, ".png")
        $image.Save($pngFile, [System.Drawing.Imaging.ImageFormat]::Png)

        # Dispose of the Bitmap object
        $image.Dispose()
    }
    Write-Host "Converted files in $folder"
}
