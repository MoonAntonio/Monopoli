/**************************************************************************

    GetDXVer.cpp

    Demonstrates how applications can detect what version of DirectX
    is installed.

 **************************************************************************/
/**************************************************************************

    (C) Copyright 1995-1997 Microsoft Corp.  All rights reserved.

    You have a royalty-free right to use, modify, reproduce and
    distribute the Sample Files (and/or any modified version) in
    any way you find useful, provided that you agree that
    Microsoft has no warranty obligations or liability for any
    Sample Application Files which are modified.

 **************************************************************************/
#include "PC3DHdr.h"


/****************************************************************************
 *
 *      GetDXVersion
 *
 *  This function returns two arguments:
 *  dwDXVersion:
 *      0     No DirectX installed
 *      0x100   DirectX version 1 installed
 *      0x200   DirectX 2 installed
 *      0x300   DirectX 3 installed
 *      0x500   At least DirectX 5 installed.
 *      0x600   At least DirectX 6 installed.
 *  dwDXPlatform:
 *      0                             Unknown (This is a failure case. Should never happen)
 *      VER_PLATFORM_WIN32_WINDOWS      Windows 9X platform
 *      VER_PLATFORM_WIN32_NT     Windows NT platform
 * 
 * Please note that this code is intended as a general guideline. Your app will
 * probably be able to simply query for functionality (via COM's QueryInterface)
 * for one or two components.
 * Please also note:
 *      "if (dxVer != 0x500) return FALSE;" is BAD. 
 *      "if (dxVer < 0x500) return FALSE;" is MUCH BETTER.
 * to ensure your app will run on future releases of DirectX.
 *
 ****************************************************************************/

typedef HRESULT(WINAPI * DIRECTDRAWCREATE)(GUID*, LPDIRECTDRAW*, IUnknown*);
typedef HRESULT(WINAPI * DIRECTINPUTCREATE)(HINSTANCE, DWORD, LPDIRECTINPUT*,
                                            IUnknown*);

