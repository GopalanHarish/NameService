Import-Module WebAdministration

#### Activate WCF feature
Install-WindowsFeature -Name NET-WCF-HTTP-Activation45;

#### Setup Web application in IIS
Move-Item -Force -Verbose "C:\artifacts\wwwroot\*" -Destination "C:\inetpub\wwwroot\";
ConvertTo-WebApplication 'IIS:\Sites\Default Web Site\WCFApp','IIS:\Sites\Default Web Site\WebApiApp','IIS:\Sites\Default Web Site\WebApplication';
	
### Setup FTP server in IIS
Install-WindowsFeature Web-FTP-Server -IncludeAllSubFeature;
New-WebFtpSite -Name 'prodftpsite' -Port 21 -PhysicalPath 'c:\inetpub\ftproot';

	#FTP Authentication (Set as Anonymous Auth)
	Set-ItemProperty -Path 'IIS:\Sites\prodftpsite' -Name 'ftpServer.security.authentication.anonymousAuthentication.enabled' -Value $True;

	#FTP Authorization rules
	Add-WebConfiguration "/system.ftpServer/security/authorization" -value @{accessType="Allow";roles="";permissions="Read,Write";users="*"} -PSPath IIS:\ -location "prodftpsite";
	
	#FTP SSL Settings
	Set-ItemProperty -Path 'IIS:\Sites\prodftpsite' -Name 'ftpServer.security.ssl.controlChannelPolicy' -Value $false;
	Set-ItemProperty -Path 'IIS:\Sites\prodftpsite' -Name 'ftpServer.security.ssl.dataChannelPolicy' -Value $false;
	
	#Provide 'EVERYONE' access to FTProot (no recommended for production)
	$sharepath = "c:\inetpub\ftproot"
	$Acl = Get-ACL $SharePath
	$AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("everyone","FullControl","ContainerInherit,Objectinherit","none","Allow")
	$Acl.AddAccessRule($AccessRule)
	Set-Acl $SharePath $Acl

Restart-WebItem "IIS:\Sites\prodftpsite" -Verbose;