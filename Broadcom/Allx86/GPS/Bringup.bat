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
mode con: cols=120 lines=80
start %~dp0Tools\traceview.exe
echo ========= TraceView Configuration =========
echo If TraceView has been previously configured for this release, go to step 2.1
echo.
echo 1.1. In TraceView, "Menu->File->Create New Log Session" to open "Create New Log Session"
echo.
echo 1.2. Click "Add Provider" to open "Provider Control GUID Setup"
echo.
echo 1.3. Select "PDB (Debug Informatoin) File", then click "..."
echo.
echo 1.4. Navigate to the current release and select "BcmGnssBus.pdb", then click "Open"
echo .
echo 1.5. Click "OK" to close "Provider Control GUID Setup"
echo .
echo 1.6. Click "Add Provider" to open "Provider Control GUID Setup"
echo.
echo 1.7. Select "PDB (Debug Informatoin) File", click "..." 
echo.
echo 1.8. Navigate to the current release and "BcmGnssLocationSensor.pdb", then click "Open"
echo.
echo 1.9. Click "OK" to close "Provider Control GUID Setup"
echo.
echo 1.10. In "Create New Log Session", click "Next >" to open "Log Session Options"
echo.
echo 1.11. Click "Set Flags and Level >>" to open "Tracing Flags and Level Selection"
echo.
echo 1.12. Double-click on "Level" and select "Verbose"
echo.
echo 1.13. Double-click on "Flags" and select all flags
echo.
echo 1.14. Click "OK" to close "Tracing Flags and Level Selection"
echo.
echo 1.15. Click "Finish" to close "Log Session Options"
echo.
echo 1.16. Right-click on "LogSession0" and select "Save Workspace..." to open "Save Workspace"
echo.
echo 1.17. Type the last 6 digits of the release in the "New Workspace" text field. Example: 130917
echo.
echo 1.18. Click "OK" to close "Save Workspace"
echo.
echo ========= Open TraceView Workspace =========
echo 2.1. On next runs, "Menu->File->Open Workspace..." to open "Open Workspace"
echo.
echo 2.2. Select the workspace (example 130917) in "Saved Workspace" area and click "OK"
pause
echo ========= Friendly Reminder: Configure TraceView =========
echo Double Ensure TraceView is configured
echo 
echo ========= Friendly Reminder: Configure TraceView =========
pause
cls
type "%~dp0..\Docs\bringup.txt"
echo.
pause
call "%~dp0\Tests\CollectAlmanac.bat" Bringup
cls
echo ========= Copy TraceView Messages =========
echo 3.1. In TraceView message area, Ctrl-Home to go to first line
echo.
echo 3.2. Click on the first line
echo.
echo 3.3. Ctrl-End to go to last line
echo. 
echo 3.4. Shift-click last line to select all lines
echo. 
echo 3.5. Right-click on selection and choose "Copy"
echo.
echo 3.6. Paste the content into a text file, and save as "Bringup_Traceview.txt"
echo. 
echo 3.7. Be patient as the clipboard copying process can be quite slow depending on the amount
pause
echo 3.8. Close TraceView
echo.
echo ========= Friendly Reminder: Save TraceView Contents =========
echo Double Ensure TraceView contents are saved!!!
echo 
echo ========= Friendly Reminder: Save TraceView Contents =========
pause
taskkill /f /im Traceview.exe 2> nul
pause