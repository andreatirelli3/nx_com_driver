# Move the file dll serialport.dll which is in the folder dll/x64 in the folder C:\Windows\System32
Move-Item -Path "\dll\x64\serialport.dll" -Destination "C:\Windows\System32\serialport.dll"

# Link DLL with a environment variable - current user
[Environment]::SetEnvironmentVariable("LIBSERIALPORT_PATH", "C:\Windows\System32", "User")

# Link DLL with a environment variable - system wide
[Environment]::SetEnvironmentVariable("LIBSERIALPORT_PATH", "C:\Windows\System32", "Machine")