#pragma once
/** /#define UNICODE //*/
#ifdef UNICODE
#	define _UNICODE
#endif

#define _WIN32_WINNT 0x0501
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <ShellAPI.h>
#include <TChar.h>
#include <WindowsX.h>

#define FORCEINLINE __forceinline

#ifndef ARRAYSIZE
#	define ARRAYSIZE(___c) ( sizeof(___c)/sizeof(___c[0]) )
#endif


#ifndef SEE_MASK_NOZONECHECKS
#define SEE_MASK_NOZONECHECKS 0x00800000
#endif

#ifndef MSGFLT_ADD
#define MSGFLT_ADD 1
#endif


#if !defined(NTDDI_VISTA) || defined(BUILD_OLDSDK)
enum TOKEN_ELEVATION_TYPE { 
	TokenElevationTypeDefault = 1, 
	TokenElevationTypeFull, 
	TokenElevationTypeLimited 
};
enum _TOKEN_INFORMATION_CLASS___VISTA {
	TokenElevationType = (TokenOrigin+1),
	TokenLinkedToken,
	TokenElevation,
	TokenHasRestrictions,
	TokenAccessInformation,
	TokenVirtualizationAllowed,
	TokenVirtualizationEnabled,
	TokenIntegrityLevel,
	TokenUIAccess,
	TokenMandatoryPolicy,
	TokenLogonSid,
};
#endif


#ifndef _WIN64
FORCEINLINE HANDLE WINAPI GetCurrentProcess(){return ((HANDLE)(-1));}
FORCEINLINE HANDLE WINAPI GetCurrentThread(){return ((HANDLE)(-2));}
#endif

