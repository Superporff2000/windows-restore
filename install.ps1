# Script to install useful apps after formatting windows
# This script assumes you have already signed in to your windows account
# and installed git using winget:
# winget install -d --id Git.Git

# 0. IMPORTANT - Create a restore point

$restorePointDescription = "Windows 11 in vanilla state after fresh install."
$restorePointType = "APPLICATION_INSTALL"

Write-Host "Creating a system restore point..."
Write-Host "Restore Point Description: $restorePointDescription"
Write-Host "Restore Point Type: $restorePointType"

Checkpoint-Computer -Description $restorePointDescription -RestorePointType $restorePointType

Write-Host "Restore Point has been created successfully! Lets proceed with the application install"

# 1. Install all the necessary apps using winget

$apps = @(
    'Starship.Starship',
    'WinDirStat.WinDirStat',
    'REALiX.HWiNFO',
    'CPUID.CPU-Z'.
    't-dlp.yt-dlp',
    'Microsoft.PowerToys',
    'JernejSimoncic.Wget',
    'Google.Chrome',
    'ProtonTechnologies.ProtonVPN',
    'Notepad++.Notepad++',
    'Neovim.Neovim',
    'AlexanderPershin.lsdeer',
    'SoftDeluxe.FreeDownloadManager',
    'VideoLAN.VLC',
    'Spotify.Spotify',
    'Spicetify.Spicetify'
)

foreach ($app in $apps) {
    Write-Host "Installing $app"
    Write-Host ""
    winget install -e --silent --id $app --accept-source-agreements --accept-package-agreements
}

# 2. Setup some of the apps and restore configs:

## a. Spicetify

# Run with no command once to generate config file
spicetify

# Create vanilla backup file of spotify
spicetify backup apply enable-devtools

# Clone the spicetify themes repo
git clone --depth=1 https://github.com/spicetify/spicetify-themes.git

# Copy the themes to spicetify's config directory
cp spicetify-themes\* "$( spicetify -c | Split-Path )\Themes\"  -Recurse

# Apply the Sleek theme called Cherry
spicetify config current_theme Sleek color_scheme cherry

## b. Neovim

# Clone Packer
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

# Move nvim config
cp neovim/* $ENV:LocalAppData/nvim/.

## c. Starship

$starshipConfigPath = $ENV:LocalAppData/Starship
$starshipCachePath = $ENV:LocalAppData/Temp

mkdir $starshipConfigPath
cp starship/starship.toml $starshipConfigPath

# Set environment variables for starship

[System.Environment]::SetEnvironmentVariable("starship_config", "$starshipConfigPath/starship.toml", "User")
[System.Environment]::SetEnvironmentVariable("starship_cache", "$starshipCachePath", "User")

## d. Python
## Note: I am installing python manually because Poetry does not play well with winget's python

wget -O python.exe "https://www.python.org/ftp/python/3.11.1/python-3.11.1-amd64.exe"
./python.exe

## c. Anytype

wget -O anytype.exe https://at9412003.fra1.cdn.digitaloceanspaces.com/Anytype%20Setup%200.30.0.exe
./anytype.exe
