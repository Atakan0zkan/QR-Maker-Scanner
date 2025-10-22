# Create a smaller splash logo with padding
$sourceLogo = "assets\logos\app_icon.png"
$targetLogo = "assets\logos\splash_logo_backup.png"

# Backup original
Copy-Item "assets\logos\splash_logo.png" $targetLogo -Force

# Use app_icon as splash (temporary)
# You should replace this with a properly sized logo later
Write-Host "Creating temporary splash logo from app icon..."
Write-Host "For production, please create a 256x256 logo with padding on 512x512 canvas"
