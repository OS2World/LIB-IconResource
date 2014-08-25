/*
 *    TEST.CMD for ICONRES package - C.Langanke 2001
 *
 *  This package shows how icons for WPS objects can be loaded
 *  from a self-created resource DLL by using the setup string
 *  keyword ICONRESOURCE.
 *
 *  Unlike with warp 4, the DLL specified with ICONRESOURCE must be
 *  loaded in memory. The easiest way to archive that is to include
 *  a (dummy) REXX function into the resource dll. For to let also
 *  WARP 3 load that DLL, at least one function of such a REXX
 *  resource DLL must be registered AND called.
 *
 *  Executing TEST.CMD, it creates an icon on the desktop, which will
 *  launch the System Editor. What is more interesting though, is, if
 *  the icon of that object will be the one or the resource DLL.
 *  If it is a red square, the DLL and this program is working well,
 *  if the icon of the System Editor appears, the icon from within the
 *  resource DLL cannot be loaded.
 *
 */

 call RxFuncAdd    'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
 call SysLoadFuncs

 fIsBelowWarp4 = (SysOS2Ver() < 2.40);
 ModuleName    = 'iconres.dll'
 IconId        = 123;

 PARSE SOURCE . . CallName
 CallDir = LEFT( CallName, LASTPOS( '\', CallName) - 1)
 Library = Calldir'\'ModuleName;

 IF (fIsBelowWarp4) THEN
 DO
    /* let WARP 3 load this resource DLL */
    call RxFuncAdd 'RxLoadThisResourceDll', Library, 'RxLoadThisResourceDll'
    call RxLoadThisResourceDll;
 END;

 /* reference the icon with id in that dll */
 rcx = sysCreateObject( 'WPProgram', 'IconResource' , '<WP_DESKTOP>', 'EXENAME=E.EXE;ICONRESOURCE='IconId','Library';', 'R');

 IF (fIsBelowWarp4) THEN
 DO
    /* free the DLL again */
    call RxFuncDrop 'RxLoadThisResourceDll'
 END;

