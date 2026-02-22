cd %~dp0\DosBox
DOSBox.exe -c "mount c: %~dp0 " -c "c:" -c "cd c:\lab" -c "build.bat lab1"
