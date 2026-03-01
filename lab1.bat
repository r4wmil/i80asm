cd %~dp0\DosBox
DOSBox.exe -c "mount c: %~dp0 " -c "c:" -c "cd c:\tools" -c "build.bat lab1 link"
