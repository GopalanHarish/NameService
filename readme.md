# Sample .NET 4.0 project (Monolithic) using Windows container

- A Sample .NET 4.0 project (Monolithic) using Windows container.
This project has ASP.NET Webforms, WebApi, Console application and WCF interacting with each other. 
- This was suppose to be a POC for a client who was willing (well, had to convince the evident advantages of using Docker) to migrate existing monolithic application to Docker windows container.
- Target chosen cloud vendor was Microsoft Azure.
- Unfortunately, Client settled for IBM PIaaS Cloud VM because the requirements dictates that platform needs to be either PaaS or Serverless (if hosted in Azure).
- Client was not foolish to have this requirement. Azure was missing some kind of medical compliance to host in a IaaS but apparently it was compliant with PaaS/Serverless.
- As of writing on 21-Aug-2020, The only true serverless service in Azure is the ACI but ACI has limitations and particularly involving with joining VNet. Webapps for Windows and Service Mesh are in public preview (not suitable for production workloads).

# Purpose of repo
- Backup.
- Future reference.

# Steps

- Build repo and publish projects to a common folder (c:\deploy).
	- Copy Webforms/Webapi and WCF project to \wwwroot\.
	- Copy Consoleapp to \WindowsApps\
	- Copy Tools folder from repo root to \Tools\
	- Copy dockerfile from repo root to \\.
- use below command to build
>C:\deploy> Docker build -t nameservice:1.0.0 . 

# How projects interacts with each other
|Project|Purpose  |
|--|--|
| WCF | Simply prints inputString + "Suffix". |
| WebAPI | Writes message to a FTP file. (http://localhost/WebApiApp/File/{message_to_write_to_file}) |
| Console App | Appends output of WebAPI FTP file to existing console app FTP file. Make sure path "c:\inetpub\ftproot\consoleoutput.txt" exist during first run.  |
| WebForms | is used to output/results from above projects. |

FTP (using IIS) is used for hosting files.

# Powershell scripts details
**IISSetup.ps1**
* Enable windows feature, setup FTP, convert folders in wwwroot to IIS webApplication. 

**IISDebugSetup.ps1**
* Enable IIS Remote administration + IIS directory browsing. 
* Debug purpose only.
* Must be executed manually (look at essential commands for details).

Script files are properly commented.

# Essential commands
* Run Docker container
	> Docker container run --name=Nameservice -p=8080:80 -d --dns=8.8.8.8 -v c:/users/hgopalan/DockerOutput:c:/DockerOutput Nameservice:1.0.0

* Mount is used to copy files from container to host ex: event logs.
* Copy files from host to container. (WARNING: Hyper-v isolated (in Win10) doesn't allow this command unless containers are stopped.)
	> Docker cp c:\deploy Nameservice:c:\inetpub\wwwroot

* Download and install Chocolatey and Carbon inside container.
	>Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	
	> choco install carbon

* Copy event logs from container to volume mount path in host.
	> Get-EventLog -LogName "Application" | Export-Csv -LiteralPath "c:\dockeroutput\testeventlog.csv" -NoTypeInformation

* Manually enable IIS Remote administration + IIS directory browsing in container for debugging purposes.
	>Docker exec -it Nameservice Powershell c:\inetpub\wwwroot\tools\iisdebugconfig.ps1
	 * Host IIS requires "IIS Manager for Remote Administration" installed to manage remote IIS.

# What's missing (in project)
- Console app needs to be setup using Windows Task scheduler.
- Windows service.
- Centralized logging (Azure log analytics agent failed due to nonexistence of 'server' windows service.).
- Setup Chocolatey (package manager for windows) and Carbon (Powershell devops utility for managing windows features/IIS and lot more). Although Chocolatey can be used its mostly better to copy the setup files over using Docker images.
- MSBUILD to automate published files copying to common folder etc.

# Bugs I noticed in windows container (disclaimer: needs more research)
- By default DNS is not properly configured in Windows Container.
	- To look at configured (default) DNS server from container
	  > Get-DNSClientServerAddress

	- Set custom DNS using command
		>Set-DNSClientServerAddress –interfaceIndex 12 –ServerAddresses (“8.8.8.8”,”8.8.4.4”) 
		**(!!CAREFUL!! Copying commands from host to container removes '-' and ' " ')**
- Setting DNS server causes IIS to crash. Hence, this causes the container itself to stop due to ServiceMonitor.exe monitoring w3svc.
