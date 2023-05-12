$filePath = "C:\Users\Administrator\Desktop\"

if (Test-Path $filePath)
{
Start-BitsTransfer -Source "C:\Windows\youvebeenhacked.txt" -Destination "C:\Users\Administrator\Desktop\youvebeenhacked.txt"
}
