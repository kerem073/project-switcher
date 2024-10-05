# $HOME = [System.Environment]::GetFolderPath("UserProfile")
# $projectSwapperDir = "$HOME\AppData\Local\project_swapper"
# $projectSwapperFile = "$projectSwapperDir\.saved_dirs"
# TODO: when "del 1" the del deletes the last element. What happens when "del 3" with 5 items? And sometimes it leaves newlines in. it is weird. There are problems with del, without del it works fine.

$projectSwapperFile = "$HOME\.project_swapper"

# Ensure the file exist
if (-not (Test-Path -Path $projectSwapperFile)) {
    New-Item -ItemType File -Path $projectSwapperFile | Out-Null
}

$savedDirs = @(Get-Content $projectSwapperFile) # when there is one pwd, it puts one string in there and not a Object[]. so the @() makes it a array

if ($args[0] -eq "save") {
    $pwd = (Get-Location).Path
    Add-Content -Path $projectSwapperFile -Value $pwd
    Write-Host "Saved current directory."
} 
elseif ($args[0] -eq "list") {
    for($i = 0; $i -lt $savedDirs.length; $i += 1){
        $number = $i + 1
        Write-Host $number : $savedDirs[$i]
    }
}
elseif ($args[0] -match "^\d+$") {
    $dirIndex = $args[0] - 1
    if (($dirIndex -lt 0) -or ($dirIndex -gt $savedDirs.Length)){
        Write-Host "Not a valid list item."
    } else {
        $dir = $savedDirs[$dirIndex]
        if (Test-Path -Path $dir) {
            Set-Location $dir
            Clear-Host
        } else {
            Write-Host "Directory not found"
        }
    }
} 
elseif ($args[0] -eq "del") {
    if ($args[1] -match "^\d+$") {
        $indexToRemove = $args[1] - 1
        if ($indexToRemove -ge 0 -and $indexToRemove -lt $savedDirs.Length) {

            if ($indexToRemove -eq 0){
                $savedDirs = $savedDirs[1..($savedDirs.Length)]
            } else {
                $savedDirs = $savedDirs[0..($indexToRemove - 1)] + $savedDirs[($indexToRemove + 1)..($savedDirs.Length)]
            }

            Set-Content -Path $projectSwapperFile -Value $savedDirs
            Write-Host "Entry deleted."

        } else {
            Write-Host "Not valid number."
        }
    } else {
        Write-Host "Please provide a valid entry number."
    }
} 
else {
    Write-Host "Usage: pjs [<number>|del <number>|save|list]"
}
