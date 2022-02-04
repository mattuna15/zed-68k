/*  ------------------------------------------------------------------------
Program      : rmcr (gcc -o rmcr.exe rmcr.c)

Description  : Commandline Utility

               Converts Windows Text Files to "Unix" Text Files by
			   removing carriage-returns (CR = 0x0d) from the Windows
			   sequential text file's CR-LF linefeed termination pairs,
			   leaving only the "Unix" file's linefeed termination
			   (LF = 0x0a).

Input:  Windows Sequential Text File
Output: "Unix" Sequential Text File

Purpose:

The cpmtools diskdefs file is a plain ascii text file (in "unix" format,
not Windows format) that serves as a database of disk and disk image
format definitions.

To convert between Windows text and "unix" text, two utilities (rmcr and
cr) are included in the Windows distro of the cpmtools binaries. These
are included so you can use a Windows text editor to edit a copy of
diskdefs if your Windows text editor does not edit "unix" text.

Written by   : Tom Burnett
Date Released: Nov 16, 2013
Revised by   : Bill Buckels
Date Revised : Nov 18, 2013

Revision     : 1.0 First Release of rmcr
               1.1 Second Release of rmcr

               Compiles under MinGW

Licence      : You may use this program for whatever you wish as long
               as you agree that neither Tom Burnett nor Bill Buckels
               have any warranty or liability obligations whatsoever
               from said use.
------------------------------------------------------------------------ */

#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[])
{
	int c;
	FILE *fp1;
	FILE *fp2;
	if (argc != 3) {
		fprintf(stderr, "Usage: rmcr <in_filename> <out_filename>\n");
		return(1);
	}

	if (strcmpi(argv[1],argv[2]) == 0) {
		fprintf(stderr, "<in_filename> and <out_filename> must be different.\n");
		return(1);
	}

	if ((fp1 = fopen(argv[1], "rb")) == NULL) {
		fprintf(stderr, "open failure on %s\n", argv[1]);
		return(2);
	}

	if ((fp2 = fopen(argv[2], "wb")) == NULL) {
		fclose(fp1);
		fprintf(stderr, "open failure on %s for write.\n", argv[2]);
		return(2);
	}

	while ((c = fgetc(fp1)) != EOF) {
		if (c == 0x0d) {
			continue;
		} else {
			fputc(c, fp2);
		}
	}

	fclose(fp1);
	fclose(fp2);
	return(0);
}
