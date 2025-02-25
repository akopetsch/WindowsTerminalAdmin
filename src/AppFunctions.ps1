# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Alexander Kopetsch

function Get-AppName {
    return "WindowsTerminalAdmin"
}

function Get-AppDirectoryPath {
    return "$env:APPDATA\$(Get-AppName)"
}

function Get-AppVbsScriptName {
    return "wt-admin.vbs"
}

function Get-ContextMenuHandlerName {
    <#
    The prefix '0.' is used to ensure that the menu entry is displayed at the top. 
    It still displays right below 'Open in Terminal' which is not configured as 
    a regular context menu entry for (background) directories.
    #>
    return "0.WindowsTerminalAdmin"
}

function Get-DirectoryShellRegKeyPath {
    return "Registry::HKEY_CLASSES_ROOT\Directory\shell\"
}

function Get-DirectoryBackgroundShellRegKeyPath {
    return "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\"
}
