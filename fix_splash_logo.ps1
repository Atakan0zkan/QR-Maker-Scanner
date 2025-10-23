# Fix Splash Logo Size
# Creates a smaller logo with padding for proper display

$sourceLogo = "assets\logos\app_icon.png"
$targetSplash = "assets\logos\splash_logo_small.png"
$backupSplash = "assets\logos\splash_logo_original.png"

Write-Host "🔧 Fixing Splash Logo Size..." -ForegroundColor Cyan
Write-Host ""

# Check if ImageMagick is available
$magickExists = Get-Command magick -ErrorAction SilentlyContinue

if ($magickExists) {
    Write-Host "✅ ImageMagick found - creating optimized splash logo" -ForegroundColor Green
    
    # Backup original
    if (Test-Path "assets\logos\splash_logo.png") {
        Copy-Item "assets\logos\splash_logo.png" $backupSplash -Force
        Write-Host "📦 Original logo backed up to: $backupSplash" -ForegroundColor Yellow
    }
    
    # Create 512x512 canvas with 192x192 logo in center (lots of padding)
    magick $sourceLogo -resize 192x192 -background transparent -gravity center -extent 512x512 $targetSplash
    
    # Replace splash_logo.png
    Copy-Item $targetSplash "assets\logos\splash_logo.png" -Force
    Remove-Item $targetSplash -Force
    
    Write-Host "✅ Splash logo created successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📝 Next steps:" -ForegroundColor Cyan
    Write-Host "  1. Run: dart run flutter_native_splash:create"
    Write-Host "  2. Run: flutter run"
    Write-Host ""
} else {
    Write-Host "⚠️  ImageMagick not found. Using manual solution..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "📝 Manual fix (choose one):" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Option 1: Use a smaller logo temporarily"
    Write-Host "  Copy-Item 'assets\logos\app_icon.png' 'assets\logos\splash_logo.png' -Force"
    Write-Host ""
    Write-Host "Option 2: Edit logo manually"
    Write-Host "  1. Open splash_logo.png in any image editor"
    Write-Host "  2. Resize to 192x192 pixels"
    Write-Host "  3. Place on 512x512 transparent canvas (centered)"
    Write-Host "  4. Save as assets\logos\splash_logo.png"
    Write-Host ""
    Write-Host "Then run:"
    Write-Host "  dart run flutter_native_splash:create"
    Write-Host "  flutter run"
    Write-Host ""
}
