set firmware=
set branch=
echo select the option for cloning branch
echo 1. master
echo 2. Release-1.0
set /p branch=select the option:
if '%branch%'=='1' set branch_name=master
if '%branch%'=='2' set branch_name=release-1.0
set SLOT=SLOT_A
set batch_file_current_directory=%cd%
set variant=Ref_MMI3
set slot_lookup_location=D:\slots
set project=Picasso
SET firmware_flash_files_path=C:\nb_flash_files\%variant%\Release
::SET branch_name=%1
::SET Build_No=%2
echo %branch_name%
SET /p firmware=enter the firmware no: 
if not [%firmware%]==[] set Build_No=%firmware%
IF not [%branch_name%]==[] goto Flash_Clone

:Flash_Clone
 call xcopy /E /H /Y /I \\fijyvvrcis07\deliveries\firmware\Picasso\nightly-builds\%branch_name%\%Build_No%\Publish\%variant%\Release\Flash D:\Firmware\%branch_name%\%Build_No%\Flash\
 cd /D D:\Firmware\%branch_name%\%Build_No%\Flash
 call JLinkdownload.bat
 cd /D %batch_file_current_directory%
 cd /D %slot_lookup_location%\%SLOT%\%project%\%variant%
 rmdir Picasso_Test /s /q
 git clone ssh://jhaabhis@gerrit-eu.landisgyr.net:29418/Picasso_Test --branch %branch_name%
 cd /D %slot_lookup_location%\%SLOT%\%project%\%variant%\Picasso_Test\Setups\ATS\%variant%
 call Setup_ATS_%variant%.bat
 cd /D %batch_file_current_directory%
 goto end_bat

:end_bat
 echo flashing cloning done