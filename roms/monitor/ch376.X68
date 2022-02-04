*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $B0000
    
CH376_DETECTED        EQU $AA

CH376_CMD_NONE        EQU $00
CH376_GET_IC_VER      EQU $01
CH376_SET_BAUDRATE    EQU $02
CH376_GET_ENTER_SLEEP EQU $03
CH376_RESET_ALL       EQU $05
CH376_CHECK_EXIST     EQU $06
CH376_GET_FILE_SIZE   EQU $0C ; Get the current file length
CH376_SET_USB_MODE    EQU $15
CH376_GET_STATUS      EQU $22
CH376_RD_USB_DATA     EQU $27
CH376_WR_USB_DATA     EQU $2C
CH376_CMD_WR_REQ_DATA EQU $2D
CH376_SET_FILE_NAME   EQU $2F
CH376_DISK_CONNECT    EQU $30 ; check the disk connection status
CH376_DISK_MOUNT      EQU $31
CH376_FILE_OPEN       EQU $32
CH376_FILE_ENUM_GO    EQU $33
CH376_CMD_FILE_CREATE EQU $34
CH376_FILE_ERASE      EQU $35
CH376_FILE_CLOSE      EQU $36
CH376_BYTE_LOCATE     EQU $39
CH376_BYTE_READ       EQU $3A
CH376_BYTE_RD_GO      EQU $3B
CH376_BYTE_WRITE      EQU $3C
CH376_BYTE_WR_GO      EQU $3D
CH376_DISK_CAPACITY   EQU $3E
CH376_DISK_QUERY      EQU $3F
CH376_DIR_CREATE      EQU $40
CH376_DISK_RD_GO      EQU $55

; CODE FOR CH376_SET_USB_MODE 

CH376_SET_USB_MODE_CODE_SDCARD EQU $03
; The code of 06H means switch to valid USB-HOST, produce SOF package automatically. 
CH376_SET_USB_MODE_CODE_USB_HOST EQU $06

CH376_USB_INT_SUCCESS 		EQU $14
CH376_USB_INT_CONNECT 		EQU $15
CH376_USB_INT_DISCONNECT	EQU $16
CH376_USB_INT_BUF_OVER 		EQU $17
CH376_USB_INT_USB_READY 	EQU $18
CH376_USB_INT_DISK_READ 	EQU $1d
CH376_USB_INT_DISK_WRITE 	EQU $1e
CH376_USB_INT_DISK_ERR 		EQU $1f

CH376_ERR_OPEN_DIR          EQU $41
CH376_ERR_MISS_FILE         EQU $42
CH376_ERR_FOUND_NAME 		EQU $43
CH376_ERR_DISK_DISCON 	    EQU $82
CH376_ERR_LARGE_SECTOR 	    EQU $84
CH376_ERR_TYPE_ERROR 		EQU $92
CH376_ERR_BPB_ERROR 		EQU $A1
CH376_ERR_DISK_FULL 		EQU $B1
CH376_ERR_FDT_OVER 	  	    EQU $B2
CH376_ERR_FILE_CLOSE 		EQU $B4

ACIAC    EQU $F00009
ACIAD    EQU ACIAC+2

ACIA2C    EQU $F20009
ACIA2D    EQU ACIA2C+2

INT_ON   EQU  $2000    ; BOTH, SET SUPERVISOR MODE, S=1
INT_OFF  EQU  $2700

RDRF    EQU 0           ; ACIAC Receive Data Register Full
TDRE    EQU 1           ; ACIAC Transmit Data Register Empty

START:                  ; first instruction of program

* Put program code here
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



* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
