# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Alexander Kopetsch

<#
.SYNOPSIS
Installs wt-admin.vbs in the application directory and registers the context 
menu handlers. 

.DESCRIPTION
The VBS script wt-admin.vbs is installed under %APPDATA%\WindowsTerminalAdmin. 
Two context menu handlers are registered for the extended (shift-right-click) 
context menu of a directory (background) in Windows Explorer. The entries are 
displayed as 'Open in Terminal as administrator'. The handlers' command uses 
Windows Script Host (wscript.exe) to execute the VBS script with the selected 
directory as an argument. 

.NOTES
1) Using wscript.exe this way is a workaround to not display any window before the 
UAC prompt and - eventually - the Windows Terminal window itself show up. Using 
cmd.exe instead of wscript.exe/wt-admin.vbs would display a console window before 
that. Using PowerShell would also do that if used like this: 
    powershell.exe -WindowStyle Hidden -Command "Start-Process wt.exe -Verb runAs"
2) This approach also avoids erroneous string escaping/substitution that would 
arise if you tried to have the contents of wt-admin.vbs (two lines) as a one-liner 
in the command string. The same would happen if you tried to use mshta.exe to execute 
a JavaScript one-liner intended to do the same. 
#>

. .\AppFunctions.ps1
. .\FileFunctions.ps1
. .\RegistryFunctions.ps1

function Install-AppDirectory {
    Copy-FileToDirectory `
        -SourceFilePath "$PSScriptRoot\$(Get-AppVbsScriptName)" `
        -TargetDirectoryPath "$(Get-AppDirectoryPath)"
}

function Register-AppContextMenuHandler([string]$BasePath) {
    $name = "$(Get-ContextMenuHandlerName)"
    $text = "Open in Terminal as administrator"
    $command = "wscript.exe `"%APPDATA%\$(Get-AppName)\$(Get-AppVbsScriptName)`" `"%V`""
    Register-ContextMenuHandler `
        -BasePath $basePath -HandlerName $name -Text $text `
        -Command $command -CommandType ExpandString `
        -Extended -HasLuaShield
}

Install-AppDirectory
Register-AppContextMenuHandler -BasePath $(Get-DirectoryShellRegKeyPath)
Register-AppContextMenuHandler -BasePath $(Get-DirectoryBackgroundShellRegKeyPath)
