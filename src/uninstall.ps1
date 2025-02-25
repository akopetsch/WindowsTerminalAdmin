# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Alexander Kopetsch

<#
.SYNOPSIS
Uninstalls the application directory and unregisters the context menu handlers.

.DESCRIPTION
A more detailed explanation of the script's functionality and its purpose.

.NOTES
Additional notes about the script such as author, version, or limitations.
#>

. .\AppFunctions.ps1
. .\Utils\FileFunctions.ps1
. .\Utils\RegistryFunctions.ps1

function Uninstall-AppDirectory {
    Remove-Directory -Path "$(Get-AppDirectoryPath)"
}

function Unregister-AppContextMenuHandler([string]$BasePath) {
    $name = Get-ContextMenuHandlerName
    Unregister-ContextMenuHandler -BasePath $BasePath -HandlerName $name
}

Uninstall-AppDirectory
Unregister-AppContextMenuHandler -BasePath $(Get-DirectoryShellRegKeyPath)
Unregister-AppContextMenuHandler -BasePath $(Get-DirectoryBackgroundShellRegKeyPath)
