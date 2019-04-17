!include "MUI.nsh"

!define NAME "BHW"
#!define JAR "tinbot.jar"
!define VERSION "1.0"
!define PUBLISHER "Koushik"
#!define WEBSITE "http://my.home/"
!define JRE_VERSION "1.8"
#!define JRE_URL "http://javadl.sun.com/webapps/download/AutoDL?BundleId=58134"
!define JRE_URL "https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jre-8u201-windows-x64.exe"
!include "FileFunc.nsh"
!insertmacro GetFileVersion
!insertmacro GetParameters
!include "WordFunc.nsh"
!insertmacro VersionCompare

Name "${NAME}"
OutFile "${NAME}-${VERSION}.exe"
RequestExecutionLevel admin
;XPStyle on
SetCompressor bzip2
InstallDir $PROGRAMFILES64\${NAME}

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;UninstPage uninstConfirm
;UninstPage instfiles

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "German"

LangString JavaInstall ${LANG_ENGLISH} "${NAME} needs the Java Runtime Environment version ${JRE_VERSION} or newer but it is not installed on your system. Do you want to automatically download and install it? Press 'No' if you want to install Java manually later."
LangString JavaInstall ${LANG_GERMAN} "${NAME} benötigt die Java Laufzeit Umgebung Version ${JRE_VERSION} oder neuer aber diese wurde nicht auf Ihrem System gefunden. Wollen Sie sie jetzt automatisch herunterladen und installieren? Klicken Sie 'Nein' um Java später selbst zu installieren."

LangString Uninstall ${LANG_ENGLISH} "Uninstall"
LangString Uninstall ${LANG_GERMAN} "Deinstallation"

Function GetJRE
  MessageBox MB_YESNO|MB_ICONQUESTION $(JavaInstall) IDNO done
  StrCpy $2 "$TEMP\Java Runtime Environment.exe"
  nsisdl::download /TIMEOUT=50000 ${JRE_URL} $2 
  #ExecWait "jre-8u201-windows-x64.exe" 
  
  Pop $R0
  StrCmp $R0 "success" +3
  
  ExecWait "$2"
  Delete "$2"
  done:
FunctionEnd

Function DetectJRE
  ${GetFileVersion} "$SYSDIR\javaw.exe" $R1
  ${VersionCompare} ${JRE_VERSION} $R1 $R2
  StrCmp $R2 0 done
  StrCmp $R2 2 done
  Call GetJRE
  done:
FunctionEnd

Section
  Call DetectJRE
  SetOutPath $INSTDIR
  
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  CreateDirectory "$SMPROGRAMS\${NAME}"
  CreateShortCut "$SMPROGRAMS\${NAME}\$(Uninstall).lnk" \
    "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0 SW_SHOWNORMAL

  #File README.txt
  #File LICENSE.txt
  #File ${NAME}.ico
  File BHW.exe
  #SetOutPath $INSTDIR\lib
  #File tinbot.jar
  #ExecWait '"C:\Program Files\Java\jdk1.8.0_111\jre\bin\java.exe"'
  createShortCut "$DESKTOP\${NAME}.lnk" "$INSTDIR\BHW.exe"
   
#  CreateShortCut "$INSTDIR\${NAME}.lnk" \
#    "$SYSDIR\javaw.exe" "-jar $\"$INSTDIR\lib\${JAR}$\"" "$INSTDIR\${NAME}.ico" 0 SW_SHOWNORMAL
#  CreateShortCut "$SMPROGRAMS\${NAME}\${NAME}.lnk" \
#    "$SYSDIR\javaw.exe" "-jar $\"$INSTDIR\lib\${JAR}$\"" "$INSTDIR\${NAME}.ico" 0 SW_SHOWNORMAL
#  CreateShortCut "$DESKTOP\${NAME}.lnk" \
#    "$SYSDIR\javaw.exe" "-jar $\"$INSTDIR\lib\${JAR}$\"" "$INSTDIR\${NAME}.ico" 0 SW_SHOWNORMAL

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "DisplayName" "${NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "DisplayVersion" "${VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "DisplayIcon" "$INSTDIR\${NAME}.ico"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
  #WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "Publisher" "${PUBLISHER}"
  #WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "HelpLink" "${WEBSITE}"
  #WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "URLInfoAbout" "${WEBSITE}"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "NoRepair" 1
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "InstallLocation" "$INSTDIR"
  ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
  IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "EstimatedSize" $0
  
  #ExecWait '"$SYSDIR\javaw.EXE" "$INSTDIR\bhoot.exe"'
  ExecShell "open" '"$INSTDIR"'
  Exec {NAME}.exe
SectionEnd

Section "Uninstall"
  RMDir /r "$INSTDIR\lib"
  Delete "$INSTDIR\${NAME}.lnk"
  Delete "$INSTDIR\${NAME}.ico"
  Delete "$INSTDIR\README.txt"
  Delete "$INSTDIR\LICENSE.txt"
  Delete "$INSTDIR\Uninstall.exe"
  RMDir "$INSTDIR"
  Delete "$SMPROGRAMS\${NAME}\$(Uninstall).lnk"
  Delete "$SMPROGRAMS\${NAME}\${NAME}.lnk"
  Delete "$DESKTOP\${NAME}.lnk"
  RMDir "$SMPROGRAMS\${NAME}"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}"
SectionEnd