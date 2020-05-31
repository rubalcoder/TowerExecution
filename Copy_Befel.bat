@echo off
set current_directory=%~dp0
set befel_path=%current_directory%ATS_CommandInterpreter 
xcopy /E /H /Y \\indelvs03\Public\Abhishek_Jha\COMMAND_INTERPRETOR %befel_path%
if exist C:\slots call :PATS_SLOTS "C:\slots"
if exist D:\slots call :PATS_SLOTS "D:\slots"
::if exist D:\test call :PATS_SLOTS "D:\test"
if exist D:\ATS_Common call :COPY_IN_ATS_COMMON D:\ATS_Common
if exist C:\ATS_Common call :COPY_IN_ATS_COMMON C:\ATS_Common 
goto :eof
:PATS_SLOTS
 ::setlocal enabledelayedexpansion
 set Slot_Path=%~1
 echo %Slot_Path%
 for /D %%i in (%Slot_Path%\*) do (
	if /I exist %%i\Picasso (
		for /D %%j in (%%i\Picasso\*) do (
			if /I [%%j]==[%%i\Picasso\Ref_NMS2] xcopy /E /H /Y %befel_path% %%i\Picasso\Ref_NMS2>NUL & echo copy sucess in %%i\Picasso\Ref_NMS2
			if /I [%%j]==[%%i\Picasso\Ref_MMI3] xcopy /E /H /Y %befel_path% %%i\Picasso\Ref_MMI3>NUL & echo copy sucess in %%i\Picasso\Ref_MMI3
			if /I [%%j]==[%%i\Picasso\Ref_IMS1] xcopy /E /H /Y %befel_path% %%i\Picasso\Ref_IMS1>NUL & echo copy sucess in %%i\Picasso\Ref_IMS1
			)
		)
	if /I exist %%i\"E360 EMEA"  xcopy /E /H /Y %befel_path% %%i\"E360 EMEA">NUL & echo copy success in %%i\"E360 EMEA"
 )
goto :eof
REM
:COPY_IN_ATS_COMMON
 set Slot_Path=%~1
 for /D %%i in (%Slot_Path%\Picasso\*) do (
	if /I [%%i]==[%Slot_Path%\Picasso\Ref_NMS2] xcopy /E /H /Y %befel_path% %Slot_Path%\Picasso\Ref_NMS2>NUL & echo copy success in %Slot_Path%\Picasso\Ref_NMS2
	if /I [%%i]==[%Slot_Path%\Picasso\Ref_MMI3] xcopy /E /H /Y %befel_path% %Slot_Path%\Picasso\Ref_MMI3>NUL & echo copy success in %Slot_Path%\Picasso\Ref_MMI3
	if /I [%%i]==[%Slot_Path%\Picasso\Ref_IMS1] xcopy /E /H /Y %befel_path% %Slot_Path%\Picasso\Ref_IMS1>NUL & echo copy success in %Slot_Path%\Picasso\Ref_IMS1
	)
 if /I exist %Slot_Path%\"E360 EMEA" xcopy /E /H /Y %befel_path% %Slot_Path%\"E360 EMEA">NUL & echo copy success in %Slot_Path%\"E360 EMEA"
goto :eof 
