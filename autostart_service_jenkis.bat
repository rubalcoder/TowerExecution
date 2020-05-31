@echo off
set batch_file_current_directory=%~dp0
set current_directory=%batch_file_current_directory:~0,-1%
echo %current_directory%
set user=%username%
set hostname=%COMPUTERNAME%
echo %user% %hostname%
if exist "C:\Program Files\Landis+Gyr\ATM Server" (call :startATMService) else (echo ATM_Service does not exist on %hostname%)
if exist "C:\ls" (call :startJenkins) else (echo Jenkins_Slave does not exist on %hostname%)
goto :eof

:startATMService
 qprocess "ATM Server.exe" > NUL
 if [%errorlevel%]==[0] (echo ATM Service is active on the %hostname%) else (
	cd /D "C:\Program Files\Landis+Gyr\ATM Server"
	start cmd.exe /k "ATM Server.exe")
 	)
	cd /D %current_directory%
 goto :eof

:startJenkins
 qprocess java.exe > NUL
	if [%errorlevel%]==[0] (echo Jenkins_slave is active on the %hostname%) else (
	cd /D "C:\ls"
	start cmd.exe /k "start_jenkins_slave.bat")
	)
	)
	cd /D %current_directory%
 goto :eof
	