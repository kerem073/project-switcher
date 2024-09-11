# $HOME = [System.Environment]::GetFolderPath("UserProfile")
# $projectSwapperDir = "$HOME\AppData\Local\project_swapper"
# $projectSwapperFile = "$projectSwapperDir\.saved_dirs"
# TODO: when "del 1" the del deletes the last element. What happens when "del 3" with 5 items? And sometimes it leaves newlines in. it is weird. There are problems with del, without del it works fine.

$projectSwapperFile = "$HOME\.project_swapper"

# Ensure the file exist
if (-not (Test-Path -Path $projectSwapperFile)) {
    New-Item -ItemType File -Path $projectSwapperFile | Out-Null
}

$savedDirs = Get-Content $projectSwapperFile

if ($args[0] -eq "save") {
    $pwd = (Get-Location).Path
    $pwd | Out-File -Append -FilePath $projectSwapperFile
    Write-Host "Saved current directory."
} elseif ($args[0] -eq "list") {
    Get-Content $projectSwapperFile
} elseif ($args[0] -match "^\d+$") {
    $dir = $savedDirs[$args[0] - 1]
    Write-Host $dir
    if (Test-Path -Path $dir) {
        Set-Location $dir
        Clear-Host
    } else {
        Write-Host "Directory not found"
    }
} elseif ($args[0] -eq "del") {
    if ($args[1] -match "^\d+$") {
        $indexToRemove = $args[1] - 1
        if ($indexToRemove -ge 0 -and $indexToRemove -lt $savedDirs.Length) {
            if ($indexToRemove -eq 0){
                $savedDirs = $savedDirs[1..($savedDirs.Length)] # TODO: The first element does get removed
                Write-Host "First entry deleted."
            } else {
                $savedDirs = $savedDirs[0..($indexToRemove - 1)] + $savedDirs[($indexToRemove + 1)..($savedDirs.Length)]
                $savedDirs | Set-Content $projectSwapperFile
                Write-Host "Entry deleted."
            }
        } else {
            Write-Host "Not valid number."
        }
    } else {
        Write-Host "Please provide a valid entry number."
    }
} else {
    Write-Host "Usage: pjs [<number>|del <number>|save|list]"
}
