FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019

COPY . /artifacts/

RUN ./artifacts/tools/IISSetup.ps1
	


####Install Chocolatey (Experimenting)
#RUN Powershell Set-DNSClientServerAddress –InterfaceAlias "Ethernet" –ServerAddresses (“8.8.8.8”,”8.8.4.4”);\
#	Powershell Set-ExecutionPolicy Bypass -Scope Process -Force; \
#	Powershell -file C:\inetpub\wwwroot\Tools\choco.ps1

#SHELL ["Powershell"]
#RUN Set-DNSClientServerAddress –InterfaceAlias "Ethernet" –ServerAddresses (“8.8.8.8”,”8.8.4.4”);\
#	Set-ExecutionPolicy Bypass -Scope Process -Force; \ 
#	[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
#	iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

EXPOSE 8080