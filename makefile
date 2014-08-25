#****************************** Module Header ******************************\
#
# Module Name: makefile - REXX Resource DLL loader - makefile
#
# Copyright (c) Christian Langanke 2001
#
# ===========================================================================
#
# NOTE:
#
#  this makefile is compatible to
#     - IBM C Set 2
#     - IBM Visual Age V3 for OS/2
#
# ===========================================================================
#
# This file is free software.  You can redistribute it and/or modify it under
# the terms of the GNU Library General Public License as published by the
# Free Software Foundation, in version 2 as it comes in the "COPYING.LIB"
# file of this package.
# This library is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Library General Public
# License for more details.
#
#***************************************************************************/

# --- project specific
STEM=iconres

# --- common flags

!ifdef CPPLOCAL
LL=ilink
LFLAGS_VISUAL=/NOFREE
CWARNINGS=-W3 -Wcnd-
!else
LL=link386
LFLAGS_VISUAL=
CWARNINGS=-W3
!endif

CC=icc
CFLAGS=-Q $(CWARNINGS) -Ss+ -Rn -Ge- -c
LFLAGS=/A:4 /E /NOI /NOE /NOLOGO /CO /BASE:0X120000
EXTLIBS=REXX
RC=rc

# --- rules

.SUFFIXES: .exe .obj .c .obj .dll .def .ipf .inf

{src\}.c.obj:
        $(CC) $(CFLAGS) src\$(@B).c

.obj.dll:
        $(LL) $(LFLAGS) $*,$*.dll,$*.map,$(EXTLIBS),src\$(@B);
        $(RC) $(@B).res $(@B).dll

{src\}.rc.res:
        $(RC) -r src\$(@B).rc $(@B).res

# --- pseudo targets

dll: $(STEM).dll

clean:
   -@for %%a in (dummy *.obj *.res *.dll *.map) do @del %%a 2>NUL

# --- dependencies

$(STEM).dll: $(STEM).obj $(STEM).res src\$(STEM).def

$(STEM).obj: src\$(STEM).c

$(STEM).res: src\$(STEM).rc

