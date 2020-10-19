ACIAC    EQU $F00009
ACIAD    EQU ACIAC+2

ACIA2C    EQU $F20009
ACIA2D    EQU ACIA2C+2

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

   ORG $C0
RAMBASE  DS.L   1          ; RAM BASE ADDRESS

    ORG $2000
   ; Reset start vector
   DC.L SUPER_STACK        ; TOP OF SUPERVISOR STACK $130000
   DC.L MAIN               ; MONITOR START

**************************************************

MAIN 

    MOVE.W #INT_OFF,SR 
    BSR INIT_ACIA
   
    LEA.L TITLE1.L,A3     ; print START MESSAGE
    BSR PSTR

    ;LOAD FONT
    BSR SETUP_FONT  
    
    ;CHECK SD CARD
    BSR CHECK_DRIVE
    
    LEA.L SDADDRESS.L,A1
    MOVE.l #00, (a1) 
    BSR READDRV
    
    LEA.L SDADDRESS.L,A1
    MOVE.l #2048, (a1) 
    BSR READDRV
    
**************************************************
   
SETUP_FONT    
              
              LEA.L WAITING.L,A3     ; print START MESSAGE
              BSR PSTR
    
              LEA.L FONT,A5
              LEA.L $C01000,A6
              for d5 = #1 to #768 do.s
                    MOVE.B  (a5)+, (a6)+
              endf
              
              RTS

**************************************************            
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
         
; A3 POINTED TO FIRST BYTE
; END WITH 0

PSTR     MOVE.B (A3)+,D0
         CMP.B  #0,D0
         BEQ.S PSTR1
         BSR COUT
         BRA.S PSTR

PSTR1    RTS


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

