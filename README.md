# WindowsTerminalAdmin

Adds ``Open in Terminal as administrator`` to the extended (shift-right-click) 
context menu of a directory (background) in Windows Explorer. 

![screenshot.png](img/screenshot.png)

## Background

As the time of writing, Windows lacks a context menu entry to open Windows 
Terminal as an administrator in a directory. Two issues ([#11024], [#9903]) 
of the GitHub repository [microsoft/terminal] are covering that. 

[microsoft/terminal]: https://github.com/microsoft/terminal
[#11024]: https://github.com/microsoft/terminal/issues/11024
[#9903]: https://github.com/microsoft/terminal/issues/9903

## Installation

Obtain a local copy of this repository either by cloning or by downloading it as a 
[ZIP file](https://github.com/akopetsch/WindowsTerminalAdmin/archive/refs/heads/main.zip). 

Run [src/install.ps1] as administrator: 

```console
PS > cd .\src\
PS > .\install.ps1
```

[src/install.ps1]: src/install.ps1

## Usage

1. Shift-right-click on a directory or on a directory background in Windows Explorer. 
2. Click ``Open in Terminal as administrator``. 

## Uninstallation

Run [src/uninstall.ps1] as administrator: 

```console
PS > cd .\src\
PS > .\uninstall.ps1
```

[src/uninstall.ps1]: src/uninstall.ps1
