# -----------------------------------------------------------
# VERIFICAÇÃO DE UNICODE PELO POWERSHELL NO WINDOWS TERMINAL
# -----------------------------------------------------------

$checkmark = [char]0x2713
$firacodeloading1 = [char]0xEE03
$firacodeloading2 = [char]0xEE04
$firacodeloading3 = [char]0xEE05
$firacodeemptybar1 = [char]0xEE00
$firacodeemptybar2 = [char]0xEE01
$firacodeemptybar3 = [char]0xEE02
$loadingicon1 = [char]0xEE06
$loadingicon2 = [char]0xEE07
$loadingicon3 = [char]0xEE08
$loadingicon4 = [char]0xEE09
$loadingicon5 = [char]0xEE0A
$loadingicon6 = [char]0xEE0B

#Write-Host "Checkmark: $checkmark"

#Write-Host "Barra de loading vazia: $firacodeemptybar1 $firacodeemptybar2 $firacodeemptybar3"
#Write-Host "Barra de loading cheia: $firacodeloading1 $firacodeloading2 $firacodeloading3"

function Show-FakeLoadingAnimation {
    $animationChars = [char]0xEE06, [char]0xEE07, [char]0xEE08, [char]0xEE09, [char]0xEE0A, [char]0xEE0B # Unicode code points for filled and empty circle characters
    $animationDelay = 200            # Delay in milliseconds between animation frames
    $totalFrames = 10                # Total number of animation frames
    $progressChar = 0                # Current animation character index

    for ($frame = 0; $frame -lt $totalFrames; $frame++) {
        Write-Host ("$($animationChars[$progressChar])") -NoNewline
        $progressChar = ($progressChar + 1) % $animationChars.Length
        Start-Sleep -Milliseconds $animationDelay
        Write-Host "`r" -NoNewline
    }
}

# Call the function to start the fake loading animation
#Show-FakeLoadingAnimation

# Define the Fira Code Unicode characters for the progress bar
$leftBracket = 0xEE00
$leftfillBracket = 0xEE03   
$rightBracket = 0xEE02
$rightfillBracket = 0xEE05 
$filledBlock = 0xEE04  
$emptyBlock = 0xEE01

function Show-ProgressBar {
    param (
        [int]$current,
        [int]$total,
        [int]$width = 40
    )

    $percentage = [Math]::Floor(($current / $total) * 100)
    $filledWidth = [Math]::Floor(($current / $total) * $width)
    $emptyWidth = $width - $filledWidth

    $progressBar = "$([char]::ConvertFromUtf32($leftFillBracket))"

    for ($i = 1; $i -le $filledWidth; $i++) { # le is less than or equal to
        $progressBar += "$([char]::ConvertFromUtf32($filledBlock))"
    }

    for ($i = 1; $i -le $emptyWidth; $i++) { 
        $progressBar += "$([char]::ConvertFromUtf32($emptyBlock))"
    }

    if ($percentage -eq 100) {
        $progressBar += "$([char]::ConvertFromUtf32($rightFillBracket))"
    }
    if ($percentage -lt 100) {
        $progressBar += "$([char]::ConvertFromUtf32($rightBracket))"
    }
    $progressBar += " $percentage%"

    Write-Host $progressBar -NoNewline
}

# Example usage
$totalItems = 100
for ($i = 1; $i -le $totalItems; $i++) {
    Show-ProgressBar -current $i -total $totalItems
    Start-Sleep -Milliseconds 100
    Write-Host "`r" -NoNewline
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Green -NoNewline
