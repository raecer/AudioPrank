# Add the required assembly for WPF
Add-Type -AssemblyName PresentationCore

# URL of the MP3 file (direct link)
$mp3Url = 'https://drive.google.com/uc?id=1sXpdKyTFTz7C554-ye1MCSfYG26i2WWm'  # Replace with your direct download link

# Create a temporary file path with .mp3 extension
$mp3TempFile = [System.IO.Path]::ChangeExtension([System.IO.Path]::GetTempFileName(), '.mp3')

# Download the MP3 file to the temporary location
Invoke-WebRequest -Uri $mp3Url -OutFile $mp3TempFile

# Create a new MediaPlayer object
$mediaPlayer = New-Object System.Windows.Media.MediaPlayer

# Open the MP3 file
$mediaPlayer.Open($mp3TempFile)

# Play the MP3 file
$mediaPlayer.Play()

# Keep the script running while the media plays
while ($mediaPlayer.NaturalDuration.HasTimeSpan -and $mediaPlayer.Position -lt $mediaPlayer.NaturalDuration.TimeSpan) {
    Start-Sleep -Seconds 1
}

# Optionally clean up
$mediaPlayer.Close()

# Remove the temporary MP3 file
Remove-Item $mp3TempFile -Force
