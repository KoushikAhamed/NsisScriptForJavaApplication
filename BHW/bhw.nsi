!include LogicLib.nsh
!include x64.nsh
outfile "Installer.exe"
installDir $DESKTOP\Black
Page directory
page instfiles
Section "MainSection" SEC01
       
       setOutPath $INSTDIR
       CreateDirectory $INSTDIR
       Call JreInstrallation 
       File /r "BHW.exe"
       
       createShortCut "$DESKTOP\BHW.lnk" "$INSTDIR\BHW.exe"
       writeUninstaller $INSTDIR\uninstaller.exe
      
SectionEnd

Section "Uninstall"
Delete $INSTDIR\uninstaller.exe
Delete $INSTDIR\BHW.exe
Delete $DESKTOP\BHW.lnk
RMDir /r $INSTDIR
SectionEnd

Function JreInstrallation 
${If} ${RunningX64} 
    ${DisableX64FSRedirection} 
    ${Unless} ${FileExists} "$SYSDIR\javaw.exe" 
        ExecWait '"jre-8u201-windows-x64.exe.exe"'
        
    ${EndUnless} 
    ${EnableX64FSRedirection} 

${EndIf} 
Call hellow
FunctionEnd 

Function hellow 
Exec BHW.exe
FunctionEnd
