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

SUPER_STACK   EQU $00E000   ; SUPER STACK TOP Address
RAMBASE_INIT  EQU $00E000

*-- sdControl f4000a
*-- 0 - din valid (a)
*-- 1 - dout ack (a)
* 2 - rden
* 3 - wren
*-- sdstatus f40009
*-- 0 error
*-- 1,2,3 - Error code
*-- 4 - dout valid
*-- 5 - Busy
*-- 6,7 - card TYPE

*-- sd_type:
*-- 00 No card
*-- 01 SD V1
*-- 10 SD V2
*-- 11 SDHC


SDADDRESS EQU $F40000  ;LONG (32BIT)
SDDATA    EQU $F4000d  
SDCONTROL EQU $F4000b
SDSTATUS  EQU $F40009

    ORG $2000
**************************************************

MAIN 

    MOVE.W #INT_OFF,SR 
    BSR INIT_ACIA
   
    LEA.L TITLE1.L,A3     ; print START MESSAGE
    BSR PSTR

    lea AT.l,a3
    bsr wstr
    
LOOP
    BSR WIN
   
    BSR WCIN
    
    BRA LOOP
    
        
CHECK_DRIVE   
            LEA.L CHECKING.L,A3     ; print START MESSAGE
            BSR PSTR
            
            LEA.L SDSTATUS.L,A4
            
            MOVE.b (A4), D1
            LSR.B #$06, D1  ; GET BYTES 7,6 

            CMP.B #$00,D1
            BEQ NO_CARD
            
            CMP.B #$01,D1
            BEQ CARD_V1
            
            CMP.B #$02,D1
            BEQ CARD_V2

            CMP.B #$03,D1
            BEQ CARD_HC   

NO_CARD     
            LEA.L NOCARD.L,A3     ; print START MESSAGE
            BSR PSTR 
            JMP $A00BB4 ;EXIT BACK TO MON
            ;BRA RETURN
CARD_V1
            LEA.L CARDV1.L,A3     ; print START MESSAGE
            BSR PSTR 
            BRA RETURN
CARD_V2
            LEA.L CARDV2.L,A3     ; print START MESSAGE
            BSR PSTR 
            BRA RETURN

CARD_HC     LEA.L CARDHC.L,A3     ; print START MESSAGE
            BSR PSTR        
            
RETURN      RTS

**************************************************


READDRV     

            LEA.L READING.L, A3     ; print START MESSAGE
            BSR PSTR  
            
            
BUSY        LEA.L SDSTATUS.L,A4
            MOVE.b (A4), D1
            CMP.b #$c0,D1
            BEQ RDEN               ; busy 0
            
            LEA.L BUSYSTR.L,A3     ; print START MESSAGE
            BSR PSTR 
            
            BRA.S BUSY
            
RDEN        LEA.L SDCONTROL.L,A2
            BSET.b #02, (a2)
 
            for d5 = #1 to #512 do.s
            
            LEA.L CHECKING.L,A3     ; print START MESSAGE
            BSR PSTR
            
DOUT        MOVE.b (A4), D1
            BTST #4,D1
            BEQ DOUT

READ        LEA.l SDDATA.L,A5   
            
            MOVE.b (A5), D0
            BSET.b   #01, (a2)  ;ACK
            BSR OUT2X
DAVAIL      MOVE.b (A4), D1
            BTST #4,D1
            BNE DAVAIL
            
            BCLR.b   #01, (a2)  ;ACK
            
            endf

            BCLR.b  #02, (a2)  ; REMOVE RDEN
            
            RTS

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

AT DC.B 13,10,'AT',13,10,0
TITLE1 DC.B 13,10,'Font Loader',13,10,0
WAITING DC.B 13,10,'Loading',13,10,0
RECVD DC.B 13,10,'Byte Received',13,10,0
CHECKING DC.B 13,10,'Checking',13,10,0
NOCARD DC.B 13,10,'No Card',13,10,0
CARDV1 DC.B 13,10,'Card V1',13,10,0
CARDV2 DC.B 13,10,'Card V2',13,10,0
CARDHC DC.B 13,10,'CARD HC',13,10,0
READING DC.B 13,10,'Reading',13,10,0
BUSYSTR DC.B 13,10,'Busy',13,10,0
            END MAIN

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
