#This script is used in the Using Profiles demonstration and called by the Using Profiles.ps1 file.
cd c:\
import-module activedirectory
write-host "Hello, it is now" (get-date) -fore black -back white