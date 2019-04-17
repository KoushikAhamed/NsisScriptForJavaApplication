
outfile "OpenWindow.exe"
installDir $DESKTOP\OpenWindow

Section "MainSection" SEC01
       
       setOutPath $INSTDIR
       CreateDirectory $INSTDIR
       Call JreInstrallation 
       File /r "C:\Users\PC3\Desktop\Openwindow.jar"
       

SectionEnd
Function JreInstrallation 
Exec $INSTDIR\jre-8u201-windows-x64.exe 
Sleep 3000 
Call hellow
FunctionEnd 

Function hellow 
Exec $INSTDIR\Openwindow.jar
Call jarEx
FunctionEnd

Function jarEx
SearchPath $0 "Openwindow.exe"
StrCmp $0 "" 0 OK1 
; if javaw.exe in PATH
ReadRegStr $1 HKLM "SOFTWARE\JavaSoft\Java Runtime Environment" "CurrentVersion"
ReadRegStr $0 HKLM "SOFTWARE\JavaSoft\Java Runtime Environment\$1" "JavaHome"
StrCmp $0 "" Error OK2
OK1:
StrCmp $0 "Openwindow.exe -jar Openwindow.jar" OK null

null:
MessageBox MB_OK "Openwindow.exe invalid"
Abort
OK2:
StrCmp $0 '"$0\Openwindow.exe" -jar Openwindow.jar' OK null
 
Error:
MessageBox MB_OK "Openwindow.exe does not exist!"
Abort
OK:
Exec $0
FunctionEnd