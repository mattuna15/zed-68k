*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    
MON     EQU $A00BB4
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

   ORG $C0
RAMBASE  DS.L   1          ; RAM BASE ADDRESS

    ORG $2000
   ; Reset start vector
   DC.L SUPER_STACK        ; TOP OF SUPERVISOR STACK $130000
   DC.L MAIN               ; MONITOR START
  
 

MAIN MOVE.W #INT_OFF,SR 
     BSR INIT_ACIA
   
    LEA.L TITLE1.L,A3     ; print START MESSAGE
    BSR PSTR

         
VBLK:    ;CHECK FOR NON-ZERO IN VBLANK
         LEA.L WAITING.L,A3     ; print START MESSAGE
         BSR PSTR
         
         CMPi.W #$0000, $C05006 
         BEQ VBLK
         
VBLK2:  
         LEA.L WAITING0.L,A3     ; print START MESSAGE
         BSR PSTR
         CMPi.W #$0000, $C05006 
         BNE VBLK2
         
         JMP MON.l
* Put variables and constants here

   
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


TITLE1 DC.B 13,10,'Blank tester',13,10,0
WAITING DC.B 13,10,'waiting for 1',13,10,0
WAITING0 DC.B 13,10,'waiting for 0',13,10,0 


    END    MAIN        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
