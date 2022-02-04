
CR      EQU 13
LF      EQU 10
SP      EQU 32
BS      EQU 8
RS      EQU $1E
ESC     EQU $1B

SUPER_STACK   EQU $00E000   ; SUPER STACK TOP Address
RAMBASE_INIT  EQU $00E000

DATA_TX EQU $F40041
DATA_RX EQU $F40043
DATA_CTL EQU $F40045
DATA_TX_SPACE EQU $F40046
DATA_RX_COUNT EQU $F40048

* TCP0_TxValid    => eth_ctl(6), --Transmit data valid
*        TCP0_TxReady    => eth_ctl(3), --Transmit data ready
*        TCP0_RxValid    => eth_ctl(2), --Receive data valid
*        TCP0_RxReady    => eth_ctl(5)  --Receive data ready

TXVL EQU 6
TXRDY EQU 3
RXVLD EQU 2
RXRDY EQU 5


    ORG $E40000
**************************************************

MAIN 

    ;BSR INIT_ACIA
   
    LEA.L TITLE1.L,A3     ; print START MESSAGE
    BSR PSTR
    BSR PSTR

         

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
           

COUT      BTST.B #TXRDY,DATA_CTL.L
          BEQ.S  COUT
          
          MOVE.B D0,DATA_TX.L 
          BSET.B #TXVL,DATA_CTL.L
          BCLR.B #TXVL,DATA_CTL.L 
          RTS

CIN      BTST.B #RXVLD,DATA_CTL.L
         BEQ.S  CIN

         BSET.B #RXRDY,DATA_CTL.L
         MOVE.B DATA_RX.L,D0
         BCLR.B #RXRDY,DATA_CTL.L
         
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



AT DC.B 13,10,'AT',13,10,0
TITLE1 DC.B 13,10,'Terminal',13,10,0
WAITING DC.B 13,10,'Loading',13,10,0
RECVD DC.B 13,10,'Byte Received',13,10,0
CHECKING DC.B 13,10,'Checking',13,10,0
NOCARD DC.B 13,10,'No Card',13,10,0
CARDV1 DC.B 13,10,'Card V1',13,10,0
CARDV2 DC.B 13,10,'Card V2',13,10,0
CARDHC DC.B 13,10,'CARD HC',13,10,0
READING DC.B 13,10,'Reading',13,10,0
BUSYSTR DC.B 13,10,'Busy',13,10,0
FULLSTOP DC.B '.',0

            END MAIN



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