void GetDXVersion(DWORD& dwDXVersion, DWORD& dwDXPlatform)
{
  HRESULT                 hr                = NULL;
  HINSTANCE               DDHinst           = NULL;
  HINSTANCE               DIHinst           = NULL;
  LPDIRECTDRAW            pDDraw            = NULL;
  LPDIRECTDRAW2           pDDraw2           = NULL;
  DIRECTDRAWCREATE        DirectDrawCreate  = NULL;
  DIRECTINPUTCREATE       DirectInputCreate = NULL;
  LPDIRECTDRAWSURFACE     pSurf             = NULL;
  LPDIRECTDRAWSURFACE3    pSurf3            = NULL;
  LPDIRECTDRAWSURFACE4    pSurf4            = NULL;
  OSVERSIONINFO           osVer;

  dwDXVersion   = 0;
  dwDXPlatform  = 0;

  // First get the windows platform
  osVer.dwOSVersionInfoSize = sizeof(osVer);
  if (!GetVersionEx(&osVer))
    return;

  if (osVer.dwPlatformId == VER_PLATFORM_WIN32_NT)
  {
    dwDXPlatform = VER_PLATFORM_WIN32_NT;

    // NT is easy... NT 4.0 is DX2, 4.0 SP3 is DX3, 5.0 is DX5
    // and no DX on earlier versions.
    if (osVer.dwMajorVersion < 4)
    {
      dwDXPlatform = 0; //No DX on NT3.51 or earlier
      return;
    }

    if (osVer.dwMajorVersion == 4)
    {
      // NT4 up to SP2 is DX2, and SP3 onwards is DX3, so we are at least DX2
      dwDXVersion = 0x200;

      // We're not supposed to be able to tell which SP we're on, so check
      //  for dinput
      DIHinst = LoadLibrary("DINPUT.DLL");
      if (DIHinst == 0)
      {
        // No DInput... must be DX2 on NT 4 pre-SP3
        OutputDebugString("Couldn't LoadLibrary DInput\r\n");
        return;
      }

      DirectInputCreate = (DIRECTINPUTCREATE)GetProcAddress(DIHinst,
                                                            "DirectInputCreateA");
      FreeLibrary(DIHinst);

      if (DirectInputCreate == 0)
      {
        // No DInput... must be pre-SP3 DX2
        OutputDebugString("Couldn't GetProcAddress DInputCreate\r\n");
        return;
      }

      // It must be NT4, DX2
      dwDXVersion = 0x300;  //DX3 on NT4 SP3 or higher
      return;
    }

    // Else it's NT5 or higher, and it's DX5a or higher:
    // Drop through to Win9x tests for a test of DDraw (DX6 or higher)
  }
  else
  {
    // Not NT... must be Win9x
    dwDXPlatform = VER_PLATFORM_WIN32_WINDOWS;
  }

  // Now we know we are in Windows 9x (or maybe 3.1), so anything's possible.
  // First see if DDRAW.DLL even exists.
  DDHinst = LoadLibrary("DDRAW.DLL");
  if (DDHinst == 0)
  {
    dwDXVersion = 0;
    dwDXPlatform = 0;
    FreeLibrary(DDHinst);
    return;
  }

  //  See if we can create the DirectDraw object.
  DirectDrawCreate = (DIRECTDRAWCREATE)GetProcAddress(DDHinst,
                                                      "DirectDrawCreate");
  if (DirectDrawCreate == 0)
  {
    dwDXVersion = 0;
    dwDXPlatform = 0;
    FreeLibrary(DDHinst);
    OutputDebugString("Couldn't LoadLibrary DDraw\r\n");
    return;
  }

  hr = DirectDrawCreate(NULL, &pDDraw, NULL);
  if (FAILED(hr))
  {
    dwDXVersion = 0;
    dwDXPlatform = 0;
    FreeLibrary(DDHinst);
    OutputDebugString("Couldn't create DDraw\r\n");
    return;
  }

  //  So DirectDraw exists.  We are at least DX1.
  dwDXVersion = 0x100;

  //  Let's see if IID_IDirectDraw2 exists.
  hr = pDDraw->QueryInterface(IID_IDirectDraw2, (LPVOID *) & pDDraw2);
  if (FAILED(hr))
  {
    // No IDirectDraw2 exists... must be DX1
    pDDraw->Release();
    FreeLibrary(DDHinst);
    OutputDebugString("Couldn't QI DDraw2\r\n");
    return;
  }

  // IDirectDraw2 exists. We must be at least DX2
  pDDraw2->Release();
  dwDXVersion = 0x200;

  //  See if we can create the DirectInput object.
  DIHinst = LoadLibrary("DINPUT.DLL");
  if (DIHinst == 0)
  {
    // No DInput... must be DX2
    OutputDebugString("Couldn't LoadLibrary DInput\r\n");
    pDDraw->Release();
    FreeLibrary(DDHinst);
    return;
  }

  DirectInputCreate = (DIRECTINPUTCREATE )GetProcAddress(DIHinst,
                                                         "DirectInputCreateA");
  FreeLibrary(DIHinst);

  if (DirectInputCreate == 0)
  {
    // No DInput... must be DX2
    FreeLibrary(DDHinst);
    pDDraw->Release();
    OutputDebugString("Couldn't GetProcAddress DInputCreate\r\n");
    return;
  }

  // DirectInputCreate exists. That's enough to tell us that we are at least DX3
  dwDXVersion = 0x300;

  // Checks for 3a vs 3b?

  // We can tell if DX5 is present by checking for the existence of
  //  IDirectDrawSurface3.  First we need a surface to QI off of.
  DDSURFACEDESC desc;

  ZeroMemory(&desc, sizeof(desc));
  desc.dwSize = sizeof(desc);
  desc.dwFlags = DDSD_CAPS;
  desc.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;

  hr = pDDraw->SetCooperativeLevel(NULL, DDSCL_NORMAL);
  if (FAILED(hr))
  {
    // Failure. This means DDraw isn't properly installed.
    pDDraw->Release();
    FreeLibrary(DDHinst);
    dwDXVersion = 0;
    OutputDebugString("Couldn't Set coop level\r\n");
    return;
  }

  hr = pDDraw->CreateSurface(&desc, &pSurf, NULL);
  if (FAILED(hr))
  {
    // Failure. This means DDraw isn't properly installed.
    pDDraw->Release();
    FreeLibrary(DDHinst);
    dwDXVersion = 0;
    OutputDebugString("Couldn't CreateSurface\r\n");
    return;
  }

  // Try for the IDirectDrawSurface3 interface. If it works, we're on DX5 at least
  if (FAILED(pSurf->QueryInterface(IID_IDirectDrawSurface3, (LPVOID*)&pSurf3)))
  {
    pDDraw->Release();
    FreeLibrary(DDHinst);
    return;
  }

  // QI for IDirectDrawSurface3 succeeded. We must be at least DX5
  dwDXVersion = 0x500;

  // Try for the IDirectDrawSurface4 interface. If it works, we're on DX6 at least
  if (FAILED(pSurf->QueryInterface(IID_IDirectDrawSurface4, (LPVOID*)&pSurf4)))
  {
    pDDraw->Release();
    FreeLibrary(DDHinst);
    return;
  }

  // QI for IDirectDrawSurface4 succeeded. We must be at least DX6
  dwDXVersion = 0x600;

  pSurf->Release();
  pDDraw->Release();
  FreeLibrary(DDHinst);

  return;
}

