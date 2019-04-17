outfile "OpenWindow.exe"
installDir $DESKTOP\OpenWindowNew

Section "MainSection" SEC01
       
       setOutPath $INSTDIR
       CreateDirectory $INSTDIR
       Call JreInstrallation 
       File /r "C:\Users\PC3\Desktop\zzzz.exe"
       writeUninstaller $INSTDIR\uninstaller.exe
       createShortCut "C:\Users\PC3\Desktop\UnInstallOpenWindow.lnk" "C:\Users\PC3\Desktop\OpenWindowNew\uninstaller.exe"
       
SectionEnd

Section "Uninstall"
Delete $INSTDIR\uninstaller.exe
Delete "C:\Users\PC3\Desktop\UnInstallOpenWindow.lnk"
Delete $DESKTOP\OpenWindow.exe
RMDir /r $INSTDIR
SectionEnd

Function JreInstrallation 
Exec $INSTDIR\jre-8u201-windows-x64.exe 
Sleep 3000 
Call hellow
FunctionEnd 

Function hellow 
Exec "C:\Users\PC3\Desktop\zzzz.exe"
FunctionEnd