FONT    dc.b $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $18,  $18,  $18,  $18,  $18,  $00,  $18,  $00 
        dc.b $6c,  $6c,  $6c,  $00,  $00,  $00,  $00,  $00,  $36,  $36,  $7f,  $36,  $7f,  $36,  $36,  $00 
        dc.b $0c,  $3f,  $68,  $3e,  $0b,  $7e,  $18,  $00,  $60,  $66,  $0c,  $18,  $30,  $66,  $06,  $00 
        dc.b $38,  $6c,  $6c,  $38,  $6d,  $66,  $3b,  $00,  $0c,  $18,  $30,  $00,  $00,  $00,  $00,  $00 
        dc.b $0c,  $18,  $30,  $30,  $30,  $18,  $0c,  $00,  $30,  $18,  $0c,  $0c,  $0c,  $18,  $30,  $00 
        dc.b $00,  $18,  $7e,  $3c,  $7e,  $18,  $00,  $00,  $00,  $18,  $18,  $7e,  $18,  $18,  $00,  $00 
        dc.b $00,  $00,  $00,  $00,  $00,  $18,  $18,  $30,  $00,  $00,  $00,  $7e,  $00,  $00,  $00,  $00 
        dc.b $00,  $00,  $00,  $00,  $00,  $18,  $18,  $00,  $00,  $06,  $0c,  $18,  $30,  $60,  $00,  $00 
        dc.b $3c,  $66,  $6e,  $7e,  $76,  $66,  $3c,  $00,  $18,  $38,  $18,  $18,  $18,  $18,  $7e,  $00 
        dc.b $3c,  $66,  $06,  $0c,  $18,  $30,  $7e,  $00,  $3c,  $66,  $06,  $1c,  $06,  $66,  $3c,  $00 
        dc.b $0c,  $1c,  $3c,  $6c,  $7e,  $0c,  $0c,  $00,  $7e,  $60,  $7c,  $06,  $06,  $66,  $3c,  $00 
        dc.b $1c,  $30,  $60,  $7c,  $66,  $66,  $3c,  $00,  $7e,  $06,  $0c,  $18,  $30,  $30,  $30,  $00 
        dc.b $3c,  $66,  $66,  $3c,  $66,  $66,  $3c,  $00,  $3c,  $66,  $66,  $3e,  $06,  $0c,  $38,  $00 
        dc.b $00,  $00,  $18,  $18,  $00,  $18,  $18,  $00,  $00,  $00,  $18,  $18,  $00,  $18,  $18,  $30 
        dc.b $0c,  $18,  $30,  $60,  $30,  $18,  $0c,  $00,  $00,  $00,  $7e,  $00,  $7e,  $00,  $00,  $00 
        dc.b $30,  $18,  $0c,  $06,  $0c,  $18,  $30,  $00,  $3c,  $66,  $0c,  $18,  $18,  $00,  $18,  $00 
        dc.b $3c,  $66,  $6e,  $6a,  $6e,  $60,  $3c,  $00,  $3c,  $66,  $66,  $7e,  $66,  $66,  $66,  $00 
        dc.b $7c,  $66,  $66,  $7c,  $66,  $66,  $7c,  $00,  $3c,  $66,  $60,  $60,  $60,  $66,  $3c,  $00 
        dc.b $78,  $6c,  $66,  $66,  $66,  $6c,  $78,  $00,  $7e,  $60,  $60,  $7c,  $60,  $60,  $7e,  $00 
        dc.b $7e,  $60,  $60,  $7c,  $60,  $60,  $60,  $00,  $3c,  $66,  $60,  $6e,  $66,  $66,  $3c,  $00 
        dc.b $66,  $66,  $66,  $7e,  $66,  $66,  $66,  $00,  $7e,  $18,  $18,  $18,  $18,  $18,  $7e,  $00 
        dc.b $3e,  $0c,  $0c,  $0c,  $0c,  $6c,  $38,  $00,  $66,  $6c,  $78,  $70,  $78,  $6c,  $66,  $00 
        dc.b $60,  $60,  $60,  $60,  $60,  $60,  $7e,  $00,  $63,  $77,  $7f,  $6b,  $6b,  $63,  $63,  $00 
        dc.b $66,  $66,  $76,  $7e,  $6e,  $66,  $66,  $00,  $3c,  $66,  $66,  $66,  $66,  $66,  $3c,  $00 
        dc.b $7c,  $66,  $66,  $7c,  $60,  $60,  $60,  $00,  $3c,  $66,  $66,  $66,  $6a,  $6c,  $36,  $00 
        dc.b $7c,  $66,  $66,  $7c,  $6c,  $66,  $66,  $00,  $3c,  $66,  $60,  $3c,  $06,  $66,  $3c,  $00 
        dc.b $7e,  $18,  $18,  $18,  $18,  $18,  $18,  $00,  $66,  $66,  $66,  $66,  $66,  $66,  $3c,  $00 
        dc.b $66,  $66,  $66,  $66,  $66,  $3c,  $18,  $00,  $63,  $63,  $6b,  $6b,  $7f,  $77,  $63,  $00 
        dc.b $66,  $66,  $3c,  $18,  $3c,  $66,  $66,  $00,  $66,  $66,  $66,  $3c,  $18,  $18,  $18,  $00 
        dc.b $7e,  $06,  $0c,  $18,  $30,  $60,  $7e,  $00,  $7c,  $60,  $60,  $60,  $60,  $60,  $7c,  $00 
        dc.b $00,  $60,  $30,  $18,  $0c,  $06,  $00,  $00,  $3e,  $06,  $06,  $06,  $06,  $06,  $3e,  $00 
        dc.b $18,  $3c,  $66,  $42,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $ff 
        dc.b $1c,  $36,  $30,  $7c,  $30,  $30,  $7e,  $00,  $00,  $00,  $3c,  $06,  $3e,  $66,  $3e,  $00 
        dc.b $60,  $60,  $7c,  $66,  $66,  $66,  $7c,  $00,  $00,  $00,  $3c,  $66,  $60,  $66,  $3c,  $00 
        dc.b $06,  $06,  $3e,  $66,  $66,  $66,  $3e,  $00,  $00,  $00,  $3c,  $66,  $7e,  $60,  $3c,  $00 
        dc.b $1c,  $30,  $30,  $7c,  $30,  $30,  $30,  $00,  $00,  $00,  $3e,  $66,  $66,  $3e,  $06,  $3c 
        dc.b $60,  $60,  $7c,  $66,  $66,  $66,  $66,  $00,  $18,  $00,  $38,  $18,  $18,  $18,  $3c,  $00 
        dc.b $18,  $00,  $38,  $18,  $18,  $18,  $18,  $70,  $60,  $60,  $66,  $6c,  $78,  $6c,  $66,  $00 
        dc.b $38,  $18,  $18,  $18,  $18,  $18,  $3c,  $00,  $00,  $00,  $36,  $7f,  $6b,  $6b,  $63,  $00 
        dc.b $00,  $00,  $7c,  $66,  $66,  $66,  $66,  $00,  $00,  $00,  $3c,  $66,  $66,  $66,  $3c,  $00 
        dc.b $00,  $00,  $7c,  $66,  $66,  $7c,  $60,  $60,  $00,  $00,  $3e,  $66,  $66,  $3e,  $06,  $07 
        dc.b $00,  $00,  $6c,  $76,  $60,  $60,  $60,  $00,  $00,  $00,  $3e,  $60,  $3c,  $06,  $7c,  $00 
        dc.b $30,  $30,  $7c,  $30,  $30,  $30,  $1c,  $00,  $00,  $00,  $66,  $66,  $66,  $66,  $3e,  $00 
        dc.b $00,  $00,  $66,  $66,  $66,  $3c,  $18,  $00,  $00,  $00,  $63,  $6b,  $6b,  $7f,  $36,  $00 
        dc.b $00,  $00,  $66,  $3c,  $18,  $3c,  $66,  $00,  $00,  $00,  $66,  $66,  $66,  $3e,  $06,  $3c 
        dc.b $00,  $00,  $7e,  $0c,  $18,  $30,  $7e,  $00,  $0c,  $18,  $18,  $70,  $18,  $18,  $0c,  $00 
        dc.b $18,  $18,  $18,  $00,  $18,  $18,  $18,  $00,  $30,  $18,  $18,  $0e,  $18,  $18,  $30,  $00 
        dc.b $31,  $6b,  $46,  $00,  $00,  $00,  $00,  $00,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff



       END	MAIN
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
