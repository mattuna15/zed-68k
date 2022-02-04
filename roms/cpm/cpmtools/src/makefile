#
# Makefile for cpmtools, using MingW 
#
CC=		gcc
DISKDEFS=	/cpmtools/diskdefs
#
# 
#
CFLAGS=    -DMINGW -O -c -DDISKDEFS=\"$(DISKDEFS)\" -DFORMAT=\"apple-do\"
LDFLAGS=
LIBCURSES=	-lcurses

ALL=		cpmls.exe cpmrm.exe cpmcp.exe cpmchmod.exe cpmchattr.exe \
                mkfs.cpm.exe fsck.cpm.exe fsed.cpm.exe

all:		$(ALL)

.c.o:
		$(CC) $(CFLAGS) $(INCLUDES) -c $<  -o $@

cpmls.exe:	cpmls.o cpmfs.o device_win32.o
		$(CC) $(LDFLAGS) -o $@ cpmls.o cpmfs.o device_win32.o

cpmrm.exe:	cpmrm.o cpmfs.o device_win32.o
		$(CC) $(LDFLAGS) -o $@ cpmrm.o cpmfs.o device_win32.o

cpmcp.exe:	cpmcp.o cpmfs.o device_win32.o
		$(CC) $(LDFLAGS) -o $@ cpmcp.o cpmfs.o device_win32.o

cpmchattr.exe:	cpmchattr.o cpmfs.o device_win32.o
		$(CC) $(LDFLAGS) -o $@ cpmchattr.o cpmfs.o device_win32.o

cpmchmod.exe:	cpmchmod.o cpmfs.o device_win32.o
		$(CC) $(LDFLAGS) -o $@ cpmchmod.o cpmfs.o device_win32.o

mkfs.cpm.exe:	mkfs.cpm.o cpmfs.o device_win32.o
		$(CC) $(LDFLAGS) -o $@ mkfs.cpm.o cpmfs.o device_win32.o

fsck.cpm.exe:	fsck.cpm.o cpmfs.o device_win32.o
		$(CC) $(LDFLAGS) -o $@ fsck.cpm.o cpmfs.o device_win32.o

fsed.cpm.exe:	fsed.cpm.o getopt.o device_win32.o
		$(CC) $(LDFLAGS) -o $@ fsed.cpm.o cpmfs.o device_win32.o $(LIBCURSES)

clean:
		rm -f *.o,*.exe



