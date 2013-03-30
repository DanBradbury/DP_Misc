-----------------------------------------------------------------------
Winbond Electronics Corporation
CIR Microsoft(R) Windows(R)-based Drivers installation package for the  
Winbond Notebook Embedded Controllers
Copyright (c) 2007 Winbond Electronics Corporation. All Rights Reserved.
-----------------------------------------------------------------------

Release Letter for: 
WPC876xL/WPCE775x CIR Drivers installation package:		7.60.1012

Date:                                                   	August 2007

By downloading, installing, copying, or otherwise using the Winbond CIR 
Device Drivers, you accept the terms of the license agreement provided 
in WinbondEC_CIRDrivers_EULA.txt file.

1. PACKAGE CONTENTS
   This zip file contains the following files:
   
   - setup.exe                      - The setup application.
   - CIRdrivers_Installer.msi       - MSI installation package.
   - *.inf                          - Drivers information files
   - *.cat                          - Drivers catalog files
   - winbondhidcir.reg              - HID CIR driver registry settings file with specific 
                                      configuration for DELL system
   - i386\*.*                       - The Drivers system files for the x32 platform
   - amd64\*.*                      - The Drivers system files for the x64 platform
   - WinbondEC_CIRDrivers_EULA.txt  - End User License Agreement
   - ReadMe.txt                     - This Release Letter

2. DESCRIPTION
   This product is the Winbond CIR drivers installation package for the WPC876xL and WPCE775x.
   This installation package contains the following drivers:
   
   2.1 WPC876xL Windows Vista(TM)-based MC CIR Port 32/64-bit Driver. 
       Version:         7.1.62.2012
       BIOS PnP ID:	WEC1020,WEC1021             
   
       The driver implements:
       - Receive-Only Windows MC functionality for systems without 
         TV tuner (BIOS PnP ID - WEC1020)
       - Receive, Learning, and Transmit Windows MC functionality 
         for systems with TV tuner (BIOS PnP ID - WEC1021).

   2.2 WPCE775x Windows Vista(TM)-based MC CIR Port 32/64-bit Driver 
       Version:         7.1.63.1001
       BIOS PnP ID:	WEC1024. 
      
       The driver implements:
       - Receive-Only Windows MC functionality for systems without 
         TV tuner
       - Receive, Learning, and Transmit Windows MC functionality 
         for systems with TV tuner

   2.3 The WPC876xL/WPCE775x Windows XP/Vista-based HID CIR 32/64-bit Driver
       Version:          7.1.64.1011
       BIOS PnP ID:	 WEC1023.
       
       The driver implements:
         Receive functionality for systems with RC6 remote control for DELL system.

   The Windows-based drivers are designed to work with the WPC876xL/WPCE775x firmware, which
   implements Windows MC CIR support. See Section 3 for details.
   
   These drivers are released in Beta quality for the WPC876xL/WPCE775x chips.

3. REQUIREMENTS
    Operating System:
      Media Center-compatible CIR Port drivers:
         32/64-bit Windows Vista
      HID CIR driver:
         32/64-bit Windows XP/Vista
    
    Hardware:
        A platform containing a Winbond Electronics WPC876xL/WPCE775x device with 
        appropriate firmware and PnP BIOS.
        
        - The WPC876xL firmware should support Windows MC CIR functionality, according to
          WPC876xL_CEIR_MCE_FW_driver version 3.0.0
        - The WPCE775x firmware should support Windows MC CIR functionality, according to
          WPCE775x_CEIR_MCE_FW_driver version 1.0.0. 
        
        These firmware drivers are provided in a separate packages.
        For a detailed description of the firmware drivers, see their documentation.

4. INSTALLING/UNINSTALLING SOFTWARE COMPONENTS
   To install, extract the zip file to a directory of your choice on a DELL system with 
   an on-board Winbond WPC876xL/WPCE775x device.

   You must have administrator privileges to install/update the driver.

   Installation procedure:

   a. Regular install:
     - Double-click "CIRdrivers_Installer.msi" or run "setup.exe  -i CIRdrivers_Installer.msi"
     - Follow the on-screen instructions to complete the driver installation
   b. Silent install:
     - Run "setup.exe -s -i CIRdrivers_Installer.msi"
   
   To determine installation status, check the value of the following registry entry:
      HKLM\SOFTWARE\Winbond Electronics Corporation\CIR Device Drivers\install

   Uninstallation procedure:
   
   a. Regular uninstallation:
     - Under "Add or Remove Program", press "Remove" button (for XP) or "Uninstall" button (for Vista) 
       in "Winbond CIR Device Drivers" entry
     - Follow the on-screen instructions to complete the driver uninstallation
   b. Command line uninstallation:
     - Run "setup.exe -u -i CIRdrivers_Installer.msi"
   c. Command line silent uninstallation:
     - Run "setup.exe -s -u -i CIRdrivers_Installer.msi"

5. CHANGES FROM THE PREVIOUS RELEASE  
   * The package contains new WPCE775x Windows MC CIR Port Driver
   * The installation package supports both WPCE775x and WPC876xL chips

6. FIXED ISSUES
   * HID CIR driver sometimes issued fake report due to external noises.
   * HID CIR driver default setttings (winbondhidcir.reg) disable remote control address (ID) matching mechanism
   
7. KNOWN ISSUES
   None.
   
   
