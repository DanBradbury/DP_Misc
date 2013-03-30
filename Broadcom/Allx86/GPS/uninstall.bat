@echo off
REM * Copyright 2012 Broadcom Corporation -- http://www.broadcom.com
REM * This program is the proprietary software of Broadcom Corporation and/or
REM * its licensors, and may only be used, duplicated, modified or distributed
REM * pursuant to the terms and conditions of a separate, written license
REM * agreement executed between you and Broadcom (an "Authorized License").
REM * Except as set forth in an Authorized License, Broadcom grants no license
REM * (express or implied), right to use, or waiver of any kind with respect to
REM * the Software, and Broadcom expressly reserves all rights in and to the
REM * Software and all intellectual property rights therein. IF YOU HAVE NO
REM * AUTHORIZED LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY
REM * WAY, AND SHOULD IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE ALL USE OF
REM * THE SOFTWARE.
setlocal

"%~dp0devcon.exe" rescan > nul || (
    goto MUST_BE_ADMIN
)

echo -------------------Uninstalling Broadcom Location Driver-------------------
echo Backup the log files if they are valuable!!!
:pause
@echo  
echo Last chance to copy your valuable log files and test data!!!
:pause

@echo  
echo Ensure to navigate away from [PC Settings\Wireless]
echo One way is to click on [PC Settings\General]
:pause

@echo  
echo Extremely IMPORTANT!!!
echo Double ensure to navigate away from [PC Settings\Wireless]
echo One way is to click on [PC Settings\General]
:pause

echo Removing "Sensors\BcmGnssLocationSensor"
"%~dp0devcon.exe" remove "Sensors\BcmGnssLocationSensor"
set inf=
set cat="BcmGnssLocationSensor.cat"
call:InfName inf %cat%
if not defined inf goto UNINSTALL_BUS_DRIVER
"%~dp0devcon.exe" dp_delete %inf% -f 

:UNINSTALL_BUS_DRIVER
echo Removing "ACPI\BCM4751"
"%~dp0devcon.exe" remove "ACPI\BCM4751" || goto UNINSTALL_BCMGNSS
goto REMOVE_BUS_INF

:UNINSTALL_BCMGNSS
echo Removing "ACPI\BCMGNSS"
"%~dp0devcon.exe" remove "ACPI\BCMGNSS" || goto UNINSTALL_BRCMGPS
goto REMOVE_BUS_INF

:UNINSTALL_BRCMGPS
echo Removing 
"%~dp0devcon.exe" remove "ACPI\BRCMGPS"

:REMOVE_BUS_INF
set inf=
set cat="BcmGnssBus.cat"
call:InfName inf %cat%
if not defined inf goto REMOVE_FILES
"%~dp0devcon.exe" dp_delete %inf% -f

:REMOVE_FILES
echo Removing Location Sensor Driver Files
set Files=BcmGnss.dll Bcm4752Gnss.dll BcmGnssCbee.dll BcmGnssConfig.xml BcmGnssLbsWlan.dll BcmGnssNetDetect.dll BcmGnssGpio.dll BcmGnssGpioAcpi.dll BcmGnssGpioCp210x.dll BcmGnssLocationSensor.dll CP210xRuntime.dll BcmGnssAtRil.dll BcmGnssAtRil.pdb BcmGnssBus.pdb BcmGnssLocationSensor.pdb
for %%f in (%files%) do (
    if exist %SystemRoot%\System32\Drivers\UMDF\%%f (
        takeown /F %SystemRoot%\System32\Drivers\UMDF\%%f > nul
        icacls %SystemRoot%\System32\Drivers\UMDF\%%f /grant %USERNAME%:f > nul
        del /F /Q /S %SystemRoot%\System32\Drivers\UMDF\%%f > nul
    )
)

del /F /Q /S %SystemRoot%\System32\Drivers\UMDF\BcmGnss*.* > nul

reg import "%~dp0uninstall.reg"

echo Removing Bus Driver Files
if exist %SystemRoot%\System32\Drivers\BcmGnssBus.sys (
    takeown /F %SystemRoot%\System32\Drivers\BcmGnssBus.sys > nul
    icacls %SystemRoot%\System32\Drivers\BcmGnssBus.sys /grant %USERNAME%:f > nul
    del /F /Q %SystemRoot%\System32\Drivers\BcmGnssBus.sys > nul
)

echo Removing Log and NV Files
if exist C:\BcmGnssLog rd /S /Q C:\BcmGnssLog\ 2>&1 nul
set NV_PATH=%ProgramData%\Broadcom\Location
if exist %NV_PATH% (
    echo Delete the files, except the directory because OS somehow holds the handle
    del /F /Q /S %NV_PATH%\*.* > nul
    if exist %NV_PATH%\SyslogArchive rd /Q /S %NV_PATH%\SyslogArchive
)

goto FINISH

:InfName
set token="%~2"
for %%f in (%SystemRoot%\inf\oem*.inf) do (
    type %%f | find %token% > %~dp0inf.txt
    for /F %%a in (%~dp0inf.txt) do (
        set "%~1=%%f"
        goto:eof
    )    
)
goto:eof

:MUST_BE_ADMIN
echo Must run as Administrator

:FINISH
if exist %~dp0inf.txt del /F /Q %~dp0inf.txt
echo -------------------Broadcom Location Driver Uninstalled--------------------
:pause
endlocal