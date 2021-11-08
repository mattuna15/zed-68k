*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
LINKIT equ 253
FIXDADD equ 252
FIXBUF equ 251
FIXDATA equ 250
FIXDCRLF equ 249
OUTCH equ 248
INCHE equ 247
RESERVED1 equ 246
RESERVED2 equ 245
CHRPRINT equ 244
OUTPUT equ 243
OUTPUT21 equ 242
PORTIN1 equ 241
PORTIN20 equ 240
TAPEOUT equ 239
TAPEIN equ 238
PRCRLF equ 237
HEX2DEC equ 236
GETHEX equ 235
PUTHEX equ 234
PNT2HX equ 233
PNT4HX equ 232
PNT6HX equ 231
PNT8HX equ 230
START1 equ 229
TUTOR equ 228
OUT1CR equ 227
GETNUMA equ 226
GETNUMD equ 225
PORTIN1N equ 224

    ORG    $8000
START:                  ; first instruction of program

* Put program code here
*
 * outbyte -- sends a byte out the serial port
 *	d0 - contains the byte to be sent
 *
 * Converts a newline to carriage return and newline.
 *
 	    
	    move.b  #13,d0
	    move.b	#OUTCH,d7		// Trap function code
	    trap	#14			// Call TUTOR function
	    
	    move.b  #10,d0
	    move.b	#OUTCH,d7		// Trap function code
	    trap	#14			// Call TUTOR function
	    
        move.b  #'a',d0
	    move.b	#OUTCH,d7		// Trap function code
	    trap	#14			// Call TUTOR function
	    
	    move.b  #'B',d0
	    move.b	#OUTCH,d7		// Trap function code
	    trap	#14			// Call TUTOR function
	    
	    move.b  #13,d0
	    move.b	#OUTCH,d7		// Trap function code
	    trap	#14			// Call TUTOR function
	    
	    move.b  #10,d0
	    move.b	#OUTCH,d7		// Trap function code
	    trap	#14			// Call TUTOR function
	    
	    move.b	#START1,d7		// Trap function code
	    trap	#14			// Call TUTOR function

*        MOVE.B #'a',d0
*        jSR $2e22

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
