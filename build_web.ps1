# Flutter Web Build Script
# این اسکریپت برای build گرفتن از پروژه Flutter Web استفاده می‌شود

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Flutter Web Build Script" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "Step 1: Cleaning Flutter project..." -ForegroundColor Yellow
flutter clean

Write-Host "`nStep 2: Removing old web build folder..." -ForegroundColor Yellow
if (Test-Path "build\web") {
    Remove-Item -Recurse -Force "build\web"
    Write-Host "Old build folder removed!" -ForegroundColor Green
} else {
    Write-Host "No old build folder found." -ForegroundColor Gray
}

Write-Host "`nStep 3: Getting dependencies..." -ForegroundColor Yellow
flutter pub get

Write-Host "`nStep 4: Building web release..." -ForegroundColor Green
flutter build web --release

Write-Host "`nStep 5: Adding build version to prevent cache..." -ForegroundColor Yellow
$BUILD_VERSION = "$(Get-Date -Format 'yyyyMMdd-HHmmss')"
$COMMIT_SHA = if (Get-Command git -ErrorAction SilentlyContinue) { 
    git rev-parse --short HEAD 2>$null 
} else { 
    "local" 
}

# Add version meta tags to index.html
$indexPath = "build\web\index.html"
if (Test-Path $indexPath) {
    $content = Get-Content $indexPath -Raw
    $content = $content -replace '<title>Panel</title>', "<title>Panel</title>`n  <meta name=`"build-version`" content=`"${BUILD_VERSION}`">`n  <meta name=`"commit-sha`" content=`"${COMMIT_SHA}`">"
    Set-Content $indexPath -Value $content -NoNewline
    Write-Host "Build version added to index.html" -ForegroundColor Green
}

# Create build-info.json
$buildInfo = @{
    version = $BUILD_VERSION
    commit = $COMMIT_SHA
    build_time = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
} | ConvertTo-Json

Set-Content "build\web\build-info.json" -Value $buildInfo
Write-Host "Build info: $BUILD_VERSION (Commit: $COMMIT_SHA)" -ForegroundColor Cyan

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Build completed successfully!" -ForegroundColor Green
Write-Host "Output: build\web" -ForegroundColor Green
Write-Host "Build Version: $BUILD_VERSION" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nNote: If you see old version in browser:" -ForegroundColor Yellow
Write-Host "1. Press Ctrl+Shift+Delete to clear browser cache" -ForegroundColor Yellow
Write-Host "2. Or use Ctrl+F5 for hard refresh" -ForegroundColor Yellow
Write-Host "3. Or open in Incognito/Private mode" -ForegroundColor Yellow
Write-Host "4. Check build-info.json for version: build\web\build-info.json" -ForegroundColor Yellow

