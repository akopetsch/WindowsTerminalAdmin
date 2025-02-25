# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Alexander Kopetsch

function Update-RegistryKey {
    param (
        [Parameter(Mandatory=$true)][string]$Path,
        [string]$DefaultValue = "",
        [string]$Type = "String"
    )
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
    Set-ItemProperty `
        -Path $Path -Name "(Default)" -Value $DefaultValue -Type $Type | Out-Null
}

function Update-RegistryKeyStringValue {
    param (
        [Parameter(Mandatory=$true)][string]$Path,
        [Parameter(Mandatory=$true)][string]$Name,
        [string]$Value = ""
    )
    Set-ItemProperty `
            -Path $Path -Name $Name -Value $Value -Type "String" | Out-Null
}

function Remove-RegistryKey {
    param (
        [Parameter(Mandatory=$true)][string]$Path
    )
    Remove-Item -Path $Path -Force -Recurse
}

function Register-ContextMenuHandler {
    param (
        [Parameter(Mandatory=$true)][string]$BasePath,
        [Parameter(Mandatory=$true)][string]$HandlerName,
        [Parameter(Mandatory=$true)][string]$Text,
        [Parameter(Mandatory=$true)][string]$Command,
        [string]$CommandType = "String",
        [switch]$Extended = $false,
        [switch]$HasLuaShield = $false
    )
    <#
    Some information on context menu handlers online:
    * [github.com - 'microsoftarchive/msdn-code-gallery-microsoft' - 'CppShellExtContextMenuHandler'](https://github.com/microsoftarchive/msdn-code-gallery-microsoft/tree/master/OneCodeTeam/C%2B%2B%20Windows%20Shell%20context%20menu%20handler%20(CppShellExtContextMenuHandler)/%5BC%2B%2B%5D-C%2B%2B%20Windows%20Shell%20context%20menu%20handler%20(CppShellExtContextMenuHandler)/C%2B%2B/CppShellExtContextMenuHandler)
    * [learn.microsoft.com - 'Creating Shortcut Menu Handlers'](https://learn.microsoft.com/en-us/windows/win32/shell/context-menu-handlers)
    * [oreilly.com - 'Chapter 4. Context Menu Handlers'](https://www.oreilly.com/library/view/vb-shell-programming/1565926706/ch04.html)
    #>
    $path = "$BasePath\$HandlerName"
    $commandPath = "$path\command"
    Update-RegistryKey -Path $path -DefaultValue $Text
    if ($Extended) {
        Update-RegistryKeyStringValue -Path $path -Name "Extended" -Value ""
    }
    if ($HasLuaShield) {
        Update-RegistryKeyStringValue -Path $path -Name "HasLuaShield" -Value ""
    }
    Update-RegistryKey -Path $commandPath -DefaultValue $Command -Type $CommandType
}

function Unregister-ContextMenuHandler {
    param (
        [Parameter(Mandatory=$true)][string]$BasePath,
        [Parameter(Mandatory=$true)][string]$HandlerName
    )
    Remove-RegistryKey -Path "$BasePath\$HandlerName"
}
