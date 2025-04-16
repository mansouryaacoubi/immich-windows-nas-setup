# If Execution Policies are restricting the execution of scripts, execute this:
# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# Set working directory
$InstallDir = "$HOME\immich-app"
$EnvPath = "$InstallDir\.env"
$ComposePath = "$InstallDir\docker-compose.yml"
$UploadLocation = "/mnt/z/ImmichData/upload"

# Prompt for DB password
$DBPassword = Read-Host "Enter DB password (A-Za-z0-9 only)"

# Create directory
New-Item -Path $InstallDir -ItemType Directory -Force | Out-Null
Set-Location $InstallDir

# Download files
Invoke-WebRequest -Uri "https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml" -OutFile $ComposePath
Invoke-WebRequest -Uri "https://github.com/immich-app/immich/releases/latest/download/example.env" -OutFile $EnvPath

# Update .env
(Get-Content $EnvPath) |
    ForEach-Object {
        $_ -replace '^UPLOAD_LOCATION=.*', "UPLOAD_LOCATION=$UploadLocation" `
           -replace '^DB_PASSWORD=.*', "DB_PASSWORD=$DBPassword" `
           -replace '^TZ=.*', 'TZ=Europe/Berlin'
    } | Set-Content $EnvPath

Write-Host "✅ Immich has been configured in $InstallDir"

# Option to start container
$start = Read-Host "Start Immich now? (y/n)"
if ($start -match '^(y|Y)') {
    docker compose -f $ComposePath up -d
    Write-Host "🚀 Immich is starting..."
}
