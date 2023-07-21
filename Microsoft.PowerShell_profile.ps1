function prompt {
    $gitStatus = & git status -s -b 2>$null
    #$user = "$env:USERNAME"
    $dir = (Get-Location).Path | Split-Path -Leaf
    
    if ($gitStatus) {
        $branch = ($gitStatus -split "`n" | Select-String -Pattern "##")[0] -replace "## "
        $gitInfo = " [$branch]"
    } else {
        $gitInfo = ""
    }
    
    [char]27 + "[33m" + $dir + [char]27 + "[32m" +  $gitinfo + [char]27 + "[0m" + " > "
}