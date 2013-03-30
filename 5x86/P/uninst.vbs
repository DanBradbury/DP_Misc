'
' uninst.vbs
'
'   -z unattEnd mode ( Do not reboot automatically )
'   -ro Run from RunOnce
'
'   Un installer for hotkey manager
'     * Display Confirm message
'     * Delete 'Hotkey' Entrty in registry
'          HKLM\Software\Microsoft\Windows\CurrentVersion\Run\
'     * Register this file to 
'          HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
'     * Ask user reboot system
'     When execute from RunOnce
'     * Delete hkeyman.exe at system directory
'        ( System directory is C:\WINNT\SYSTEM32 or C:\Windows\system )
'

On Error Resume Next

'//
'// Global variables
'//

'// Registry 'Run' entry
RegRun         = "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\Hotkey"
RegRunServices = "HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices\Hotkey"
RegRunOnce     = "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce"

'// Setup Flag
UnattEndMode= False

'// Confirm Message
strConfirmMessage_M   = "Are you sure you want to completely remove 'Hotkey Manager' and all its components?"

strConfirmMessage_J   = "'Hotkey Manager'とそのコンポーネントを全て削除しますか？"

strConfirmTitle_M      = "Remove Hotkey Manager"
strConfirmTitle_J      = "Hotkey Manager 削除"

'// Reboot Message
strRebootMessage_M    = "You must restart computer manually before the new settings will take effect."

strRebootMessage_J    = "アンインストールを完了するにはシステムをリブートしてください"

strRebootTitle_M      = "System Setting Change"
strReboottitle_J      = "システム設定変更"

Dim WshShell
Set WshShell = Wscript.CreateObject("Wscript.Shell")
Set WshArgs  = Wscript.Arguments
Set objFileSys      = CreateObject("Scripting.FileSystemObject")

If WshArgs.Count <> 0 Then
 strOption = WshArgs.Item(0)
 If strOption="-z" Then
     UnattEndMode = True
 elseIf strOption="-ro" Then
     call AtRunOnce()
     Wscript.Quit
 End If
End If 

'//
'// Display Comfirm message
'//
If Confirm() = vbNo Then
  Wscript.Quit
End If

'//
'// Delete 'Hotkey' Entrty in registry
'//
call DeleteHotkey()

'//
'// Register this file to 
'//
call RegisterThisFile()

'//
'// Reboot
'//
call ManualReboot()

'//
'// Quit
'//
Wscript.Quit


'//
'// Confirm
'//
Function Confirm()
  '// Local 1041 is Japanese
  LocalId = GetLocale()
  If LocalId = 1041 Then
    strConfirmMessage =  strConfirmMessage_J
    strConfirmTitle   =  strConfirmTitle_J
  else
    strConfirmMessage =  strConfirmMessage_M
    strConfirmTitle   =  strConfirmTitle_M
  End If 

  Confirm = vbNo
  If UnattEndMode then
     Confirm = vbYes
  else
     Confirm = WshShell.Popup( strConfirmMessage,,strConfirmTitle, vbYesNo)
  End If
End Function

'// 
'// Delete Hoktey
'//
Sub DeleteHotkey()
On Error Resume Next

  '// Read Hotkey
  '//
  Hkeyman = WshShell.RegRead(RegRun)

  If Hkeyman <> Empty Then
    '// Delete key
    WshShell.RegDelete RegRun
  End If

  '// Read Hotkey( for Me )
  '//
  Hkeyman = WshShell.RegRead(RegRunServices)

  If Hkeyman <> Empty Then
    '// Delete key
    WshShell.RegDelete RegRunServices
  End If
End Sub

'//
'// Register this file to
'//   HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
'//
Sub RegisterThisFile()

  RegRunOnceDeleteHotkey = RegRunOnce & "\DelHotkey"
  DeleteHotkeyCmd        = "wscript " & Wscript.ScriptFullName & " -ro"
  WshShell.RegWrite RegRunOnceDeleteHotkey, DeleteHotkeyCmd, "REG_SZ"

End Sub

'//
'// Ask User Reboot system by manual
'//
Sub ManualReboot()

  LocalId = GetLocale()
  '// Local 1041 is Japanese
  If LocalId = 1041 Then
    strRebootMessage =  strRebootMessage_J
    strRebootTitle   =  strRebootTitle_J
  else
    strRebootMessage =  strRebootMessage_M
    strRebootTitle   =  strRebootTitle_M
  End If

  If Not UnattEndMode Then
    WshShell.Popup strRebootMessage,,strRebootTitle, vbYesNo
  End If

End Sub

'//
'// This Subroutine is called from RunOnce
'//   Delete hkeyman.exe at system folder
'//
Sub AtRunOnce()
  SystemFolder = 1
  Set tFolder = objFileSys.GetSpecialFolder(SystemFolder)
  FolderName  = tFolder.Path
  Hkeyman = FolderName & "\hkeyman.exe"
  objFileSys.DeleteFile Hkeyman
End Sub
