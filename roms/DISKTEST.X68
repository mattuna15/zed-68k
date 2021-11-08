ACIAC    EQU $F00009
ACIAD    EQU ACIAC+2

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


SDADDRESS EQU $F40022  ;LONG (32BIT)
SDADDRESS2 EQU $F40024
SDDATA    EQU $F40027  
SDCONTROL EQU $F40021
SDSTATUS  EQU $F40020
SDRAM     EQU $9E0000

VOLOFFSET EQU $01FE
PRTOFFSET EQU $01C6
VOLIND    EQU $55AA

    ORG $8000
  

**************************************************

MAIN 

    ;MOVE.W #INT_OFF,SR 
    ;BSR INIT_ACIA
   
    LEA.L TITLE1.L,A3     ; print START MESSAGE
    BSR PSTR

    ;CHECK SD CARD
    BSR CHECK_DRIVE
    
    ; READ SD CARD 1ST 512 BYTES
    BSR READ_DRV
    
    ; CHECK FOR FAT32 VOLUME
    BSR CHECK_VOL
    
    ;get first clusters
    BSR GETFAT1
    
    ;load root dir
    BSR GETROOTDIR 
    
        jsr $1146

    LEA.L ROMFILE.L, A1
    BSR FINDFILE    ; FIND THE FILE
     
    BSR LOADFILE    ; LOAD THE FILE FIRST CLUSTER

    MOVE.L #$9F0000,0
    MOVE.L #$2000,4

    MOVE.L #$9F0000,SP
        

    JMP $1146

**************************************************     
*data buffer
*9e0000 -> 9e01ff
*
*fat buffer
*9e0200 -> 9e03ff 
*
*root dir buffer
*9e0400 -> 9e05ff
*
*found file details 9e0800
**************************************************

LOADFILE    LEA.L $9E0800,A0

            CLR.L D0
            CLR.L D1
            CLR.L D2
            
            MOVE.L $9E081C,D1
            ROL.W #8,D1
            SWAP     D1
            ROL.W #8,D1       ;GET LITTLE ENDIAN FILE SIZE
            
            MOVE.L D1,D0
            JSR OUT8X
            
            DIVU #$200,D1    ; GET NUM SECTORS
            ADD.L #$1,D1   + 1 (ROUND UP)
            
            MOVE.w $9E081A,D4 ; LOW BYTES
            
            MOVE.L D4,D0
            JSR OUT8X
            
            ROL.W #8,D4       ;GET LITTLE ENDIAN START CLUSTER  
            
            MOVE.L D4,D0
            JSR OUT8X
           
            SUB.L #$2,D4
            MULU  #$40,D4
            ADDi.L   #$2788,D4 ; START ADDRESS
            
            MOVE.L D4,D0
            JSR OUT8X
            
            LEA.L SDADDRESS2,A4
            MOVE.W d4,(a4)
            LEA.L SDADDRESS,A4
            SWAP D4
            MOVE.W d4,(a4)
            SWAP D4
            
            MOVE.L D4,D0
            JSR OUT8X
            
            LEA.L $4000,A3              
            BRA ENDREAD
            
  
READF       BSR READ_DRV
            LEA.L $9E0000,A0
            
            for d5 = #1 to #512 do.s
            MOVE.B (A0)+,(A3)+
            endf
 
            addi #1,D4
            LEA.L SDADDRESS2,A4
            MOVE.W d4,(a4)
            LEA.L SDADDRESS,A4
            SWAP D4
            MOVE.W d4,(a4)
            SWAP D4
            
            
ENDREAD     DBRA D1,READF
            
            RTS
            
**************************************************            

FINDFILE    lea.l $9e0400,A0
            
FILELOOP    jsr STRCMP
            CMP.B #0, D0
            BNE ENDFILE
            MOVE.L A0,D0
            ADDI.L #$10,D0
            MOVEA.L D0,A0
           
            BRA FILELOOP

ENDFILE     LEA.L ROMFND.L,A3
            BSR PSTR
            
            MOVE.L A0,D0
            LEA.L $9e0800,A1
            MOVE.L #$8,D0
            JSR MOVE_l
                 
            CLR.L D0
            BSET.l #0, D0
            RTS

