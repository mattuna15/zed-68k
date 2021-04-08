ACIAC    EQU $F00009
ACIAD    EQU ACIAC+2

ACIA2C    EQU $F20009
ACIA2D    EQU ACIA2C+2

ACIA3C    EQU $F30009
ACIA3D    EQU ACIA3C+2

INT_ON   EQU  $2000    ; BOTH, SET SUPERVISOR MODE, S=1
INT_OFF  EQU  $2700

RDRF    EQU 0           ; ACIAC Receive Data Register Full
TDRE    EQU 1           ; ACIAC Transmit Data Register Empty

SUPERVISOR_BIT EQU 5

TRACE_BIT EQU 7

CR      EQU 13
LF      EQU 10
SP      EQU 32
BS      EQU 8
RS      EQU $1E
ESC     EQU $1B


    ORG $2000
**************************************************

MAIN 

    MOVE.W #INT_OFF,SR 
    BSR INIT_ACIA
   
    LEA.L TITLE1.L,A3     ; print START MESSAGE
    BSR PSTR
    
    
    BSET.B #0,$F40008
    BSET.B #1,$F40008
    BSET.B #2,$F40008
    
    JMP $A00BB4
    
*****************

OUT1X        MOVE.B D0,-(SP)    ;SAVE D0
             AND.B #$F,D0
             ADD.B #'0',D0
             CMP.B #'9',D0
             BLS.S   OUT1X1
             ADD.B #7,D0
OUT1X1       BSR COUT
             MOVE.B (SP)+,D0    ;RESTORE D0
             RTS

OUT2X        ROR.B #4,D0
             BSR.S OUT1X
             ROL.B #4,D0
             BRA OUT1X

        RTS
**************************************************   
   ; INIT ACIA

INIT_ACIA  MOVE.B #3,ACIAC.L   ; RESET ACIA
           MOVE.W #100,D0
           DBRA  D0,*
           MOVE.B #$15,ACIAC.L   ; rts enabled 9600 8ne
           RTS

COUT      BTST.B #TDRE,ACIAC.L
          BEQ.S  COUT
          MOVE.B D0,ACIAD.L
          RTS


CINS      BTST.B #RDRF,ACIA2C.L
          BEQ.S  CINS
          MOVE.B ACIA2D.L,D0
          RTS


CIN      BTST.B #RDRF,ACIAC.L
         BEQ.S  CIN
         MOVE.B ACIAD.L,D0
         BSR COUT
         RTS
         
WOUT      BTST.B #TDRE,ACIA3C.L
          BEQ.S  WRTS1
          MOVE.B D0,ACIA3D.L
WRTS1     RTS
          
WIN      BTST.B #RDRF,ACIA3C.L
         BEQ.S  WRTS2
         MOVE.B ACIA3D.L,D0
         BSR COUT
WRTS2    RTS

WCIN     BTST.B #RDRF,ACIAC.L
         BEQ.S  WRTS3
         MOVE.B ACIAD.L,D0
         BSR WOUT
WRTS3    RTS
         
; A3 POINTED TO FIRST BYTE
; END WITH 0

PSTR     MOVE.B (A3)+,D0
         CMP.B  #0,D0
         BEQ.S PSTR1
         BSR COUT
         BRA.S PSTR

PSTR1    RTS

WSTR     MOVE.B (A3)+,D0
         CMP.B  #0,D0
         BEQ.S WSTR1
WOT      BTST.B #TDRE,ACIA3C.L
         BEQ.S  WOT
         MOVE.B D0,ACIA3D.L
         BRA.S WSTR

WSTR1    RTS

TITLE1 DC.B 13,10,'SPI Loader',13,10,0
WAITING DC.B 13,10,'Loading',13,10,0
RECVD DC.B 13,10,'Byte Received',13,10,0
CHECKING DC.B 13,10,'Checking',13,10,0
BUSYSTR DC.B 13,10,'Busy',13,10,0
            END MAIN

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
