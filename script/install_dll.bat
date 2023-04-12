:: Install DLL
move "\dll\x64\serialport.dll" "c:\windows\system32\serialport.dll"

:: Link DLL with a environment variable - current user
setx LIBSERIALPORT_PATH "c:\windows\system32\serialport.dll"

:: Link DLL with a environment variable - system wide
setx /M LIBSERIALPORT_PATH "c:\windows\system32\serialport.dll"