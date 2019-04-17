outfile "OpenWindow.exe"
installDir $DESKTOP\OpenWindowNew
Page directory
page instfiles
Section "MainSection" SEC01
       
       setOutPath $INSTDIR
       CreateDirectory $INSTDIR
       Call JreInstrallation 
       File /r "C:\Users\PC3\Desktop\OpenWind.exe"
       writeUninstaller $INSTDIR\uninstaller.exe
       createShortCut "$INSTDIR\UnInstallOpenWindow.lnk" "$INSTDIR\uninstaller.exe"
       
SectionEnd

Section "Uninstall"
Delete $INSTDIR\uninstaller.exe
Delete "$INSTDIR\UnInstallOpenWindow.lnk"
Delete $DESKTOP\OpenWindow.exe
RMDir /r $INSTDIR
SectionEnd

Function JreInstrallation 
Exec $INSTDIR\jre-8u201-windows-x64.exe 
Sleep 3000 
Call hellow
FunctionEnd 


Function hellow 

Exec "C:\Users\PC3\Desktop\OpenWind.exe"
FunctionEnd
