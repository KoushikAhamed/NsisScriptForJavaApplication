 
outfile "OpenWindow.exe"


Section "MainSection" SEC01
  call .onInit
SectionEnd









Function .onInit
   ReadINIStr $0 $INSTDIR\winamp.ini winamp outname
   StrCmp $INSTDIR "" 0 NoAbort
     MessageBox MB_OK "Windows Commander not found. Unable to get install path."
     Abort ; causes installer to quit.
   NoAbort:
 FunctionEnd

  Function .onInstFailed
    MessageBox MB_OK "Better luck next time."
  FunctionEnd

  Function .onInstSuccess
    MessageBox MB_YESNO "Congrats, it worked. View readme?" IDNO NoReadme
      Exec notepad.exe ; view readme or whatever, if you want.
    NoReadme:
  FunctionEnd