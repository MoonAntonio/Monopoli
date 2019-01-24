# Microsoft Developer Studio Project File - Name="TheGame" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=TheGame - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "TheGame.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "TheGame.mak" CFG="TheGame - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "TheGame - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "TheGame - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "TheGame - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /MT /W3 /GX /Od /I "." /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D DIRECTDRAW_VERSION0=0x0600 /Yu"GameInc.h" /FD /c
# SUBTRACT CPP /nologo
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# SUBTRACT MTL /nologo
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# SUBTRACT BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386
# ADD LINK32 libcmt.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib winmm.lib vfw32.lib msacm32.lib dxguid.lib dsound.lib ddraw.lib dplayx.lib oldnames.lib ../Bink/BinkW32.lib /subsystem:windows /machine:I386 /nodefaultlib /out:"Monopoly.exe"
# SUBTRACT LINK32 /nologo

!ELSEIF  "$(CFG)" == "TheGame - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /MTd /W3 /Gm /GX /ZI /Od /I "." /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D DIRECTDRAW_VERSION=0x0600 /FR /Fp"TheGame.pch" /Yu"GameInc.h" /FD /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /D "_DEBUG" /mktyplib203 /o "NUL" /win32
# SUBTRACT MTL /nologo
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# SUBTRACT BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 libcmtd.lib imagehlp.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib winmm.lib vfw32.lib msacm32.lib dxguid.lib dsound.lib ddraw.lib dplayx.lib oldnames.lib ../Bink/BinkW32.lib /subsystem:windows /profile /map:"TheGame.map" /debug /machine:I386 /nodefaultlib /out:"Monopoly.exe"

!ENDIF 

# Begin Target

# Name "TheGame - Win32 Release"
# Name "TheGame - Win32 Debug"
# Begin Group "Resource Files"

# PROP Default_Filter "*.bmp,*.ico,*.cur"
# Begin Source File

SOURCE=.\BackGround.bmp
# End Source File
# Begin Source File

SOURCE=.\BackGroundEuro.bmp
# End Source File
# Begin Source File

SOURCE=.\Overlay.BMP
# End Source File
# Begin Source File

SOURCE=.\Overlay2.BMP
# End Source File
# Begin Source File

SOURCE=.\TestMsg01.bmp
# End Source File
# Begin Source File

SOURCE=.\TestMsg02.bmp
# End Source File
# Begin Source File

SOURCE=.\Testmsg03.bmp
# End Source File
# Begin Source File

SOURCE=.\TestMsg04.bmp
# End Source File
# Begin Source File

SOURCE=.\TestMsg05.bmp
# End Source File
# Begin Source File

SOURCE=.\TestMsg06.bmp
# End Source File
# Begin Source File

SOURCE=.\TestMsg07.bmp
# End Source File
# Begin Source File

SOURCE=.\TestMsg08.bmp
# End Source File
# Begin Source File

SOURCE=.\TestMsg09.bmp
# End Source File
# Begin Source File

SOURCE=.\TestMsg10.bmp
# End Source File
# End Group
# Begin Source File

SOURCE=.\Ai.cpp
# End Source File
# Begin Source File

SOURCE=.\Ai.h
# End Source File
# Begin Source File

SOURCE=.\Ai_load.cpp
# End Source File
# Begin Source File

SOURCE=.\Ai_load.h
# End Source File
# Begin Source File

SOURCE=.\Ai_trade.cpp
# End Source File
# Begin Source File

SOURCE=.\Ai_trade.h
# End Source File
# Begin Source File

SOURCE=.\Ai_util.cpp
# End Source File
# Begin Source File

SOURCE=.\Ai_util.h
# End Source File
# Begin Source File

SOURCE=.\C_ArtLib.h
# End Source File
# Begin Source File

SOURCE=.\Debugart.cpp
# End Source File
# Begin Source File

SOURCE=.\display.cpp
# End Source File
# Begin Source File

SOURCE=.\display.h
# End Source File
# Begin Source File

SOURCE=.\GameIcon.ico
# End Source File
# Begin Source File

SOURCE=.\GameInc.cpp
# ADD CPP /Yc"GameInc.h"
# End Source File
# Begin Source File

SOURCE=.\GameInc.h
# End Source File
# Begin Source File

SOURCE=.\Lang.cpp
# End Source File
# Begin Source File

SOURCE=.\Main.cpp
# End Source File
# Begin Source File

SOURCE=.\Mdef.cpp
# End Source File
# Begin Source File

SOURCE=.\Mess.cpp
# End Source File
# Begin Source File

SOURCE=.\Resource.rc
# End Source File
# Begin Source File

SOURCE=.\Rule.cpp
# End Source File
# Begin Source File

SOURCE=.\Rule.h
# End Source File
# Begin Source File

SOURCE=.\TexInfo.cpp
# End Source File
# Begin Source File

SOURCE=.\TexInfo.h
# End Source File
# Begin Source File

SOURCE=.\Tickler.cpp
# End Source File
# Begin Source File

SOURCE=.\trade.cpp
# End Source File
# Begin Source File

SOURCE=.\trade.h
# End Source File
# Begin Source File

SOURCE=.\UDAuct.cpp
# End Source File
# Begin Source File

SOURCE=.\UDAuct.h
# End Source File
# Begin Source File

SOURCE=.\UDBoard.cpp
# End Source File
# Begin Source File

SOURCE=.\UDBoard.h
# End Source File
# Begin Source File

SOURCE=.\UDChat.cpp
# End Source File
# Begin Source File

SOURCE=.\UDChat.h
# End Source File
# Begin Source File

SOURCE=.\UDIBar.cpp
# End Source File
# Begin Source File

SOURCE=.\UDIBar.h
# End Source File
# Begin Source File

SOURCE=.\UDOpts.cpp
# End Source File
# Begin Source File

SOURCE=.\UDOpts.h
# End Source File
# Begin Source File

SOURCE=.\Udpenny.cpp
# End Source File
# Begin Source File

SOURCE=.\Udpenny.h
# End Source File
# Begin Source File

SOURCE=.\UDPieces.cpp
# End Source File
# Begin Source File

SOURCE=.\UDPieces.h
# End Source File
# Begin Source File

SOURCE=.\udpsel.cpp
# End Source File
# Begin Source File

SOURCE=.\UDPsel.h
# End Source File
# Begin Source File

SOURCE=.\UDSound.cpp
# End Source File
# Begin Source File

SOURCE=.\UDSound.h
# End Source File
# Begin Source File

SOURCE=.\UDStats.cpp
# End Source File
# Begin Source File

SOURCE=.\UDStats.h
# End Source File
# Begin Source File

SOURCE=.\UDTrade.cpp
# End Source File
# Begin Source File

SOURCE=.\UDTrade.h
# End Source File
# Begin Source File

SOURCE=.\UDUtils.cpp
# End Source File
# Begin Source File

SOURCE=.\UDUtils.h
# End Source File
# Begin Source File

SOURCE=.\Unility.cpp
# End Source File
# Begin Source File

SOURCE=.\Userifce.cpp
# End Source File
# Begin Source File

SOURCE=.\Userifce.h
# End Source File
# End Target
# End Project
