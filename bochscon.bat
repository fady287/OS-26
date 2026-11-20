@ECHO off
set "local_directory=%cd%"
if exist "%local_directory%\..\..\bin\bochs.exe" (
    set "PATH=%local_directory%\..\..\bin;%local_directory%\..\..\opt\cross\bin;"
) else (
    set "PATH=C:\FOS\bin;C:\FOS\opt\cross\bin;"
)

start cmd.exe /k ^"bochs.exe -q"