!include LogicLib.nsh
!include x64.nsh
!include "Sections.nsh"
!include UAC.nsh
outfile "Installer.exe"
RequestExecutionLevel admin
installDir $DESKTOP\Black
Page directory
page instfiles
Section "MainSection" SEC01

       Call JreInstallation
       setOutPath $INSTDIR 
       CreateDirectory $INSTDIR      
       File /r "BhwBot.exe"       
       createShortCut "$DESKTOP\BHWBot.lnk" "$INSTDIR\BhwBot.exe"
       writeUninstaller $INSTDIR\uninstaller.exe      
SectionEnd

Section "Uninstall"
   	Delete $INSTDIR\uninstaller.exe
   	Delete $INSTDIR\BhwBot.exe
	Delete $DESKTOP\BHWBot.lnk
	RMDir /r $INSTDIR
SectionEnd
Function JreInstallation 

  ${If} ${Cmd} 'MessageBox MB_YESNO "yes to install jre" IDYES' 
     ${If} ${RunningX64} 
       ${DisableX64FSRedirection} 
          ${Unless} ${FileExists} "$SYSDIR\javaw.exe" 
            ExecWait '"jre-8u201-windows-x64.exe.exe"' 
          ${EndUnless} 
       ${EnableX64FSRedirection} 
     ${EndIf} 
   ${EndIf}
  Call hellow
FunctionEnd

Function hellow 
${If} ${Cmd} 'MessageBox MB_YESNO "Jre installed press Yes to continue.." IDYES' 
    Exec BHWBot.exe
${EndIf}

FunctionEnd