**************************************************  
* GET ROOT DIR
*            
GETROOTDIR     
            MOVE.W #$0000,SDADDRESS
            MOVE.W #$2788,SDADDRESS2
            
            BSR READ_DRV
            
            lea.l $9e0000,A0
            lea.l $9e0400,A1
            move.l #$80,d0
            jsr MOVE_l
            
            MOVE.W #$2789,SDADDRESS2
            BSR READ_DRV
            
            lea.l $9e0000,A0
            lea.l $9e0600,A1
            move.l #$80,d0
            jsr MOVE_l
                 
            RTS
            

**************************************************  
* GET FIRST FAT
*            
GETFAT1     
            MOVE.W #$0000,SDADDRESS
            MOVE.W #$2020,SDADDRESS2
            
            BSR READ_DRV
            
            lea.l $9e0000,A0
            lea.l $9e0200,A1
            move.l #$80,d0
            jsr MOVE_l
                 
            RTS
            
**************************************************  

CHECK_VOL   MOVEM D0-D7/A0-A6,-(SP) ;Push D0-D7/A0-A6 onto the stack

            LEA.L SDRAM.L,A0
            
            MOVE.W VOLOFFSET(A0),D0
            BSR OUT4X
            
            CMP.W #VOLIND,D0
            BEQ.S VOLOK
            
            LEA.L VOLERR.L,A3
            BSR PSTR
            BRA.S ENDVOL

VOLOK       LEA.L VOLSTR.L,A3
            BSR PSTR

ENDVOL      MOVEM (SP)+,D0-D7/A0-A6 ; Restore D0-D7/A0-A6 from the stack         
            
            RTS
    

**************************************************            
CHECK_DRIVE 

            MOVEM D0-D7/A0-A6,-(SP) ;Push D0-D7/A0-A6 onto the stack
            
            LEA.L SDSTATUS.L,A4
            
            MOVE.W (A4), D1
            LSR.W #8, D1  ; GET BYTES 7,6 
            LSR.W #6, D1  ; GET BYTES 7,6 

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
            ;JMP $A00BB4 ;EXIT BACK TO MON
            BRA CHECK_DRIVE ; keep checking
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

            
            MOVEM (SP)+,D0-D7/A0-A6 ; Restore D0-D7/A0-A6 from the stack         
            
RETURN      RTS

**************************************************
** read the data at sdaddress/2 into the buffer at 9e0000

READ_DRV    MOVEM D0-D7/A0-A6,-(SP) ;Push D0-D7/A0-A6 onto the stack
         
         
            MOVE.L SDADDRESS,D0
            JSR OUT8X
            
            MOVE.B  #10,D0
            JSR COUT
            MOVE.B  #13,D0
            JSR COUT
            
BUSY        LEA.L SDSTATUS.L,A4
            MOVE.W (A4), D1
            CMP.W #$C000,D1
            BEQ RDEN               ; busy 0
            
            BRA.S BUSY
            
RDEN        LEA.L SDCONTROL.L,A2
            BSET.b #02, (a2)
            
            LEA.L SDRAM.L, A1
 
            for d5 = #1 to #512 do.s
            
DOUT        MOVE.W (A4), D1
            BTST.L #12,D1
            BEQ DOUT

READ        LEA.l SDDATA.L,A5   
            
            MOVE.B (A5), (A1)+
            BSET.b   #01, (a2)  ;ACK

DAVAIL      MOVE.W (A4), D1
            BTST #12,D1
            BNE DAVAIL
            
            BCLR.b   #01, (a2)  ;ACK
            
            endf

            BCLR.b  #02, (a2)  ; REMOVE RDEN
            

            MOVEM (SP)+,D0-D7/A0-A6 ; Restore D0-D7/A0-A6 from the stack   
            
            RTS

**************************************************   
* PRINTING - numbers

OUT1X      *  JSR $E00F86 
             RTS

OUT2X      *  JSR $E00FA0
             RTS
             
OUT4X      *  JSR $E00FA8
             RTS

OUT6X      *  JSR $E00FB0
             RTS
  
