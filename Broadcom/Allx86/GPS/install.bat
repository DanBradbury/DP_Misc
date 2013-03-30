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

mode con: lines=80

call "%~dp0uninstall.bat"

"%~dp0devcon.exe" rescan > nul || (
    goto MUST_BE_ADMIN
)

echo.
echo -----------------------Installing Serial Bus Driver------------------------
:INSTALL_ACPI_BCM4751
REM On some newer firmware, it will be BCM4751 for naming compliance
echo Installing ACPI BCM4751
"%~dp0devcon.exe" update "%~dp0BcmGnssBus.inf" "ACPI\BCM4751" || (
    REM If ID is not BCM4751, try BCMGNSS
    goto INSTALL_ACPI_BCMGNSS
)
goto UPDATE_LOCATION_SENSOR

:INSTALL_ACPI_BCMGNSS
REM On most firmware, it will be this name
echo Installing ACPI BCMGNSS
"%~dp0devcon.exe" update "%~dp0BcmGnssBus.inf" "ACPI\BCMGNSS" || (
    REM If ID is not BCMGNSS, try BRCMGPS
    goto INSTALL_ACPI_BRCMGPS
)
goto UPDATE_LOCATION_SENSOR

:INSTALL_ACPI_BRCMGPS
REM On some older firmware, it might still be this name
echo Installing ACPI BRCMGPS
"%~dp0devcon.exe" update "%~dp0BcmGnssBus.inf" "ACPI\BRCMGPS" || (
    REM If ID is not BCMGNSS, then something is wrong. We cannot continue.
    goto MUST_HAVE_ACPI_BCMGNSS
)

:UPDATE_LOCATION_SENSOR
echo.
echo ----------------------Updating Location Sensor Driver----------------------
"%~dp0devcon.exe" rescan > nul

REM Will succeed if it can be installed as child of BcmGnssBus
echo Updating BcmGnssLocationSensor
"%~dp0devcon.exe" update "%~dp0BcmGnssLocationSensor.inf" "Sensors\BcmGnssLocationSensor" || (
    echo Something went wrong. 
    echo Ensure uninstall is successful!
)
goto FINISH

:MUST_BE_ADMIN
echo Must run as Administrator
echo Ensure the computer is boot with "Disable Driver Signature Enforcement"
goto FINISH

:MUST_HAVE_ACPI_BCMGNSS
echo -----------------------------------ERROR-----------------------------------
type "%~dp0acpi.txt"
echo -----------------------------------ERROR-----------------------------------

:FINISH

REGEDIT /S LTO.reg

echo ---------------------Broadcom Location Driver Installed--------------------
:pause
endlocal
