# Enable IIS Remote Management
Install-WindowsFeature -Name Web-Mgmt-Service;
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WebManagement\Server -Name EnableRemoteManagement -Value 1 -Force;
Get-Service -Name WMSVC | Start-Service;
net user 'harish' 'Concerto#1' /ADD;
net localgroup administrators 'harish' /add

#Enable IIS Directory browsing
C:\windows\system32\inetsrv\appcmd.exe set config ('Default Web Site') /section:directoryBrowse /enabled:true

#Print IPconfig
ipconfig