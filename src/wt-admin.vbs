' SPDX-License-Identifier: MIT
' Copyright (c) 2025 Alexander Kopetsch

' SUMMARY: 
' Starts the Windows Terminal as an administrator in the directory that is 
' passed as an argument to this script without opening any windows other than 
' the UAC prompt and terminal itself. 
' 
' USAGE:
' The following command starts the Windows Terminal as an administrator in the 
' directory "C:\Program Files":
'   wscript.exe "wt-admin.vbs" "C:\Program Files"
' 
' DETAILS:
' This script is to be executed by Windows Script Host (wscript.exe). Executing 
' a VBS script with wscript.exe does not open a console window by itself. 
' This script uses Shell.ShellExecute to start the Windows Terminal (wt.exe) as 
' an administrator ('"runas"') in a normal window ('1'). See the documentation 
' of Shell.ShellExecute:
'   https://learn.microsoft.com/en-us/windows/win32/shell/shell-shellexecute
' The command line argument '-d "<directory>"' is passed to wt.exe to open the 
' terminal in the specified directory. See the documentation of wt.exe command 
' line arguments:
'   https://learn.microsoft.com/en-us/windows/terminal/command-line-arguments
Set shell = CreateObject("Shell.Application")
shell.ShellExecute "wt.exe", "-d """ & WScript.Arguments(0) & """", "", "runas", 1