OUT8X      *  JSR $E00FB8
             RTS         
             

        RTS
**************************************************   
* PRINTING - coout/in

INIT_ACIA  MOVE.B #0,ACIAC.L   ; RESET ACIA
*           MOVE.W #100,D0
*           DBRA  D0,*
*           MOVE.B #$15,ACIAC.L   ; rts enabled 9600 8ne
           RTS
           
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
*************
* Print to console or wifi         
; A3 POINTED TO FIRST BYTE
; END WITH 0

PSTR     MOVE.B (A3)+,D0
         CMP.B  #0,D0
         BEQ.S PSTR1
         BSR COUT
         BRA.S PSTR

PSTR1    RTS

***************************************
 * STRLEN - RETURNS LENGTH OP NULL TERMINATED STRING IN D0
 * A0 -> STRING
STRLEN:   MOVE.L A0,-(SP) SAVE REG
          CLR.L  D0       INITIALIZE
STRLENI:  TST.B  (A0)+    NULL?
          BEQ    STRLENR  YES, RETURN
          ADDQ.L #1, D0   BUMP COUNT
          BRA    STRLENI  LOOP
STRLENR:  MOVE.L (SP)+,A0 RESTORE REG
          RTS
  
  * STRCPY - COPY A NULL TERMINATED STRING
  * A0 -> SOURCE STRING
  * A1 -> DESTINATION STRING
STRCPY:   MOVEM.L A0-A1,-(SP) SAVE REGS
STRCPY1:  MOVE.B  (A0)+,(A1)+ MOVE A BYTE
          BNE     STRCPY1     GET ANOTHER IF NOT NULL
          MOVEM.L (SP)+,A0-A1 RESTORE REGS
          RTS

  
  * STRCMP - COMPARE TWO NULL TERMINATED STRINGS
  * A0 -> STRING 1
  * A1 -> STRING 2
STRCMP:   MOVEM.L A0-A1,-(SP)  SAVE REGS
          CLR.L  D0       INITIALIZE
          CLR.L  D1
STRCMP1:  CMPM.B  (A0)+,(A1)+  COMPARE BYTES
          BNE     STRRET       RETURN IF DIFFERENT
          ADD     #1, D1
          
          CMP.L   #11, D1
          BNE     STRCMP1      NOW MORE BYTES LEFT
          
          MOVE.B  #1, D0
          
STRRET:   MOVEM.L (SP)+,A0-A1  RESTORE REGS
          RTS
***************************************

SWAPNUM     ROL.W #8,D0
            SWAP     D0
            ROL.W #8,D0
            
            RTS
    
********
* memory copy
******** 
MOVE_b  
        MOVE.B  (A0)+,(A1)+ ; do the long moves
        DBRA    D0,MOVE_b
        RTS
        
MOVE_w  
        MOVE.W  (A0)+,(A1)+ ; do the long moves
        DBRA    D0,MOVE_w
        RTS  

MOVE_l  
        MOVE.l  (A0)+,(A1)+ ; do the long moves
        DBRA    D0,MOVE_l
        RTS        
**************************************************  
* constants

AT DC.B 13,10,'AT',13,10,0
TITLE1 DC.B 13,10,'Disk Checker',13,10,0
WAITING DC.B 13,10,'Loading',13,10,0
RECVD DC.B 13,10,'Byte Received',13,10,0
CHECKING DC.B 13,10,'Checking',13,10,0
NOCARD DC.B 13,10,'No Card',13,10,0
CARDV1 DC.B 13,10,'Card V1',13,10,0
CARDV2 DC.B 13,10,'Card V2',13,10,0
CARDHC DC.B 13,10,'CARD HC',13,10,0
READING DC.B 13,10,'Reading',13,10,0
BUSYSTR DC.B 13,10,'Busy',13,10,0
VOLSTR DC.B 13,10,'Valid fat32 Volume',13,10,0
VOLERR DC.B 13,10,'No volume found',13,10,0

ROMFILE DC.B 'TICTAC  BAS',0
ROMFND  DC.B 13,10,'ROM File found',13,10,0

       END	MAIN





















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
