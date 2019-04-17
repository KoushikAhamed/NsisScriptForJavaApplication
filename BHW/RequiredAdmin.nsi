Name "my program"   
Caption "my program Launcher"    
!include LogicLib.nsh
!include x64.nsh   
OutFile "javaLauncher.exe"
  
RequestExecutionLevel admin

!include UAC.nsh

SilentInstall silent
AutoCloseWindow true
ShowInstDetails show

Section ""    
   ${If} ${Cmd} 'MessageBox MB_YESNO "yes to install jre" IDYES' 
     ${If} ${RunningX64} 
       ${DisableX64FSRedirection} 
          ${Unless} ${FileExists} "$SYSDIR\javaw.exe" 
            ExecWait '"jre-8u201-windows-x64.exe.exe"' 
          ${EndUnless} 
       ${EnableX64FSRedirection} 
     ${EndIf} 
   ${EndIf}
  
  Goto endActiveSync
  endActiveSync:
     ${If} ${Cmd} 'MessageBox MB_YESNO "installed jre" IDYES' 
     ${EndIf}
SectionEnd