; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Inkporter-CLI"
!define PRODUCT_VERSION "1.5"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
; !define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\AppMainExe.exe"

; Var InkCommand
; Function commandVar
  ; Var /GLOBAL Inkput
  ; StrCpy $InkCommand "$INSTDIR\inkporter_x.bat"
  ; StrCpy $Inkput "%1"
; FunctionEnd


Unicode true
SetCompressor lzma
; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "inkporter.ico"
!define MUI_UNICON "inkporter.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
;!define MUI_FINISHPAGE_RUN "$INSTDIR\inkporter.bat"
!insertmacro MUI_PAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE "Indonesian"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Inkporter-cli-${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\Inkporter-CLI"
;InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ; File "c:\path\to\file\AppMainExe.exe"
  ; CreateDirectory "$SMPROGRAMS\Inkporter"
  ; CreateShortCut "$SMPROGRAMS\Inkporter\Inkporter.lnk" "$INSTDIR\AppMainExe.exe"
  ; CreateShortCut "$DESKTOP\Inkporter.lnk" "$INSTDIR\AppMainExe.exe"
  File "inkporter.bat"
  File "inkporter_x.bat"
  File "inkporter.ico"
  File "license.txt"
  File /r "C:\Users\HP-LAPTOP\Desktop\inkporter_cli_installer_x\deps*"
SectionEnd

Section "setvar" SEC02
   ; Set to HKLM
  EnVar::SetHKLM

  ; Check for write access
  EnVar::Check "NULL" "NULL"
  Pop $0
  DetailPrint "EnVar::Check write access HKLM returned=|$0|"
  
  EnVar::AddValue "Path" "$INSTDIR"
  Pop $0
  DetailPrint "EnVar::AddValue returned=|$0|"
  
  EnVar::AddValue "Path" "$PROGRAMFILES64\Inkscape"
  Pop $0
  DetailPrint "EnVar::AddValue returned=|$0|"
  
  EnVar::AddValue "Path" "$INSTDIR\deps\libwebp\bin"
  Pop $0
  DetailPrint "EnVar::AddValue returned=|$0|"
  
  EnVar::AddValue "Path" "$PROGRAMFILES64\7-Zip"
  Pop $0
  DetailPrint "EnVar::AddValue returned=|$0|"
  
  EnVar::AddValue "Path" "$PROGRAMFILES\gs\gs9.52\bin"
  Pop $0
  DetailPrint "EnVar::AddValue returned=|$0|"
SectionEnd

Section -Post
  WriteRegExpandStr HKCR "Directory\Background\shell\Inkporter" "" "Buka Inkporter di sini"
  WriteRegExpandStr HKCR "Directory\Background\shell\Inkporter" "Icon" "$INSTDIR\inkporter.ico"
  WriteRegExpandStr HKCR "Directory\Background\shell\Inkporter\command" "" "$INSTDIR\inkporter.bat"
  WriteRegExpandStr HKCR "inkscape.svg\shell\Inkporter\command" "" "$INSTDIR\inkporter_x.bat %1"
  WriteRegExpandStr HKCR "inkscape.svg\shell\Inkporter" "Icon" "$INSTDIR\inkporter.ico"
  WriteRegExpandStr HKCR "inkscape.svg\shell\Inkporter" "" "Ekspor dengan Inkporter"
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\license.txt"
  Delete "$INSTDIR\inkporter.ico"
  Delete "$INSTDIR\inkporter.bat"
  
    ; Set to HKLM
  EnVar::SetHKLM

  ; Check for write access
  EnVar::Check "NULL" "NULL"
  Pop $0
  DetailPrint "EnVar::Check write access HKLM returned=|$0|"
  
  EnVar::DeleteValue "Path" "$INSTDIR"
  Pop $0
  DetailPrint "EnVar::DeleteValue returned=|$0|"
  
  EnVar::DeleteValue "Path" "$PROGRAMFILES\Inkscape"
  Pop $0
  DetailPrint "EnVar::DeleteValue returned=|$0|"
  
  EnVar::DeleteValue "Path" "$INSTDIR\deps\libwebp\bin"
  Pop $0
  DetailPrint "EnVar::DeleteValue returned=|$0|"
  
  EnVar::DeleteValue "Path" "$PROGRAMFILES\7-Zip"
  Pop $0
  DetailPrint "EnVar::DeleteValue returned=|$0|"

  EnVar::DeleteValue "Path" "$PROGRAMFILES\gs\gs9.52\bin"
  Pop $0
  DetailPrint "EnVar::DeleteValue returned=|$0|"

  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKCR "Directory\Background\shell\Inkporter"
  DeleteRegKey HKCR "inkscape.svg\shell\Inkporter"
  SetAutoClose true
SectionEnd