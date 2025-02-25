# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Alexander Kopetsch

function Copy-FileToDirectory {
    param (
        [Parameter(Mandatory=$true)][string]$SourceFilePath,
        [Parameter(Mandatory=$true)][string]$TargetDirectoryPath
    )
    # create target directory if it doesn't exist
    if (-not (Test-Path $TargetDirectoryPath)) {
        New-Item -Path $TargetDirectoryPath -ItemType Directory -Force | Out-Null
    }
    # copy file to target directory
    Copy-Item -Path $SourceFilePath -Destination $TargetDirectoryPath -Force
}

function Remove-Directory {
    param (
        [Parameter(Mandatory=$true)][string]$Path
    )
    Remove-Item -Path $Path -Force -Recurse
}
