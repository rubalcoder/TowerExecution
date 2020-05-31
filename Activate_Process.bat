@echo off
SET TOWERLIST=INDELPC577 INDELPC592 INDELPC605 INDELPC695 INDELPC699 INDELPC700 INDELPC704 INDELPC706 INDELPC708 INDELPC409 INDELPC574 INDELPC608 INDELPC633 INDELPC469
::SET TOWERLIST=INDELPC605
REM
setlocal enabledelayedexpansion
for %%i in (%TOWERLIST%) do ( 
set TESTTOWER=%%i
call :CHECK_TOWER_AVAILABLE_OVER_NETWORK
)
REM
:CHECK_TOWER_AVAILABLE_OVER_NETWORK
 ping %TESTTOWER% > NUL
 if [%errorlevel%]==[0] (
 echo The testtower %TESTTOWER% is available on the network
 call :CHECK_ATM_SERVICE_RUNNING
 Call :CHECK_JENKINS_SLAVE_SERVICE
 ) else do (echo The testtower %TESTTOWER% is NOT available on the network
 )
 goto :eof
 
:CHECK_ATM_SERVICE_RUNNING
 tasklist /FI "IMAGENAME eq ATM server.exe" > NUL
	if [%errorlevel%]==[0] (echo ATM Service active on the %TESTTOWER%
	)	else do (echo ATM Service NOT active on the %TESTTOWER%
		WMIC /NODE:"%TOWERLIST%" /user:AP\inampbsuser /password:Jan@2020 process call create "C:\Program Files\Landis+Gyr\ATM Server\ATM Server.exe"
		if [%errorlevel%]==[0] (echo ATM Service is enabled)
	)
 goto :eof
 
:CHECK_JENKINS_SLAVE_SERVICE
  tasklist /FI "IMAGENAME eq java.exe" > NUL
	if [%errorlevel%]==[0] (echo ATM Service active on the %TESTTOWER%
	)	else do (echo ATM Service NOT active on the %TESTTOWER%
		WMIC /NODE:"%TOWERLIST%" /user:AP\inampbsuser /password:Jan@2020 process call create "C:\C:\Users\inampbsuser\Desktop\start_jenkins_slave.bat - Shortcut.lnk"
	)
 goto :eof
 
