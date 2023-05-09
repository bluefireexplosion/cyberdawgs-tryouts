$filePath = "C:\Users\Administrator\Desktop\youvebeenhacked.txt"

if (Test-Path $filePath)
{
Start-BitsTransfer -Source "https://raw.githubusercontent.com/bluefireexplosion/cyberdawgs-tryouts/master/hackedtext.txt" -Destination "C:\Users\Administrator\Desktop\youvebeenhacked.txt"
}
