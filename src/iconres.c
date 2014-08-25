/****************************** Module Header ******************************\
*
* Module Name: RESOURCE.C - REXX Resource DLL loader
*
* Dummy REXX-routine for resource-DLLs, so that REXX routines can load them
* into memory for to use them with the setup  keyword ICONRESOURCE for
* SysCreateObject and SysSetObjectData functions under WARP 3.
* Under WARP 4 the ICONRESOURCE feature can be used to load an icon from a
* resource DLL not requiring to load it.
*
* On further questions send mail to author to:
*    C.Langanke@TeamOS2.de
*
* Copyright (c) Christian Langanke 2001
*
* ===========================================================================
*
* This file is free software.  You can redistribute it and/or modify it under
* the terms of the GNU Library General Public License as published by the
* Free Software Foundation, in version 2 as it comes in the "COPYING.LIB"
* file of this package. 
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Library General Public
* License for more details.
*
\***************************************************************************/


#define INCL_ERRORS
#include <os2.h>
#define  INCL_REXXSAA
#include <rexxsaa.h>


// some useful REXX macro
#define BUILDRXSTRING(t, s) { \
  strcpy((t)->strptr,(s));\
    (t)->strlength = strlen((s)); \
    }

// export all REXX-Functuions to REXX handler
RexxFunctionHandler RxLoadThisResourceDll;

// -----------------------------------------------------------------

ULONG RxLoadThisResourceDll
         (
         PSZ            pszName,
         ULONG          ulNumargs,
         RXSTRING       args[],
         PSZ            pszQueuename,
         PRXSTRING      prxstrRetstr
         )
{
static   PSZ            pszResult = "0";

// do nothin special here, just return zero as result string
BUILDRXSTRING( prxstrRetstr, pszResult);

// no REXX exception
return NO_ERROR;
}

