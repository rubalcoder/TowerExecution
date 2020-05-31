SET File_before=Firmwaremodules
SET File_after=Firmwaremodules
set slot_list=SLOT_A
set batch_file_current_directory=%cd%
set slot_lookup_location=D:\slots
set project="E360 EMEA"
setlocal enabledelayedexpansion
set /a count=0
set "skip="

:start_compare
 setlocal enabledelayedexpansion
 for %%i in (%slot_list%) do ( 
 call :Read_Process_File_before %%i
 )
REM
goto :eof
:Read_Process_File_before
 set slot=%~1
 cd /D %slot_lookup_location%\%slot%\%Project%
 for /f "%skip% tokens=1 delims=" %%j in (%File_before%.txt) do (
 echo %%j
 cd /D %batch_file_current_directory%
 call :Read_Process_File_After %slot% , %%j
 )
REM
:Read_Process_File_After 
 set slot=%~1
 set hex_before=%~2
 cd /D %slot_lookup_location%\%slot%\%Project%
 for /f "%skip% tokens=1 delims=" %%k in (%File_after%.txt) do (
 echo %%k
 cd /D %batch_file_current_directory%
 call :compare_both_hex %hex_before% , %%k
 )
REM
:compare_both_hex
 set hex_before=%~1
 set hex_after=%~2
 if /I [%hex_before%]==[%hex_after%] (echo true hex file before is equal to hex file after) else (echo false hex file before is not equal to hex file after)
 set /a count+=1
 set "skip=skip=%count%"
 if  [%count%]==[5] exit 
 call :start_compare
 
 

 