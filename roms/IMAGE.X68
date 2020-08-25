; REGISTERS

SPRCONTROL EQU $C06000 
J1RESET    EQU $C05012
SPRDISABLE EQU $C05014
SCROLLX    EQU $C05008
SCROLLY    EQU $C0500C
FRAMECOUNT EQU $C05004

;spr_num d0, x d1, y d2, data d7

; DIMENSIONS

LWALL equ 0
RWALL equ $180
TWALL equ 0
BWALL equ $11C

XMIN equ 0
XMAX EQU $180
YMIN EQU 0
YMAX EQU $12C


SUPER_STACK   EQU $00E000   ; SUPER STACK TOP Address
RAMBASE_INIT  EQU $00E000

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

         JSR SETUP               ; LOAD AND PLOT START POSITIONS
MOVESP:  JSR MOVESPR
    
         ;CHECK FOR NON-ZERO IN VBLANK
         
         JSR WAITVBLANK
         JSR WAITVBLANK
         
         BRA MOVESP
    
          
SETUP:

    LEA.L SETUPS.L,A3     ; print START MESSAGE
    BSR PSTR

    MOVE.W #$00, SPRDISABLE
    MOVE.W #$00, SCROLLY
    MOVE.W #$00, SCROLLX
    MOVE.W #$01, J1RESET
    lea.l SPRCONTROL, a0
   
    move.b #$00, d0  
    MOVE.W #$00, d4 ;spr
    
    LEA.L  SPRX,A2
    LEA.L  SPRY,A3
    LEA.L  SPRVX,A4
    LEA.L  SPRVY,A5   
    
    for d4 = #0 to #5 do.s

        ;Y
        MOVE.W #YMIN, D5
        MOVE.W #YMAX, D6
        JSR RAND_GEN
        MOVE.W D1,D2
        MOVE.W D2,(A3)+
        
        ;X
        MOVE.W #XMIN, D5
        MOVE.W #XMAX, D6
        JSR RAND_GEN
        MOVE.W D1, D1
        MOVE.W D4,(A2)+
        
        MOVE.W #16, (A4)+ ; VELOCITY X
        MOVE.W #16, (A5)+ ; VELOCITY Y

        jsr PLOT   
        add #8, a0
    endf

    RTS
    
WAITVBLANK

         CMPi.W #$0001, $C05006 
         BEQ WAITVBLANK
         
WAITZERO 
         CMPi.W #$000, $C05006 
         BEQ WAITZERO
    
         RTS
    
    
MOVESPR

    lea.l SPRCONTROL, a0
   
    move.b #$00, d0  
    MOVE.W #$00, d4 ;spr
    
    LEA.L  SPRX,A2
    LEA.L  SPRY,A3
    LEA.L  SPRVX,A4
    LEA.L  SPRVY,A5  
    
    for d4 = #0 to #5 do.s

        ;X
        CMPI.W #LWALL, (A2)
        BPL.S CHECKR

        NEG.L (A4)
        BRA   SETX
        
CHECKR: 
        CMPI.W #RWALL, (A2)
        BLE.S SETX
        NEG.L (A4)
        
SETX:   MOVE.W (A2) , D1
        ADD.W  (A4)+, D1
        MOVE.W D1, (A2)+
        
        ;Y

        CMPI.W #TWALL, (A3)
        BPL.S CHECKB

        NEG.L (A5)
        BRA   SETY 
        
CHECKB: 
        CMPI.W #BWALL, (A3)
        BLE.S SETY
        NEG.L (A5)
        
SETY:   MOVE.W (A3), D2
        ADD.W  (A5)+, D2
        MOVE.W D2, (A3)+

        jsr PLOT   
        add #8, a0
    endf

    RTS
    
PLOT:                    
                      
    MOVE.l #$00, d7
    move.w d4,d7
    
    lsl.l #$08,   d7
    lsl.l #$01,   d7
    add.w d2,   d7
    swap d7    
    move.w d1,   d7         ; x 0-8
    bset.l #$1f, d7         ; collision bit31
    
    ROL.W #8,D7
    SWAP     D7
    ROL.W #8,D7
    MOVEP.L D7, 1(A0)
    
    rts

RAND_GEN
    SUB     D5,D6             ;You should give Min in D5 and Max in D6
    MOVE    D6,D7
    ADDI     #1,D6
    MULU    #$FFFF,D7
    LEA.L   FRAMECOUNT,A1 ;FRAMECOUNT AS SEED
    ADD     (A1),D1
    MULU    #$FFFF,D1
    EOR.L   #$F321F23A,D1
    MOVE    D1,(A1)
    AND.L   D7,D1    ;PREVENT OVERFLOW FOR (Max-Min)
    DIVU    D6,D1         ;time count / (Max-Min)
    SWAP    D1              ;swap upper and lower words of D1 to put remainder in low word
    ADD     D5,d1           ;D1.W contains number in the range of (Min,Max)
    RTS
    
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

* Put variables and constants here
TITLE1 DC.B 13,10,'Blank tester',13,10,0
WAITING DC.B 13,10,'waiting for 1',13,10,0
WAITING0 DC.B 13,10,'waiting for 0',13,10,0 
SETUPS DC.B 13,10,'setup',13,10,0 
PLOTS DC.B 13,10,'plot',13,10,0 
MOVES DC.B 13,10,'MOVE SPRITE',13,10,0 


    ORG $3000
SPRX    DC.W $0
    
    ORG $3200
SPRY    DC.W $0

    ORG $3400
SPRVX    DC.W $0
    
    ORG $3600
SPRVY    DC.W $0


SPRPAL
    ORG $C07000
    DC.W $ff,  $7f,  $bd,  $77,  $9c,  $73,  $5a,  $6b,  $31,  $7f,  $24,  $7b,  $10,  $7f,  $ef,  $7e 
	DC.W $cf,  $7e,  $ce,  $7e,  $cc,  $7a,  $e3,  $76,  $ab,  $76,  $8b,  $76,  $a3,  $6e,  $83,  $6a 
	DC.W $6b,  $72,  $6a,  $6e,  $4a,  $6e,  $2a,  $6a,  $18,  $63,  $d6,  $5a,  $e0,  $03,  $80,  $03 
	DC.W $40,  $03,  $20,  $03,  $e0,  $02,  $b5,  $56,  $73,  $4e,  $42,  $62,  $09,  $66,  $02,  $5e 
	DC.W $31,  $46,  $33,  $26,  $a0,  $02,  $80,  $02,  $40,  $02,  $20,  $02,  $e9,  $65,  $e9,  $61 
	DC.W $c9,  $5d,  $a8,  $5d,  $88,  $59,  $e2,  $55,  $a2,  $51,  $ef,  $3d,  $79,  $7c,  $ce,  $39 
	DC.W $8c,  $31,  $f2,  $21,  $4a,  $29,  $08,  $21,  $e0,  $01,  $d1,  $1d,  $90,  $19,  $a0,  $01 
	DC.W $80,  $01,  $4e,  $15,  $2d,  $15,  $40,  $01,  $e7,  $1c,  $ec,  $10,  $ab,  $0c,  $e0,  $00 
	DC.W $85,  $00,  $00,  $7c,  $00,  $78,  $00,  $70,  $00,  $6c,  $00,  $64,  $00,  $60,  $00,  $58 
	DC.W $00,  $54,  $00,  $4c,  $00,  $48,  $00,  $40,  $00,  $3c,  $00,  $30,  $00,  $2c,  $1f,  $00 
	DC.W $1c,  $00,  $17,  $00,  $16,  $00,  $0f,  $00,  $0c,  $00,  $08,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	DC.W $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $80
    
SPRIMG
    ORG $C08000
    DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $49,  $46,  $02,  $41,  $43,  $45,  $46,  $49,  $4c,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $53,  $52,  $50,  $4f,  $50,  $52,  $53,  $55,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $53,  $52,  $02,  $4f,  $4f,  $4f,  $50,  $52,  $53,  $55,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $53,  $52,  $50,  $4f,  $4f,  $4f,  $50,  $52,  $53,  $55,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $53,  $2a,  $26,  $10,  $26,  $2a,  $53,  $55,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $53,  $2a,  $26,  $2a,  $53,  $55,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $53,  $2a,  $53,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $53,  $52,  $53,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $53,  $52,  $50,  $52,  $53,  $55,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $53,  $52,  $50,  $2a,  $50,  $52,  $53,  $55,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $53,  $52,  $02,  $2a,  $26,  $26,  $50,  $52,  $53,  $55,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $53,  $52,  $2a,  $26,  $10,  $26,  $26,  $52,  $53,  $55,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $53,  $2a,  $10,  $10,  $26,  $2a,  $53,  $55,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $49,  $46,  $02,  $41,  $43,  $45,  $46,  $49,  $4c,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2d,  $02,  $14,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2d,  $14,  $2d,  $30,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2d,  $1c,  $02,  $14,  $32,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $30,  $2f,  $1b,  $00,  $02,  $2d,  $32,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $32,  $2f,  $1c,  $1b,  $00,  $14,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $32,  $30,  $2f,  $1c,  $1b,  $15,  $20,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $33,  $32,  $30,  $2f,  $2d,  $20,  $30,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $28,  $13,  $10,  $0a,  $10,  $13,  $28,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $29,  $13,  $04,  $0a,  $10,  $13,  $29,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $10,  $0a,  $10,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $11,  $10,  $11,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $12,  $04,  $12,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $13,  $10,  $13,  $29,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $12,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $13,  $29,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $ff,  $ff,  $3f,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $34,  $ff,  $34,  $ff,  $34,  $3f 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $17,  $3f,  $34,  $3f,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4e,  $4c,  $49,  $49,  $4c,  $4d,  $34,  $3f,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $47,  $44,  $42,  $43,  $46,  $49,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $47,  $43,  $42,  $41,  $41,  $42,  $46,  $49,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4c,  $47,  $43,  $02,  $41,  $41,  $42,  $46,  $49,  $4b,  $4d,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $47,  $43,  $42,  $41,  $41,  $42,  $44,  $46,  $49,  $4b,  $4d,  $ff 
	DC.W $ff,  $ff,  $ff,  $4c,  $47,  $43,  $41,  $41,  $42,  $43,  $46,  $49,  $4b,  $4c,  $4e,  $ff 
	DC.W $ff,  $ff,  $4d,  $47,  $43,  $42,  $41,  $42,  $43,  $46,  $49,  $4b,  $4c,  $4d,  $4e,  $ff 
	DC.W $ff,  $ff,  $4c,  $47,  $43,  $41,  $42,  $43,  $46,  $49,  $4b,  $4c,  $4d,  $4e,  $ff,  $ff 
	DC.W $ff,  $4c,  $47,  $42,  $41,  $42,  $43,  $46,  $49,  $4b,  $4c,  $4d,  $4e,  $ff,  $ff,  $ff 
	DC.W $4c,  $47,  $42,  $41,  $43,  $46,  $49,  $4b,  $4c,  $4d,  $4e,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $47,  $41,  $43,  $46,  $49,  $4b,  $4c,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $29,  $26,  $26,  $26,  $26,  $26,  $29,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $29,  $13,  $10,  $0a,  $0a,  $0a,  $10,  $13,  $29,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $29,  $13,  $10,  $0a,  $04,  $04,  $07,  $07,  $0a,  $0a,  $10,  $13,  $29,  $ff,  $ff 
	DC.W $ff,  $26,  $10,  $0a,  $04,  $07,  $07,  $0a,  $0a,  $0a,  $0a,  $0a,  $10,  $26,  $ff,  $ff 
	DC.W $ff,  $29,  $13,  $10,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $10,  $13,  $29,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $29,  $2a,  $2a,  $2a,  $2a,  $2a,  $2a,  $2a,  $29,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $2a,  $2a,  $27,  $29,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $2a,  $27,  $13,  $29,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $12,  $0a,  $10,  $29,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $0c,  $04,  $0c,  $13,  $29,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $0c,  $07,  $0a,  $10,  $29,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $13,  $0a,  $0c,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $13,  $13,  $29,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $17,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $17,  $34,  $ff,  $34,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $34,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $4d,  $4a,  $48,  $4d,  $3f,  $4d,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $4a,  $43,  $41,  $43,  $46,  $49,  $46,  $48,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $48,  $43,  $02,  $02,  $41,  $43,  $43,  $41,  $41,  $48,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $46,  $02,  $02,  $41,  $41,  $41,  $41,  $41,  $41,  $43,  $48,  $ff,  $ff 
	DC.W $ff,  $ff,  $4a,  $46,  $41,  $41,  $41,  $41,  $41,  $41,  $41,  $41,  $41,  $46,  $ff,  $ff 
	DC.W $ff,  $ff,  $4a,  $46,  $02,  $41,  $41,  $41,  $41,  $41,  $41,  $41,  $41,  $48,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $49,  $43,  $41,  $41,  $41,  $41,  $41,  $41,  $41,  $46,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4c,  $46,  $41,  $41,  $41,  $41,  $41,  $41,  $46,  $48,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $49,  $46,  $41,  $41,  $46,  $41,  $46,  $48,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $4a,  $46,  $46,  $49,  $46,  $48,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $49,  $49,  $4d,  $ff,  $4d,  $49,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $49,  $43,  $43,  $49,  $4d,  $49,  $43,  $43,  $49,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $49,  $43,  $41,  $02,  $43,  $49,  $43,  $02,  $02,  $43,  $49,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $43,  $41,  $41,  $41,  $41,  $43,  $41,  $41,  $41,  $41,  $43,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $49,  $43,  $41,  $41,  $41,  $41,  $41,  $41,  $41,  $43,  $49,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $49,  $43,  $41,  $41,  $41,  $41,  $41,  $43,  $49,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $49,  $43,  $41,  $41,  $41,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $43,  $41,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $14,  $1b,  $1b,  $43,  $43,  $49,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $14,  $1b,  $1b,  $1b,  $2d,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $17,  $22,  $22,  $24,  $37,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $17,  $22,  $22,  $24,  $37,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $17,  $22,  $22,  $24,  $37,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $17,  $22,  $22,  $24,  $37,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $17,  $22,  $22,  $24,  $37,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $17,  $22,  $22,  $24,  $37,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $17,  $22,  $22,  $24,  $37,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $17,  $22,  $22,  $24,  $37,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $17,  $22,  $22,  $24,  $37,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $2a,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $53,  $50,  $53,  $50,  $50,  $55,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $53,  $50,  $53,  $55,  $ff,  $50,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $53,  $51,  $50,  $51,  $53,  $50,  $55,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $53,  $51,  $02,  $4f,  $50,  $51,  $53,  $55,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $53,  $51,  $50,  $4f,  $4f,  $4f,  $50,  $51,  $53,  $55,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $53,  $51,  $02,  $4f,  $4f,  $4f,  $50,  $51,  $53,  $55,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $53,  $51,  $02,  $4f,  $4f,  $4f,  $50,  $51,  $53,  $55,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $53,  $51,  $50,  $4f,  $4f,  $4f,  $50,  $51,  $53,  $55,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $53,  $51,  $02,  $4f,  $4f,  $4f,  $50,  $51,  $53,  $55,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $53,  $51,  $50,  $4f,  $4f,  $4f,  $50,  $51,  $53,  $55,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $53,  $51,  $50,  $4f,  $50,  $51,  $53,  $55,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $02,  $1b,  $2d,  $2f,  $32,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $41,  $44,  $44,  $47,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $41,  $44,  $44,  $15,  $15,  $32,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $41,  $44,  $15,  $00,  $15,  $32,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $41,  $44,  $00,  $02,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $41,  $44,  $00,  $47,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $41,  $00,  $02,  $47,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $32,  $15,  $00,  $02,  $15,  $47,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $32,  $15,  $02,  $15,  $44,  $47,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $41,  $44,  $44,  $47,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $02,  $1b,  $2d,  $2f,  $32,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $4d,  $49,  $49,  $3f,  $23,  $34,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $3f,  $34,  $3f,  $43,  $41,  $43,  $3f,  $3f,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $4d,  $3f,  $34,  $3f,  $41,  $41,  $3f,  $41,  $43,  $43,  $49,  $3f,  $4d,  $ff,  $ff 
	DC.W $4d,  $49,  $43,  $3f,  $41,  $41,  $3f,  $34,  $3f,  $41,  $41,  $3f,  $34,  $3f,  $4d,  $ff 
	DC.W $49,  $3f,  $3f,  $43,  $41,  $3f,  $34,  $23,  $34,  $3f,  $41,  $3f,  $23,  $34,  $3f,  $ff 
	DC.W $3f,  $34,  $23,  $3f,  $43,  $41,  $3f,  $3f,  $3f,  $41,  $43,  $43,  $3f,  $3f,  $4c,  $ff 
	DC.W $4d,  $3f,  $34,  $3f,  $49,  $43,  $41,  $41,  $41,  $41,  $41,  $43,  $49,  $49,  $4d,  $ff 
	DC.W $ff,  $4d,  $4c,  $4c,  $4c,  $4c,  $4c,  $4c,  $4c,  $4c,  $4c,  $4c,  $4c,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $10,  $08,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $10,  $04,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $10,  $07,  $04,  $07,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $49,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4c,  $45,  $49,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4c,  $49,  $43,  $43,  $49,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4c,  $4a,  $49,  $45,  $49,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4c,  $49,  $4c,  $4a,  $4a,  $4c,  $49,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $45,  $43,  $49,  $4c,  $4c,  $45,  $49,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $49,  $43,  $49,  $4c,  $49,  $43,  $45,  $49,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $49,  $45,  $43,  $45,  $49,  $4c,  $49,  $4c,  $4c,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4c,  $43,  $49,  $45,  $49,  $4c,  $4c,  $45,  $49,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $49,  $4c,  $4c,  $4c,  $4a,  $4c,  $4a,  $43,  $49,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $49,  $45,  $49,  $4c,  $49,  $45,  $4a,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $02,  $2d,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2d,  $02,  $02,  $2d,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2d,  $02,  $2d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $13,  $28,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $28,  $13,  $13,  $28,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $13,  $13,  $28,  $28,  $2a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $13,  $26,  $28,  $2a,  $2a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $2a,  $13,  $10,  $13,  $28,  $2a,  $2a,  $2a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $13,  $10,  $04,  $13,  $28,  $2a,  $2a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $2a,  $13,  $13,  $10,  $13,  $26,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $13,  $28,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $10,  $4d,  $4d,  $4d,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $04,  $10,  $49,  $43,  $04,  $10,  $43,  $49,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $4d,  $49,  $49,  $43,  $10,  $49,  $49,  $10,  $43,  $49,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $2a,  $26,  $26,  $2a,  $4d,  $49,  $10,  $10,  $43,  $49,  $43,  $4d,  $ff 
	DC.W $ff,  $ff,  $2a,  $26,  $26,  $26,  $26,  $2a,  $4d,  $49,  $43,  $49,  $49,  $49,  $4d,  $ff 
	DC.W $ff,  $2a,  $26,  $26,  $2a,  $26,  $26,  $26,  $2a,  $4d,  $49,  $49,  $43,  $49,  $4d,  $ff 
	DC.W $ff,  $2a,  $26,  $2a,  $02,  $2d,  $26,  $26,  $2a,  $4d,  $49,  $43,  $49,  $4d,  $ff,  $ff 
	DC.W $ff,  $2a,  $26,  $26,  $2a,  $26,  $26,  $26,  $2a,  $4d,  $43,  $49,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $26,  $26,  $26,  $26,  $2a,  $4d,  $49,  $4d,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $2a,  $2a,  $2a,  $4d,  $49,  $4d,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $49,  $49,  $49,  $49,  $49,  $49,  $49,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $49,  $02,  $49,  $49,  $49,  $49,  $49,  $26,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $49,  $49,  $49,  $02,  $04,  $26,  $49,  $26,  $4d,  $4d,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $49,  $10,  $49,  $02,  $4d,  $4d,  $4d,  $4d,  $4d,  $49,  $4d,  $49,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $49,  $10,  $4d,  $4d,  $4d,  $4d,  $4d,  $4d,  $4d,  $49,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $49,  $10,  $04,  $10,  $26,  $26,  $26,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $49,  $4d,  $4d,  $4d,  $4d,  $4d,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $49,  $4d,  $4d,  $4d,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $49,  $4d,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $34,  $34,  $34,  $34,  $34,  $34,  $34,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $34,  $02,  $34,  $34,  $34,  $34,  $34,  $17,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $34,  $34,  $34,  $02,  $03,  $22,  $34,  $17,  $3f,  $3f,  $3f,  $ff,  $ff,  $ff 
	DC.W $ff,  $34,  $17,  $34,  $02,  $3f,  $3f,  $3f,  $3f,  $3f,  $34,  $3f,  $34,  $3f,  $ff,  $ff 
	DC.W $ff,  $ff,  $34,  $17,  $3f,  $3f,  $3f,  $3f,  $3f,  $3f,  $3f,  $34,  $3f,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $34,  $17,  $02,  $22,  $22,  $22,  $22,  $34,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $34,  $3f,  $3f,  $3f,  $3f,  $3f,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $34,  $3f,  $3f,  $3f,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $34,  $3f,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2d,  $2d,  $2d,  $2d,  $2d,  $2d,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2d,  $02,  $2d,  $2d,  $2d,  $2d,  $2d,  $02,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2d,  $2d,  $2d,  $02,  $15,  $1b,  $2d,  $02,  $33,  $33,  $33,  $ff,  $ff,  $ff 
	DC.W $ff,  $2d,  $02,  $2d,  $02,  $33,  $33,  $33,  $33,  $33,  $2d,  $33,  $2d,  $33,  $ff,  $ff 
	DC.W $ff,  $ff,  $2d,  $02,  $33,  $33,  $33,  $33,  $33,  $33,  $33,  $2d,  $33,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2d,  $02,  $15,  $1b,  $2d,  $15,  $2d,  $2d,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2d,  $33,  $33,  $33,  $33,  $33,  $33,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2d,  $33,  $33,  $33,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2d,  $33,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $2a,  $10,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $49,  $43,  $2a,  $10,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $04,  $10,  $34,  $26,  $2a,  $10,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $43,  $49,  $10,  $10,  $10,  $26,  $2a,  $10,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $04,  $10,  $34,  $26,  $49,  $43,  $10,  $26,  $2a,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $26,  $43,  $49,  $26,  $10,  $10,  $26,  $26,  $26,  $2a,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $26,  $10,  $10,  $26,  $26,  $26,  $26,  $2a,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $2a,  $26,  $26,  $2a,  $2a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $4d,  $49,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $4d,  $49,  $43,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $4d,  $43,  $02,  $41,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $4d,  $49,  $43,  $41,  $41,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $4d,  $49,  $43,  $41,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $49,  $43,  $41,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $49,  $43,  $41,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $43,  $41,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $43,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $43,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $43,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $43,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $43,  $4d,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $43,  $34,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $3f,  $34,  $3f,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $17,  $3f,  $17,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $3f,  $34,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $3f,  $3f,  $34,  $3f,  $34,  $3f,  $34,  $3f,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $3f,  $34,  $17,  $22,  $3f,  $3f,  $3f,  $22,  $17,  $34,  $3f,  $ff,  $ff,  $ff 
	DC.W $ff,  $3f,  $34,  $17,  $34,  $3f,  $34,  $3f,  $34,  $3f,  $34,  $17,  $34,  $3f,  $ff,  $ff 
	DC.W $ff,  $3f,  $17,  $34,  $3f,  $3f,  $3f,  $34,  $3f,  $3f,  $3f,  $34,  $17,  $3f,  $ff,  $ff 
	DC.W $ff,  $3f,  $34,  $17,  $16,  $3f,  $17,  $3f,  $17,  $3f,  $16,  $17,  $34,  $3f,  $ff,  $ff 
	DC.W $ff,  $ff,  $3f,  $34,  $22,  $3f,  $34,  $3f,  $34,  $3f,  $22,  $34,  $3f,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $3f,  $3f,  $3f,  $3f,  $3f,  $3f,  $3f,  $3f,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $3f,  $34,  $22,  $17,  $3f,  $3f,  $3f,  $17,  $22,  $34,  $3f,  $ff,  $ff,  $ff 
	DC.W $ff,  $3f,  $34,  $22,  $17,  $16,  $3f,  $17,  $3f,  $16,  $17,  $22,  $34,  $3f,  $ff,  $ff 
	DC.W $ff,  $3f,  $34,  $22,  $17,  $16,  $3f,  $22,  $3f,  $17,  $17,  $22,  $34,  $3f,  $ff,  $ff 
	DC.W $ff,  $ff,  $3f,  $34,  $22,  $17,  $3f,  $34,  $3f,  $34,  $22,  $34,  $3f,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $33,  $4d,  $4d,  $4d,  $4d,  $4d,  $4d,  $4d,  $33,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $4d,  $47,  $2d,  $47,  $47,  $47,  $47,  $47,  $47,  $47,  $2d,  $47,  $4d,  $ff,  $ff 
	DC.W $ff,  $49,  $44,  $02,  $44,  $44,  $44,  $44,  $44,  $44,  $44,  $02,  $44,  $49,  $ff,  $ff 
	DC.W $ff,  $49,  $46,  $15,  $46,  $46,  $46,  $46,  $46,  $46,  $46,  $15,  $46,  $49,  $ff,  $ff 
	DC.W $ff,  $4d,  $4a,  $2d,  $4a,  $4a,  $4a,  $4a,  $4a,  $4a,  $4a,  $2d,  $4a,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $33,  $4d,  $4d,  $4d,  $4d,  $4d,  $4d,  $4d,  $33,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $04,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $2a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $04,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $13,  $10,  $13,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $10,  $10,  $0a,  $10,  $10,  $10,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $10,  $ff,  $2a,  $13,  $10,  $13,  $2a,  $ff,  $10,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $10,  $10,  $04,  $10,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $10,  $0a,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $10,  $04,  $0a,  $0a,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $10,  $04,  $0a,  $0a,  $0a,  $0a,  $10,  $13,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $2a,  $13,  $10,  $04,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $10,  $13,  $2a,  $ff,  $ff 
	DC.W $ff,  $28,  $10,  $04,  $07,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $10,  $28,  $ff,  $ff 
	DC.W $ff,  $28,  $0d,  $04,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $0d,  $28,  $ff,  $ff 
	DC.W $ff,  $28,  $10,  $10,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $10,  $28,  $ff,  $ff 
	DC.W $ff,  $2a,  $13,  $10,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $10,  $13,  $2a,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $10,  $0a,  $0a,  $0a,  $0a,  $0a,  $10,  $13,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $04,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $13,  $10,  $13,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $13,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $03,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $46,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $49,  $46,  $45,  $46,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $49,  $03,  $45,  $42,  $45,  $03,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $49,  $46,  $45,  $1b,  $02,  $1b,  $45,  $46,  $49,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $4d,  $49,  $46,  $45,  $43,  $33,  $02,  $33,  $43,  $45,  $46,  $49,  $4d,  $ff,  $ff 
	DC.W $ff,  $4b,  $49,  $46,  $45,  $43,  $20,  $1b,  $20,  $43,  $45,  $46,  $49,  $4b,  $ff,  $ff 
	DC.W $ff,  $4d,  $49,  $46,  $45,  $03,  $43,  $42,  $43,  $03,  $45,  $46,  $49,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $49,  $46,  $45,  $43,  $43,  $43,  $45,  $46,  $49,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $4b,  $49,  $46,  $45,  $46,  $49,  $4b,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $3f,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $34,  $3f,  $34 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $1e,  $2a,  $3f,  $34,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $12,  $10,  $27,  $2a,  $3f,  $3f 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $28,  $10,  $04,  $10,  $13,  $2a,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $12,  $10,  $28,  $10,  $13,  $28,  $2a,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $28,  $10,  $04,  $10,  $13,  $28,  $2a,  $2a,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $12,  $10,  $28,  $13,  $13,  $28,  $2a,  $2a,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $28,  $04,  $10,  $13,  $28,  $2a,  $2a,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $12,  $10,  $11,  $28,  $2a,  $2a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $1e,  $04,  $11,  $2a,  $2a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $2a,  $12,  $10,  $2a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $2a,  $0a,  $11,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $32,  $32,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $32,  $1c,  $15,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $32,  $2f,  $1c,  $15,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $33,  $2f,  $2d,  $1c,  $15,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $2f,  $2d,  $1c,  $15,  $2d,  $32,  $32,  $33,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $33,  $2f,  $2d,  $1c,  $30,  $15,  $03,  $20,  $30,  $33,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $33,  $2f,  $30,  $1c,  $1c,  $15,  $03,  $20,  $30,  $33,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $32,  $2f,  $20,  $1c,  $1c,  $2f,  $2f,  $32,  $30,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $32,  $2f,  $20,  $1c,  $2f,  $13,  $10,  $13,  $32,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2f,  $20,  $2f,  $13,  $10,  $04,  $10,  $32,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $32,  $2f,  $30,  $10,  $0a,  $10,  $13,  $32,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2f,  $30,  $13,  $10,  $13,  $30,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2f,  $30,  $30,  $30,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $1e,  $04,  $0a,  $0a,  $0a,  $10,  $1e,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $1e,  $10,  $0a,  $0a,  $0a,  $10,  $1e,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $32,  $2d,  $03,  $15,  $1b,  $1b,  $1c,  $2d,  $32,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $1e,  $04,  $0a,  $0a,  $0a,  $10,  $1e,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $1e,  $10,  $0a,  $0a,  $0a,  $10,  $1e,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $1e,  $10,  $0a,  $10,  $1e,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $29,  $1e,  $29,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $0a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $10,  $29,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $29,  $0a,  $29,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $1e,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $1e,  $10,  $1e,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $1e,  $10,  $0a,  $04,  $0a,  $10,  $1e,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $3b,  $37,  $3b,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4c,  $4a,  $4c,  $3b,  $02,  $1a,  $25,  $3b,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4c,  $02,  $45,  $49,  $25,  $1a,  $17,  $1a,  $34,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $46,  $43,  $43,  $45,  $3b,  $25,  $1a,  $25,  $3b,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $49,  $46,  $45,  $4a,  $4c,  $3b,  $37,  $3b,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4c,  $4c,  $2a,  $ff,  $ff,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $10,  $ff,  $10,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $ff,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $33,  $20,  $14,  $02,  $14,  $20,  $33,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $33,  $20,  $14,  $02,  $00,  $02,  $14,  $20,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $33,  $30,  $20,  $02,  $00,  $02,  $20,  $30,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $20,  $00,  $14,  $20,  $02,  $20,  $14,  $00,  $20,  $33,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $02,  $33,  $33,  $33,  $2d,  $33,  $33,  $33,  $02,  $33,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $20,  $33,  $33,  $2d,  $33,  $2d,  $33,  $33,  $20,  $33,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $30,  $14,  $02,  $33,  $33,  $33,  $02,  $14,  $30,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $33,  $20,  $20,  $14,  $00,  $14,  $20,  $20,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $2d,  $33,  $ff,  $33,  $02,  $33,  $02,  $33,  $02,  $33,  $ff,  $33,  $2d,  $ff,  $ff 
	DC.W $33,  $02,  $2d,  $02,  $33,  $30,  $20,  $00,  $20,  $30,  $33,  $02,  $2d,  $02,  $33,  $ff 
	DC.W $ff,  $2d,  $33,  $ff,  $2d,  $ff,  $33,  $30,  $33,  $ff,  $2d,  $ff,  $33,  $2d,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $34,  $17,  $38,  $34,  $38,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $34,  $38,  $10,  $13,  $38,  $17,  $38,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $13,  $10,  $04,  $04,  $0a,  $10,  $38,  $34,  $17,  $13,  $2a,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $10,  $04,  $04,  $0a,  $0a,  $0a,  $10,  $38,  $34,  $10,  $13,  $ff,  $ff 
	DC.W $ff,  $ff,  $13,  $10,  $10,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $38,  $10,  $13,  $ff,  $ff 
	DC.W $ff,  $ff,  $13,  $10,  $04,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $10,  $13,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $10,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $10,  $2a,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $13,  $10,  $0a,  $0a,  $0a,  $0a,  $0a,  $0a,  $10,  $13,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $10,  $0a,  $0a,  $10,  $0a,  $10,  $13,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $10,  $10,  $13,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $10,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $10,  $04,  $10,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $32,  $20,  $02,  $2d,  $32,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $32,  $20,  $14,  $20,  $32,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $32,  $20,  $15,  $20,  $32,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $32,  $20,  $15,  $20,  $32,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $32,  $20,  $15,  $20,  $32,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $30,  $2d,  $30,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $32,  $20,  $15,  $20,  $32,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $03,  $2f,  $2d,  $03,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2f,  $03,  $03,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4b,  $45,  $45,  $4b,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $02,  $54,  $03,  $47,  $45,  $49,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $1b,  $53,  $54,  $54,  $03,  $4b,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $03,  $54,  $01,  $03,  $55,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $1b,  $01,  $54,  $54,  $54,  $03,  $1b,  $2d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $1b,  $54,  $01,  $02,  $54,  $01,  $14,  $2d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $15,  $03,  $54,  $54,  $54,  $03,  $1b,  $2d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $15,  $01,  $54,  $03,  $1b,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $29,  $28,  $26,  $26,  $26,  $4c,  $43,  $26,  $26,  $26,  $28,  $2a,  $ff 
	DC.W $ff,  $ff,  $29,  $10,  $10,  $10,  $10,  $4c,  $43,  $10,  $04,  $10,  $2a,  $10,  $28,  $2a 
	DC.W $ff,  $ff,  $13,  $0d,  $0d,  $0d,  $4d,  $4c,  $49,  $0d,  $0d,  $2a,  $10,  $2a,  $2a,  $28 
	DC.W $ff,  $ff,  $29,  $13,  $13,  $49,  $13,  $4c,  $49,  $13,  $13,  $13,  $2a,  $13,  $28,  $2a 
	DC.W $ff,  $29,  $28,  $26,  $26,  $26,  $4c,  $43,  $4c,  $49,  $26,  $26,  $26,  $28,  $2a,  $ff 
	DC.W $29,  $10,  $10,  $10,  $10,  $4c,  $43,  $10,  $04,  $10,  $2a,  $10,  $28,  $2a,  $ff,  $ff 
	DC.W $13,  $0d,  $0d,  $0d,  $0d,  $4c,  $49,  $0d,  $10,  $2a,  $10,  $2a,  $2a,  $28,  $ff,  $ff 
	DC.W $29,  $13,  $13,  $13,  $4c,  $4c,  $49,  $13,  $13,  $13,  $2a,  $13,  $28,  $2a,  $ff,  $ff 
	DC.W $ff,  $29,  $28,  $28,  $49,  $28,  $4c,  $49,  $28,  $28,  $28,  $28,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $34,  $ff,  $ff 
	DC.W $ff,  $22,  $34,  $34,  $34,  $1a,  $1a,  $34,  $1a,  $1a,  $34,  $34,  $34,  $38,  $ff,  $ff 
	DC.W $ff,  $22,  $34,  $34,  $34,  $1a,  $34,  $34,  $1a,  $1a,  $34,  $34,  $34,  $38,  $ff,  $ff 
	DC.W $ff,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $22,  $34,  $ff 
	DC.W $ff,  $22,  $22,  $34,  $34,  $34,  $1a,  $1a,  $34,  $1a,  $1a,  $34,  $34,  $34,  $38,  $ff 
	DC.W $ff,  $ff,  $22,  $34,  $34,  $34,  $1a,  $34,  $34,  $1a,  $1a,  $34,  $34,  $34,  $38,  $ff 
	DC.W $ff,  $ff,  $22,  $34,  $34,  $34,  $1a,  $1a,  $34,  $1a,  $1a,  $34,  $34,  $34,  $38,  $ff 
	DC.W $ff,  $ff,  $34,  $38,  $38,  $38,  $38,  $38,  $38,  $38,  $38,  $38,  $38,  $38,  $38,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $40,  $40,  $40,  $40,  $40,  $40,  $40,  $40,  $40,  $40,  $40,  $40,  $ff,  $ff 
	DC.W $ff,  $40,  $00,  $02,  $02,  $03,  $14,  $14,  $14,  $14,  $14,  $14,  $14,  $20,  $40,  $ff 
	DC.W $ff,  $40,  $02,  $3d,  $3a,  $39,  $36,  $36,  $36,  $36,  $39,  $3a,  $3d,  $1b,  $40,  $ff 
	DC.W $ff,  $40,  $03,  $3d,  $3a,  $36,  $31,  $21,  $21,  $31,  $36,  $3a,  $3d,  $1b,  $40,  $ff 
	DC.W $ff,  $40,  $03,  $3d,  $3a,  $36,  $31,  $21,  $21,  $31,  $36,  $3a,  $3d,  $1b,  $40,  $ff 
	DC.W $ff,  $40,  $14,  $3d,  $39,  $36,  $35,  $31,  $31,  $35,  $36,  $39,  $3d,  $1b,  $40,  $ff 
	DC.W $ff,  $40,  $14,  $3d,  $39,  $36,  $35,  $31,  $31,  $35,  $36,  $39,  $3d,  $1b,  $40,  $ff 
	DC.W $ff,  $40,  $14,  $3d,  $39,  $36,  $36,  $35,  $35,  $36,  $36,  $39,  $3d,  $1b,  $40,  $ff 
	DC.W $ff,  $40,  $14,  $3d,  $3a,  $39,  $36,  $36,  $36,  $36,  $39,  $3a,  $3d,  $1b,  $40,  $ff 
	DC.W $ff,  $40,  $1b,  $3e,  $3d,  $3a,  $39,  $39,  $39,  $39,  $3a,  $3d,  $3e,  $1b,  $40,  $ff 
	DC.W $ff,  $ff,  $40,  $1b,  $3e,  $3d,  $3a,  $3a,  $3a,  $3a,  $3d,  $3e,  $1b,  $40,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $40,  $1b,  $3e,  $3d,  $3d,  $3d,  $3d,  $3e,  $1b,  $40,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $40,  $1b,  $3e,  $3e,  $3e,  $3e,  $1b,  $40,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $40,  $1b,  $1b,  $1b,  $1b,  $40,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $40,  $40,  $40,  $40,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $43,  $49,  $13,  $2a,  $13,  $2a,  $49,  $43,  $55,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $2a,  $10,  $2a,  $2a,  $55,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $2a,  $13,  $2a,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $55,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $33,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $1c,  $14,  $33,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $1c,  $14,  $2d,  $33,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $1c,  $14,  $2d,  $32,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $1c,  $15,  $2d,  $32,  $33,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $1c,  $14,  $2d,  $32,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $1c,  $14,  $2d,  $30,  $33,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $33,  $30,  $14,  $2d,  $30,  $33,  $14,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $33,  $30,  $14,  $2d,  $30,  $33,  $ff,  $2d,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $1c,  $14,  $2d,  $30,  $33,  $33,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $15,  $2d,  $30,  $33,  $10,  $1e,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $2d,  $30,  $33,  $26,  $10,  $04,  $1e,  $33,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $33,  $33,  $33,  $33,  $28,  $10,  $04,  $10,  $28,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $28,  $26,  $29,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2f,  $33,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $13,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $10,  $04,  $04,  $10,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $04,  $10,  $0c,  $0c,  $0c,  $10,  $10,  $13,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $2a,  $13,  $04,  $10,  $26,  $13,  $13,  $13,  $26,  $0c,  $10,  $13,  $2a,  $ff,  $ff 
	DC.W $ff,  $27,  $13,  $10,  $26,  $13,  $04,  $0c,  $10,  $13,  $26,  $10,  $0d,  $27,  $ff,  $ff 
	DC.W $ff,  $13,  $09,  $0c,  $13,  $04,  $0c,  $0a,  $0c,  $10,  $13,  $0c,  $10,  $13,  $ff,  $ff 
	DC.W $ff,  $13,  $10,  $0c,  $13,  $10,  $0c,  $0a,  $0c,  $10,  $13,  $0c,  $10,  $13,  $ff,  $ff 
	DC.W $ff,  $27,  $09,  $10,  $26,  $13,  $10,  $0c,  $10,  $13,  $26,  $10,  $0d,  $27,  $ff,  $ff 
	DC.W $ff,  $2a,  $13,  $10,  $0c,  $26,  $13,  $13,  $13,  $26,  $0c,  $10,  $13,  $2a,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $10,  $10,  $0c,  $0c,  $0c,  $10,  $10,  $13,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $13,  $10,  $10,  $10,  $13,  $13,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $13,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $43,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $33,  $15,  $4d,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $15,  $33,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $15,  $33,  $34,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $15,  $2d,  $ff,  $3f,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $15,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $49,  $33,  $2d,  $15,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $49,  $33,  $2d,  $15,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $4d,  $49,  $33,  $2d,  $15,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $2d,  $15,  $2d,  $33,  $49,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2d,  $15,  $2d,  $33,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $2d,  $33,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4d,  $4b,  $49,  $47,  $49,  $4b,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $49,  $43,  $06,  $41,  $41,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4b,  $43,  $41,  $41,  $41,  $41,  $41,  $43,  $4b,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $41,  $49,  $43,  $49,  $43,  $41,  $49,  $49,  $43,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $43,  $4d,  $49,  $4d,  $49,  $43,  $49,  $4d,  $49,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4d,  $28,  $4d,  $10,  $4d,  $47,  $13,  $28,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $28,  $13,  $04,  $0a,  $49,  $13,  $28,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $10,  $0a,  $10,  $26,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $13,  $0a,  $13,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $13,  $04,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $10,  $26,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $28,  $13,  $28,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $26,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $2a,  $2a,  $1e,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $04,  $10,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $43,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $4d,  $4d,  $4d,  $43,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $1e,  $0a,  $4d,  $43,  $4d,  $49,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $04,  $33,  $10,  $4d,  $49,  $4d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $28,  $13,  $33,  $33,  $33,  $10,  $1e,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $10,  $33,  $0a,  $10,  $33,  $1e,  $28,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $28,  $13,  $04,  $33,  $33,  $33,  $10,  $1e,  $28,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $10,  $33,  $0a,  $10,  $33,  $13,  $1e,  $28,  $29,  $2a,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $10,  $0a,  $33,  $33,  $33,  $13,  $1e,  $28,  $29,  $2a,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $10,  $0a,  $10,  $33,  $13,  $1e,  $28,  $29,  $2a,  $2a,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $10,  $13,  $13,  $1e,  $28,  $29,  $2a,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $26,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $26,  $ff,  $ff,  $26,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $48,  $2a,  $48,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $1c,  $02,  $1c,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $1c,  $03,  $1c,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $48,  $43,  $48,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $48,  $42,  $49,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $48,  $42,  $48,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $48,  $43,  $48,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $48,  $42,  $48,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $48,  $43,  $48,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $48,  $42,  $48,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4d,  $48,  $43,  $48,  $4d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $4b,  $47,  $43,  $47,  $4b,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $4b,  $47,  $43,  $41,  $43,  $47,  $4b,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $4b,  $47,  $43,  $47,  $4b,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $27,  $13,  $4b,  $47,  $4b,  $13,  $27,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $04,  $2a,  $4b,  $2a,  $13,  $10,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $10,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $2a,  $0a,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $2a,  $ff,  $ff 
	DC.W $ff,  $27,  $04,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $10,  $27,  $ff,  $ff 
	DC.W $ff,  $27,  $0a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $10,  $27,  $ff,  $ff 
	DC.W $ff,  $2a,  $13,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $13,  $2a,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $10,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff,  $2a,  $10,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $10,  $13,  $27,  $2a,  $27,  $13,  $13,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2a,  $27,  $13,  $10,  $13,  $27,  $2a,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $1f,  $05,  $05,  $0e,  $0e,  $0f,  $1f,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $0e,  $0f,  $2b,  $2b,  $2b,  $2b,  $1f,  $0f,  $0f,  $1f,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $0e,  $0f,  $2b,  $0f,  $05,  $0b,  $0b,  $0f,  $2b,  $1d,  $0f,  $1f,  $ff,  $ff 
	DC.W $ff,  $0e,  $0f,  $2b,  $0f,  $05,  $0f,  $0f,  $0f,  $1d,  $0f,  $2b,  $1d,  $0f,  $1f,  $ff 
	DC.W $ff,  $0f,  $2b,  $0f,  $0f,  $0e,  $0f,  $0f,  $0f,  $0f,  $1d,  $0f,  $2b,  $0f,  $2b,  $ff 
	DC.W $0f,  $1d,  $2b,  $0f,  $05,  $0f,  $0f,  $0f,  $0f,  $0f,  $1d,  $0f,  $0f,  $1d,  $0f,  $1f 
	DC.W $0e,  $2b,  $0f,  $0f,  $0e,  $0f,  $0f,  $0f,  $0f,  $0f,  $1d,  $0f,  $0f,  $0b,  $0f,  $2b 
	DC.W $0f,  $1f,  $0f,  $0f,  $0f,  $0b,  $0f,  $0f,  $1d,  $1d,  $0f,  $0f,  $0f,  $0b,  $0f,  $2b 
	DC.W $0f,  $1f,  $0f,  $0f,  $0f,  $05,  $0f,  $0f,  $1d,  $0f,  $0f,  $0f,  $0f,  $0e,  $0f,  $2b 
	DC.W $2b,  $0f,  $1d,  $0f,  $0f,  $1d,  $0f,  $0f,  $0f,  $1d,  $0f,  $0f,  $0e,  $0f,  $2b,  $2c 
	DC.W $ff,  $0f,  $0f,  $1d,  $0f,  $0f,  $05,  $0f,  $1d,  $0f,  $0f,  $1d,  $0f,  $0f,  $2b,  $ff 
	DC.W $ff,  $2b,  $0f,  $0f,  $1d,  $05,  $0f,  $0f,  $0f,  $0f,  $1d,  $0f,  $0f,  $2b,  $2c,  $ff 
	DC.W $ff,  $ff,  $2b,  $0f,  $0f,  $0f,  $0b,  $0b,  $0e,  $1d,  $0f,  $0f,  $2b,  $2c,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2b,  $1f,  $0f,  $0f,  $0f,  $0f,  $0f,  $2b,  $2b,  $2c,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2b,  $2b,  $2b,  $2b,  $2b,  $2c,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $32,  $2a,  $10,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $32,  $32,  $33,  $2f,  $2a,  $2d,  $ff,  $26,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $33,  $32,  $2f,  $2f,  $2f,  $32,  $15,  $2d,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $30,  $2f,  $1c,  $1b,  $20,  $2f,  $32,  $32,  $33,  $3c,  $ff,  $ff,  $ff 
	DC.W $ff,  $33,  $30,  $2f,  $1c,  $03,  $15,  $1b,  $20,  $2f,  $30,  $32,  $33,  $3c,  $ff,  $ff 
	DC.W $ff,  $33,  $2f,  $20,  $14,  $15,  $15,  $1b,  $20,  $2d,  $2f,  $30,  $32,  $33,  $ff,  $ff 
	DC.W $ff,  $33,  $2f,  $20,  $15,  $15,  $1b,  $1b,  $20,  $2d,  $2f,  $30,  $32,  $33,  $ff,  $ff 
	DC.W $ff,  $33,  $30,  $2f,  $20,  $1b,  $1b,  $20,  $20,  $2d,  $2f,  $30,  $32,  $33,  $ff,  $ff 
	DC.W $ff,  $ff,  $33,  $30,  $2d,  $20,  $20,  $20,  $2d,  $2f,  $30,  $32,  $33,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $33,  $30,  $2f,  $2f,  $2f,  $30,  $32,  $32,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3c,  $33,  $32,  $32,  $33,  $33,  $3c,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $26,  $10,  $04,  $0a,  $0a,  $10,  $26,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $26,  $10,  $04,  $0a,  $0a,  $0a,  $0a,  $0c,  $26,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $26,  $13,  $10,  $0a,  $0a,  $0a,  $10,  $13,  $26,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $3f,  $2a,  $26,  $13,  $13,  $13,  $13,  $13,  $26,  $2a,  $3f,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $4d,  $34,  $34,  $17,  $34,  $17,  $34,  $17,  $34,  $34,  $4d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $4d,  $49,  $43,  $41,  $41,  $41,  $43,  $49,  $4d,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $2a,  $13,  $10,  $04,  $0a,  $0a,  $0a,  $0a,  $10,  $13,  $2a,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2a,  $13,  $10,  $0a,  $0a,  $0a,  $10,  $13,  $2a,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $24,  $1b,  $49,  $49,  $49,  $49,  $49,  $49,  $49,  $49,  $49,  $49,  $49,  $1b,  $24,  $ff 
	DC.W $1a,  $02,  $49,  $44,  $44,  $44,  $44,  $55,  $44,  $44,  $55,  $44,  $49,  $02,  $1a,  $ff 
	DC.W $1a,  $00,  $49,  $41,  $55,  $41,  $41,  $41,  $41,  $41,  $41,  $41,  $49,  $00,  $1a,  $ff 
	DC.W $23,  $00,  $49,  $41,  $41,  $41,  $41,  $41,  $55,  $41,  $41,  $41,  $49,  $00,  $23,  $ff 
	DC.W $34,  $02,  $49,  $43,  $41,  $55,  $41,  $41,  $41,  $41,  $41,  $43,  $49,  $02,  $34,  $ff 
	DC.W $3f,  $34,  $02,  $49,  $44,  $41,  $41,  $41,  $41,  $41,  $44,  $49,  $02,  $34,  $3f,  $ff 
	DC.W $ff,  $3f,  $34,  $02,  $48,  $47,  $44,  $41,  $44,  $47,  $48,  $02,  $34,  $3f,  $ff,  $ff 
	DC.W $ff,  $ff,  $3f,  $34,  $1a,  $02,  $00,  $00,  $00,  $02,  $1a,  $34,  $3f,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $3f,  $34,  $23,  $1a,  $17,  $1a,  $23,  $34,  $3f,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $24,  $24,  $38,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $24,  $ff,  $ff,  $ff,  $38,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $34,  $38,  $24,  $34,  $38,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $24,  $3b,  $ff,  $ff,  $ff,  $ff,  $38,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $24,  $3b,  $ff,  $ff,  $ff,  $ff,  $4c,  $47,  $4c,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4c,  $47,  $4c,  $ff,  $ff,  $ff,  $4c,  $02,  $41,  $43,  $4c,  $ff,  $ff 
	DC.W $ff,  $ff,  $4c,  $02,  $41,  $43,  $4c,  $ff,  $ff,  $4c,  $47,  $43,  $47,  $4c,  $ff,  $ff 
	DC.W $ff,  $ff,  $4c,  $47,  $43,  $47,  $4c,  $ff,  $ff,  $ff,  $4c,  $47,  $4c,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $4c,  $47,  $4c,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $02,  $1b,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $33,  $33,  $1b,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $1a,  $34,  $3f,  $33,  $1b,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $1a,  $18,  $1a,  $34,  $3f,  $1b,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $34,  $1a,  $17,  $16,  $17,  $1a,  $34,  $2d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $24,  $19,  $17,  $16,  $17,  $19,  $24,  $30,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $24,  $19,  $17,  $16,  $17,  $19,  $24,  $33,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $34,  $1a,  $17,  $16,  $17,  $1a,  $34,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $3f,  $34,  $1a,  $18,  $1a,  $34,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $33,  $2d,  $1b,  $2d,  $33,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $00,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $00,  $00,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $2d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $2d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $2d,  $ff,  $ff 
	DC.W $ff,  $ff,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $ff,  $ff 
	DC.W $ff,  $ff,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $2d,  $ff,  $ff 
	DC.W $ff,  $ff,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $2d,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $2d,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $00,  $00,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $00,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2d,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $16,  $16,  $16,  $16,  $16,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $ff,  $ff 
	DC.W $ff,  $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $ff 
	DC.W $ff,  $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $ff 
	DC.W $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16 
	DC.W $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16 
	DC.W $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16 
	DC.W $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16 
	DC.W $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16 
	DC.W $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16 
	DC.W $ff,  $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $ff 
	DC.W $ff,  $ff,  $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $16,  $16,  $16,  $16,  $16,  $16,  $16,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $ff,  $ff 
	DC.W $ff,  $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $ff 
	DC.W $ff,  $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $ff 
	DC.W $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e 
	DC.W $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e 
	DC.W $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e 
	DC.W $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e 
	DC.W $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e 
	DC.W $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e 
	DC.W $ff,  $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $ff 
	DC.W $ff,  $ff,  $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $2e,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $05,  $05,  $05,  $05,  $05,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $ff,  $ff 
	DC.W $ff,  $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $ff 
	DC.W $ff,  $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $ff 
	DC.W $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05 
	DC.W $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05 
	DC.W $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05 
	DC.W $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05 
	DC.W $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05 
	DC.W $ff,  $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $ff 
	DC.W $ff,  $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $ff 
	DC.W $ff,  $ff,  $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $05,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $05,  $05,  $05,  $05,  $05,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $50,  $50,  $50,  $50,  $50,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $ff,  $ff 
	DC.W $ff,  $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $ff 
	DC.W $ff,  $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $ff 
	DC.W $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50 
	DC.W $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50 
	DC.W $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50 
	DC.W $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50 
	DC.W $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50 
	DC.W $ff,  $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $ff 
	DC.W $ff,  $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $ff 
	DC.W $ff,  $ff,  $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $50,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $50,  $50,  $50,  $50,  $50,  $ff,  $ff,  $ff,  $ff,  $ff 
	DC.W $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff
	
	




MERLIN_PIC
    ORG $0C00618
    dc.w $00,  $01,  $02,  $03,  $04,  $05,  $06,  $07,  $08,  $09,  $0a,  $0b,  $0c,  $0d,  $0e,  $00
    ORG $0C00698
    dc.w $0f,  $10,  $11,  $12,  $13,  $14,  $15,  $16,  $17,  $18,  $19,  $1a,  $1b,  $1c,  $1d,  $00
    ORG $0C00718
    dc.w $1e,  $1f,  $20,  $21,  $22,  $23,  $24,  $25,  $26,  $27,  $28,  $29,  $2a,  $2b,  $2c,  $2d   
    ORG $0C00798
    dc.w $2e,  $2f,  $30,  $31,  $32,  $33,  $34,  $35,  $36,  $37,  $38,  $39,  $3a,  $3b,  $3c,  $3d
    ORG $0C00818
    dc.w $3e,  $3f,  $40,  $41,  $42,  $43,  $44,  $45,  $46,  $47,  $48,  $49,  $4a,  $4b,  $4c,  $4d
    ORG $0C00898
    dc.w $4e,  $4f,  $50,  $51,  $52,  $53,  $54,  $55,  $56,  $57,  $58,  $59,  $5a,  $5b,  $5c,  $5d
    ORG $0C00918
    dc.w $5e,  $5f,  $60,  $61,  $62,  $63,  $64,  $65,  $66,  $67,  $68,  $69,  $6a,  $6b,  $6c,  $6d
    ORG $0C00998
    dc.w $6e,  $6f,  $70,  $71,  $72,  $73,  $74,  $75,  $76,  $77,  $78,  $79,  $7a,  $7b,  $7c,  $7d
    ORG $0C00A18

    dc.w $7e,  $7f,  $80,  $81,  $82,  $83,  $84,  $85,  $86,  $87,  $88,  $89,  $8a,  $8b,  $8c,  $8d
    ORG $0C00a98

    dc.w $8e,  $8f,  $90,  $91,  $92,  $93,  $94,  $95,  $96,  $97,  $98,  $99,  $9a,  $9b,  $9c,  $00
    ORG $0C00b18

    dc.w $00,  $9d,  $9e,  $9f,  $a0,  $a1,  $a2,  $a3,  $a4,  $a5,  $a6,  $a7,  $a8,  $a9,  $00,  $00
    ORG $0C00b98

    dc.w $00,  $aa,  $ab,  $ac,  $ad,  $ae,  $af,  $b0,  $b1,  $b2,  $b3,  $b4,  $b5,  $00,  $00,  $00
    ORG $0C00c18

    dc.w $b6,  $b7,  $b8,  $b9,  $ba,  $bb,  $bc,  $bd,  $be,  $bf,  $c0,  $c1,  $c2,  $c3,  $c4,  $00
    ORG $0C00c98

    dc.w $c5,  $c6,  $c7,  $c8,  $c9,  $ca,  $cb,  $cc,  $cd,  $ce,  $cf,  $d0,  $d1,  $d2,  $d3,  $00
    ORG $0C00d18

    dc.w $d4,  $d5,  $d6,  $d7,  $d8,  $d9,  $da,  $db,  $dc,  $dd,  $de,  $df,  $e0,  $e1,  $e2,  $00
    ORG $0C00d98

    dc.w $e3,  $e4,  $e5,  $e6,  $e7,  $e8,  $e9,  $ea,  $eb,  $ec,  $ed,  $ee,  $ef,  $f0,  $f1,  $00

    org $c02000
MERLIN_CHR
	dc.w $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	dc.w $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $54,  $55,  $54,  $55,  $54,  $40,  $00 
	dc.w $ff,  $aa,  $e9,  $aa,  $e9,  $aa,  $ea,  $aa,  $ab,  $a4,  $ab,  $a0,  $aa,  $a0,  $a9,  $40 
	dc.w $a9,  $40,  $a9,  $17,  $a9,  $17,  $a9,  $13,  $55,  $0f,  $44,  $ff,  $03,  $ff,  $43,  $ff 
	dc.w $02,  $a9,  $02,  $a5,  $0a,  $55,  $a9,  $57,  $a9,  $5f,  $a5,  $7f,  $95,  $ff,  $57,  $ff 
	dc.w $ff,  $c0,  $ff,  $02,  $f0,  $2a,  $c0,  $a9,  $c2,  $a9,  $0a,  $95,  $29,  $55,  $a5,  $55 
	dc.w $00,  $05,  $00,  $15,  $05,  $5a,  $15,  $aa,  $56,  $af,  $6a,  $bf,  $ab,  $ff,  $af,  $ff 
	dc.w $aa,  $ab,  $aa,  $bf,  $af,  $ff,  $ff,  $55,  $d5,  $50,  $54,  $00,  $40,  $05,  $00,  $15 
	dc.w $55,  $55,  $5a,  $aa,  $a0,  $00,  $3f,  $ff,  $ff,  $0f,  $00,  $0f,  $8c,  $26,  $e5,  $bf 
	dc.w $ff,  $ff,  $55,  $ff,  $95,  $57,  $0a,  $95,  $00,  $09,  $aa,  $02,  $aa,  $a0,  $2a,  $68 
	dc.w $0f,  $ff,  $40,  $3f,  $54,  $0f,  $95,  $03,  $a5,  $40,  $aa,  $50,  $aa,  $94,  $aa,  $95 
	dc.w $40,  $aa,  $50,  $aa,  $d4,  $2a,  $d5,  $02,  $f5,  $42,  $fd,  $50,  $ff,  $50,  $ff,  $54 
	dc.w $05,  $7f,  $01,  $5f,  $80,  $5f,  $a0,  $57,  $a8,  $17,  $a8,  $05,  $aa,  $05,  $aa,  $05 
	dc.w $05,  $aa,  $c5,  $6a,  $c5,  $6a,  $c5,  $5a,  $f1,  $5a,  $f1,  $5a,  $f0,  $5a,  $ff,  $16 
	dc.w $01,  $55,  $00,  $55,  $00,  $55,  $00,  $55,  $00,  $55,  $00,  $55,  $00,  $55,  $00,  $55 
	dc.w $aa,  $aa,  $aa,  $a9,  $aa,  $55,  $55,  $55,  $00,  $55,  $55,  $55,  $55,  $55,  $55,  $54 
	dc.w $9a,  $aa,  $5a,  $aa,  $aa,  $a4,  $a9,  $50,  $a5,  $40,  $e5,  $00,  $90,  $00,  $40,  $00 
	dc.w $aa,  $95,  $aa,  $50,  $aa,  $50,  $55,  $43,  $00,  $3f,  $54,  $ff,  $53,  $ff,  $03,  $ff 
	dc.w $ff,  $d5,  $ff,  $50,  $fd,  $42,  $f5,  $0a,  $d4,  $2a,  $54,  $2a,  $40,  $aa,  $42,  $aa 
	dc.w $ff,  $c1,  $fc,  $05,  $f0,  $05,  $c0,  $56,  $01,  $5a,  $05,  $6a,  $05,  $aa,  $56,  $aa 
	dc.w $ff,  $01,  $fc,  $05,  $fc,  $15,  $c0,  $56,  $01,  $5a,  $05,  $6a,  $15,  $aa,  $56,  $aa 
	dc.w $00,  $57,  $05,  $7e,  $15,  $fa,  $5f,  $a9,  $7e,  $a4,  $fa,  $91,  $ea,  $45,  $ab,  $04 
	dc.w $65,  $d7,  $97,  $5e,  $7d,  $f8,  $d7,  $40,  $5e,  $00,  $78,  $02,  $e0,  $0a,  $80,  $2a 
	dc.w $ac,  $03,  $00,  $39,  $02,  $95,  $39,  $d5,  $ed,  $55,  $b5,  $55,  $d5,  $55,  $55,  $55 
	dc.w $3e,  $a5,  $00,  $0e,  $03,  $f0,  $03,  $c3,  $30,  $e9,  $0e,  $55,  $25,  $56,  $95,  $57 
	dc.w $ff,  $00,  $cf,  $c0,  $9f,  $f0,  $69,  $f0,  $da,  $f0,  $6a,  $fc,  $aa,  $fc,  $9a,  $fc 
	dc.w $fa,  $55,  $3e,  $95,  $0e,  $a5,  $0f,  $a5,  $03,  $e9,  $03,  $e9,  $00,  $f9,  $00,  $fa 
	dc.w $97,  $f0,  $97,  $f0,  $a5,  $f0,  $a5,  $fc,  $a9,  $7c,  $a9,  $7c,  $aa,  $7f,  $aa,  $5f 
	dc.w $f0,  $56,  $f0,  $56,  $f0,  $1a,  $fc,  $1a,  $ff,  $1a,  $fc,  $16,  $ff,  $16,  $ff,  $16 
	dc.w $6a,  $ff,  $1a,  $ff,  $2a,  $bf,  $29,  $bf,  $2a,  $bf,  $1a,  $af,  $1a,  $af,  $1a,  $af 
	dc.w $ff,  $e9,  $ff,  $e5,  $ff,  $91,  $e9,  $50,  $e9,  $50,  $e9,  $50,  $94,  $40,  $94,  $40 
	dc.w $8f,  $fb,  $8f,  $ff,  $8f,  $c0,  $03,  $15,  $03,  $15,  $03,  $15,  $c0,  $55,  $c5,  $55 
	dc.w $ff,  $e8,  $fa,  $a1,  $ea,  $05,  $e8,  $15,  $e0,  $55,  $a1,  $55,  $81,  $55,  $05,  $55 
	dc.w $aa,  $81,  $aa,  $05,  $a0,  $17,  $a0,  $5f,  $81,  $5f,  $05,  $7f,  $05,  $ff,  $17,  $ff 
	dc.w $aa,  $fd,  $aa,  $f5,  $ab,  $d4,  $af,  $50,  $bd,  $50,  $f5,  $40,  $f5,  $00,  $d4,  $00 
	dc.w $00,  $af,  $02,  $bd,  $0a,  $f5,  $2b,  $d5,  $af,  $57,  $bf,  $54,  $fd,  $58,  $f5,  $70 
	dc.w $f4,  $51,  $f1,  $46,  $d5,  $4a,  $45,  $3a,  $14,  $ea,  $51,  $aa,  $52,  $aa,  $4e,  $ab 
	dc.w $00,  $7f,  $02,  $6f,  $09,  $ff,  $06,  $ff,  $1a,  $ff,  $9a,  $ff,  $6a,  $fe,  $75,  $f5 
	dc.w $6a,  $54,  $5a,  $9b,  $6a,  $6f,  $5a,  $4f,  $59,  $bf,  $55,  $3f,  $66,  $ff,  $58,  $ff 
	dc.w $7f,  $f6,  $ff,  $ff,  $ff,  $ff,  $ff,  $3f,  $ff,  $ff,  $ff,  $5f,  $f3,  $ac,  $f6,  $a9 
	dc.w $ff,  $a9,  $0f,  $69,  $4f,  $6a,  $af,  $60,  $9f,  $60,  $9c,  $60,  $9c,  $60,  $9f,  $63 
	dc.w $5d,  $40,  $7f,  $40,  $ff,  $50,  $eb,  $50,  $ab,  $d0,  $aa,  $d4,  $aa,  $d4,  $aa,  $f4 
	dc.w $d4,  $2a,  $f4,  $2a,  $f5,  $0a,  $f5,  $0a,  $f5,  $0a,  $fd,  $42,  $fd,  $42,  $fd,  $42 
	dc.w $2a,  $f5,  $0a,  $fd,  $0a,  $bd,  $02,  $bd,  $02,  $bd,  $02,  $bd,  $02,  $bd,  $02,  $bd 
	dc.w $1a,  $af,  $06,  $af,  $06,  $af,  $06,  $aa,  $06,  $a6,  $06,  $a6,  $01,  $aa,  $00,  $aa 
	dc.w $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $15,  $55,  $15,  $55 
	dc.w $97,  $50,  $57,  $54,  $57,  $54,  $57,  $54,  $5f,  $dc,  $5c,  $f0,  $5c,  $00,  $ff,  $00 
	dc.w $5f,  $e8,  $5f,  $a8,  $5f,  $a0,  $5e,  $80,  $7e,  $80,  $fe,  $00,  $fa,  $00,  $f8,  $00 
	dc.w $00,  $d5,  $0f,  $d6,  $3f,  $5a,  $3f,  $5a,  $3d,  $6a,  $f5,  $6a,  $f5,  $aa,  $d6,  $aa 
	dc.w $ab,  $f0,  $ab,  $c1,  $ab,  $c1,  $af,  $05,  $bc,  $05,  $bc,  $15,  $f0,  $15,  $f0,  $55 
	dc.w $aa,  $50,  $a9,  $40,  $a9,  $43,  $a5,  $0f,  $95,  $0f,  $94,  $3f,  $50,  $3f,  $50,  $ff 
	dc.w $fe,  $c0,  $fe,  $00,  $fb,  $01,  $e8,  $00,  $b0,  $05,  $80,  $3a,  $d0,  $6a,  $d0,  $14 
	dc.w $05,  $58,  $e5,  $58,  $1a,  $0f,  $3f,  $c0,  $25,  $55,  $56,  $a0,  $3f,  $ff,  $28,  $95 
	dc.w $ff,  $ff,  $ea,  $fe,  $55,  $b9,  $09,  $aa,  $01,  $95,  $f2,  $70,  $72,  $40,  $22,  $7f 
	dc.w $5f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $aa,  $ff,  $01,  $7a,  $00,  $00,  $00,  $00 
	dc.w $a3,  $fc,  $a1,  $fe,  $aa,  $fd,  $aa,  $3f,  $aa,  $8f,  $0a,  $a1,  $da,  $a4,  $f6,  $aa 
	dc.w $9f,  $1b,  $8b,  $5b,  $27,  $8b,  $26,  $9b,  $c9,  $5b,  $f1,  $57,  $bc,  $66,  $7f,  $81 
	dc.w $65,  $0f,  $a5,  $0f,  $a9,  $0f,  $a9,  $0f,  $a9,  $0f,  $a9,  $4f,  $a9,  $43,  $aa,  $43 
	dc.w $e9,  $40,  $ea,  $50,  $fa,  $50,  $fa,  $50,  $fa,  $54,  $fa,  $54,  $fa,  $94,  $fe,  $94 
	dc.w $a0,  $d5,  $a0,  $f5,  $a0,  $fd,  $a0,  $3d,  $a8,  $3d,  $a8,  $3d,  $a8,  $3d,  $a8,  $3d 
	dc.w $05,  $ff,  $01,  $ff,  $01,  $ff,  $01,  $ff,  $01,  $bf,  $00,  $bf,  $00,  $6f,  $00,  $6f 
	dc.w $15,  $55,  $05,  $55,  $05,  $55,  $05,  $55,  $05,  $55,  $05,  $55,  $05,  $55,  $05,  $55 
	dc.w $aa,  $51,  $aa,  $50,  $aa,  $80,  $aa,  $80,  $aa,  $80,  $aa,  $40,  $b9,  $00,  $b9,  $00 
	dc.w $f4,  $02,  $f4,  $0a,  $d4,  $0a,  $d4,  $0a,  $d4,  $2a,  $d4,  $aa,  $54,  $aa,  $54,  $aa 
	dc.w $02,  $a9,  $02,  $a9,  $0a,  $a5,  $aa,  $a5,  $bd,  $55,  $1f,  $ff,  $07,  $ff,  $03,  $ff 
	dc.w $55,  $0e,  $54,  $0e,  $54,  $3a,  $54,  $fa,  $50,  $ea,  $03,  $ea,  $ff,  $ef,  $ff,  $ff 
	dc.w $03,  $ea,  $0f,  $eb,  $0f,  $a8,  $3f,  $a8,  $3e,  $a8,  $3f,  $fc,  $55,  $55,  $55,  $51 
	dc.w $70,  $02,  $c0,  $02,  $c0,  $0c,  $c0,  $06,  $c0,  $01,  $40,  $00,  $00,  $03,  $5f,  $ff 
	dc.w $03,  $00,  $a9,  $ff,  $aa,  $a9,  $95,  $55,  $55,  $55,  $55,  $ff,  $fd,  $80,  $a0,  $00 
	dc.w $11,  $d5,  $c1,  $95,  $9a,  $aa,  $69,  $aa,  $aa,  $aa,  $a9,  $69,  $00,  $7f,  $00,  $00 
	dc.w $aa,  $aa,  $ff,  $fe,  $0f,  $f0,  $ff,  $ff,  $0f,  $ff,  $ff,  $fc,  $5f,  $f3,  $a5,  $43 
	dc.w $a9,  $55,  $a9,  $55,  $55,  $56,  $5a,  $aa,  $7f,  $aa,  $02,  $fe,  $40,  $02,  $7e,  $00 
	dc.w $35,  $7e,  $8d,  $5f,  $8d,  $5f,  $a3,  $57,  $a8,  $d5,  $aa,  $35,  $0a,  $8b,  $70,  $a2 
	dc.w $00,  $fe,  $00,  $fe,  $40,  $fe,  $40,  $fe,  $54,  $3e,  $54,  $3e,  $54,  $3e,  $14,  $fe 
	dc.w $fa,  $54,  $fa,  $54,  $fa,  $54,  $fa,  $94,  $fa,  $54,  $fa,  $94,  $fa,  $94,  $fa,  $94 
	dc.w $a0,  $17,  $a0,  $17,  $a0,  $17,  $a8,  $57,  $a8,  $17,  $a8,  $17,  $a8,  $17,  $a8,  $17 
	dc.w $05,  $bf,  $05,  $af,  $05,  $af,  $05,  $af,  $05,  $bf,  $05,  $ab,  $04,  $6b,  $05,  $6b 
	dc.w $46,  $aa,  $46,  $aa,  $46,  $aa,  $46,  $aa,  $46,  $aa,  $56,  $aa,  $55,  $aa,  $55,  $aa 
	dc.w $41,  $ff,  $8a,  $ff,  $89,  $ff,  $aa,  $7f,  $aa,  $5f,  $aa,  $5f,  $6a,  $5f,  $55,  $7f 
	dc.w $d4,  $0a,  $d4,  $0a,  $d4,  $0a,  $d4,  $0a,  $d4,  $0a,  $d4,  $0a,  $d5,  $0a,  $d5,  $0a 
	dc.w $03,  $55,  $30,  $d5,  $3f,  $35,  $3a,  $bd,  $3a,  $ab,  $3a,  $aa,  $3a,  $a5,  $3a,  $a9 
	dc.w $aa,  $a0,  $aa,  $aa,  $a8,  $55,  $aa,  $15,  $ca,  $81,  $fc,  $a8,  $ff,  $2a,  $ff,  $ca 
	dc.w $55,  $55,  $40,  $00,  $bf,  $ff,  $ea,  $aa,  $ba,  $aa,  $4b,  $ea,  $54,  $bf,  $55,  $42 
	dc.w $02,  $a7,  $57,  $f5,  $ff,  $d8,  $f5,  $58,  $f8,  $00,  $f4,  $a0,  $fc,  $15,  $fd,  $0a 
	dc.w $00,  $00,  $3f,  $ff,  $af,  $eb,  $ea,  $ae,  $80,  $54,  $f1,  $55,  $09,  $56,  $b8,  $52 
	dc.w $55,  $7f,  $ff,  $89,  $00,  $0a,  $a3,  $aa,  $cd,  $ff,  $37,  $ea,  $b0,  $0a,  $a5,  $54 
	dc.w $00,  $6a,  $00,  $1e,  $bf,  $ea,  $55,  $aa,  $01,  $aa,  $6f,  $aa,  $aa,  $aa,  $ed,  $7a 
	dc.w $5c,  $1a,  $fd,  $42,  $ff,  $d4,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	dc.w $fe,  $50,  $bf,  $85,  $4b,  $fe,  $06,  $ff,  $01,  $6f,  $00,  $13,  $00,  $12,  $00,  $6f 
	dc.w $3f,  $c1,  $03,  $c1,  $54,  $00,  $ac,  $40,  $aa,  $80,  $aa,  $90,  $aa,  $41,  $a9,  $05 
	dc.w $a8,  $07,  $a8,  $07,  $a8,  $17,  $aa,  $17,  $a8,  $17,  $90,  $17,  $7d,  $57,  $74,  $1f 
	dc.w $a8,  $17,  $a8,  $17,  $a8,  $17,  $a8,  $17,  $a0,  $57,  $a0,  $57,  $a0,  $17,  $a0,  $17 
	dc.w $05,  $6b,  $05,  $6b,  $05,  $6b,  $05,  $6b,  $05,  $6f,  $05,  $6f,  $05,  $6f,  $05,  $6b 
	dc.w $00,  $55,  $00,  $55,  $00,  $55,  $00,  $55,  $00,  $55,  $00,  $55,  $00,  $55,  $00,  $55 
	dc.w $aa,  $80,  $ea,  $80,  $ea,  $50,  $ea,  $a4,  $ea,  $a8,  $f9,  $a9,  $fe,  $a9,  $ff,  $a9 
	dc.w $fa,  $15,  $fa,  $85,  $fa,  $05,  $fa,  $85,  $fa,  $85,  $fe,  $81,  $ff,  $81,  $ff,  $81 
	dc.w $7c,  $0a,  $7c,  $2a,  $7f,  $2a,  $7f,  $0a,  $5f,  $0a,  $5f,  $0a,  $57,  $0a,  $57,  $c2 
	dc.w $c0,  $06,  $c1,  $56,  $f1,  $6a,  $f1,  $6a,  $f1,  $6a,  $f0,  $6a,  $f0,  $5a,  $f0,  $5a 
	dc.w $aa,  $aa,  $00,  $2a,  $01,  $55,  $05,  $7f,  $15,  $7f,  $17,  $fd,  $17,  $fe,  $05,  $f2 
	dc.w $7f,  $48,  $0a,  $9d,  $6a,  $7c,  $d2,  $f4,  $63,  $d4,  $8f,  $56,  $a5,  $a9,  $aa,  $aa 
	dc.w $a0,  $e5,  $54,  $ba,  $7c,  $ba,  $bc,  $7e,  $78,  $be,  $50,  $bf,  $00,  $bf,  $00,  $69 
	dc.w $c5,  $4e,  $2f,  $f1,  $54,  $14,  $55,  $5b,  $5a,  $be,  $53,  $aa,  $2a,  $aa,  $ea,  $aa 
	dc.w $6f,  $1b,  $6f,  $0b,  $9d,  $07,  $7d,  $42,  $f5,  $42,  $fd,  $42,  $7f,  $83,  $55,  $ef 
	dc.w $ff,  $fc,  $93,  $eb,  $d4,  $ec,  $d6,  $32,  $a5,  $0f,  $e5,  $8c,  $29,  $4d,  $f2,  $6d 
	dc.w $05,  $ea,  $5e,  $ab,  $ea,  $b5,  $ed,  $50,  $54,  $00,  $03,  $fc,  $ff,  $f0,  $ff,  $c0 
	dc.w $59,  $4f,  $05,  $3f,  $50,  $bf,  $52,  $bf,  $42,  $ab,  $4a,  $aa,  $00,  $2b,  $50,  $ab 
	dc.w $00,  $0d,  $2a,  $3d,  $a8,  $3d,  $a8,  $3d,  $a0,  $f5,  $a0,  $f5,  $a0,  $f5,  $83,  $d5 
	dc.w $ff,  $58,  $ff,  $68,  $fd,  $68,  $fd,  $68,  $f5,  $68,  $f5,  $68,  $f5,  $a0,  $d5,  $a0 
	dc.w $05,  $6a,  $00,  $6a,  $00,  $5a,  $00,  $ab,  $15,  $af,  $14,  $af,  $15,  $bf,  $16,  $bf 
	dc.w $55,  $aa,  $15,  $aa,  $15,  $aa,  $55,  $aa,  $55,  $aa,  $55,  $aa,  $55,  $aa,  $55,  $aa 
	dc.w $f5,  $54,  $f5,  $54,  $f5,  $55,  $fa,  $95,  $ff,  $91,  $ff,  $91,  $ff,  $91,  $ff,  $a5 
	dc.w $3f,  $95,  $0f,  $95,  $03,  $95,  $03,  $e5,  $03,  $e5,  $03,  $e5,  $00,  $f9,  $00,  $39 
	dc.w $f0,  $2a,  $fc,  $2a,  $7c,  $2a,  $7f,  $0a,  $5f,  $0a,  $5f,  $0a,  $5f,  $02,  $5f,  $c2 
	dc.w $01,  $aa,  $c1,  $6a,  $c1,  $6a,  $f0,  $6a,  $f0,  $5a,  $fc,  $5a,  $fc,  $16,  $fc,  $16 
	dc.w $50,  $fa,  $94,  $c4,  $94,  $3f,  $94,  $3f,  $a5,  $3f,  $a5,  $0f,  $a9,  $0f,  $a9,  $4d 
	dc.w $55,  $51,  $a1,  $4b,  $95,  $7f,  $94,  $fe,  $a2,  $fd,  $97,  $f4,  $4b,  $91,  $1e,  $13 
	dc.w $fd,  $00,  $fd,  $7a,  $f5,  $7b,  $55,  $50,  $45,  $56,  $3b,  $1a,  $ad,  $3a,  $a5,  $6a 
	dc.w $5f,  $c0,  $26,  $b0,  $55,  $58,  $c2,  $95,  $0f,  $ff,  $3b,  $ff,  $2f,  $ff,  $ff,  $ff 
	dc.w $bc,  $15,  $aa,  $f1,  $ea,  $ab,  $54,  $0f,  $01,  $15,  $00,  $a1,  $03,  $ad,  $03,  $b8 
	dc.w $aa,  $ab,  $ea,  $90,  $29,  $a0,  $0d,  $1d,  $db,  $5f,  $7a,  $e4,  $69,  $40,  $ed,  $00 
	dc.w $28,  $05,  $aa,  $85,  $aa,  $85,  $2a,  $07,  $2a,  $1f,  $80,  $5f,  $15,  $7f,  $55,  $7f 
	dc.w $ff,  $a5,  $fe,  $95,  $fe,  $94,  $fa,  $94,  $fa,  $54,  $ea,  $50,  $e9,  $40,  $a5,  $40 
	dc.w $55,  $0a,  $54,  $2b,  $54,  $2b,  $50,  $2b,  $50,  $af,  $42,  $bf,  $42,  $bf,  $0a,  $bf 
	dc.w $aa,  $b0,  $aa,  $f1,  $aa,  $c1,  $ab,  $f1,  $af,  $c1,  $ac,  $05,  $af,  $00,  $ac,  $01 
	dc.w $01,  $bf,  $01,  $bf,  $01,  $bf,  $00,  $6f,  $01,  $bf,  $01,  $ff,  $06,  $bf,  $1a,  $af 
	dc.w $05,  $55,  $05,  $55,  $05,  $55,  $05,  $55,  $05,  $55,  $05,  $55,  $05,  $55,  $05,  $55 
	dc.w $ad,  $50,  $aa,  $50,  $aa,  $94,  $aa,  $a4,  $e5,  $a9,  $ea,  $aa,  $ff,  $aa,  $ff,  $aa 
	dc.w $55,  $ff,  $95,  $3f,  $94,  $0f,  $94,  $0f,  $aa,  $43,  $aa,  $43,  $aa,  $54,  $aa,  $55 
	dc.w $0f,  $55,  $0f,  $d5,  $03,  $d5,  $83,  $d5,  $a0,  $f5,  $a8,  $3d,  $aa,  $0d,  $aa,  $0f 
	dc.w $5f,  $aa,  $1f,  $aa,  $17,  $ea,  $17,  $ea,  $05,  $fa,  $05,  $fe,  $01,  $7e,  $01,  $7f 
	dc.w $6b,  $fe,  $5b,  $fd,  $5a,  $fd,  $16,  $fd,  $06,  $b8,  $05,  $b9,  $01,  $6a,  $00,  $6a 
	dc.w $28,  $8f,  $a2,  $1f,  $aa,  $1f,  $aa,  $3f,  $9a,  $3f,  $5a,  $1f,  $96,  $1f,  $96,  $af 
	dc.w $17,  $40,  $9f,  $82,  $5f,  $82,  $5f,  $82,  $5f,  $82,  $5f,  $82,  $5f,  $42,  $5f,  $c2 
	dc.w $35,  $55,  $35,  $55,  $25,  $55,  $25,  $56,  $25,  $55,  $25,  $56,  $25,  $56,  $15,  $58 
	dc.w $a9,  $45,  $a9,  $75,  $a9,  $bc,  $a5,  $cf,  $a4,  $c0,  $9b,  $03,  $93,  $0c,  $9c,  $3e 
	dc.w $ff,  $a9,  $bf,  $6a,  $bc,  $da,  $ff,  $f5,  $05,  $51,  $6a,  $40,  $a5,  $0c,  $a5,  $40 
	dc.w $aa,  $5f,  $a9,  $5f,  $a9,  $7c,  $a9,  $fc,  $a5,  $f0,  $57,  $c0,  $57,  $00,  $5f,  $00 
	dc.w $55,  $0f,  $55,  $0f,  $54,  $3e,  $50,  $fe,  $50,  $fa,  $43,  $ea,  $03,  $aa,  $0f,  $aa 
	dc.w $ff,  $d6,  $ff,  $5a,  $fd,  $5a,  $fd,  $6a,  $f5,  $68,  $d5,  $a8,  $d6,  $80,  $5a,  $80 
	dc.w $ff,  $16,  $fc,  $41,  $f1,  $55,  $c5,  $66,  $c5,  $6a,  $c5,  $5a,  $15,  $5a,  $50,  $6a 
	dc.w $15,  $5a,  $06,  $aa,  $06,  $aa,  $5a,  $aa,  $1a,  $aa,  $2a,  $aa,  $aa,  $aa,  $aa,  $af 
	dc.w $05,  $55,  $15,  $55,  $15,  $55,  $15,  $55,  $15,  $55,  $15,  $55,  $15,  $55,  $55,  $55 
	dc.w $55,  $54,  $55,  $54,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55 
	dc.w $aa,  $00,  $ae,  $40,  $ea,  $90,  $ea,  $a0,  $ea,  $90,  $fa,  $a4,  $fa,  $a8,  $fa,  $aa 
	dc.w $0f,  $aa,  $03,  $aa,  $03,  $aa,  $03,  $ea,  $54,  $ea,  $54,  $fa,  $54,  $3a,  $55,  $0e 
	dc.w $a0,  $55,  $e8,  $55,  $e8,  $15,  $ea,  $15,  $fa,  $15,  $fe,  $05,  $fe,  $81,  $fe,  $a0 
	dc.w $15,  $aa,  $05,  $aa,  $c1,  $6a,  $c1,  $6a,  $f0,  $5a,  $fc,  $16,  $fc,  $16,  $ff,  $05 
	dc.w $1c,  $2f,  $5d,  $2f,  $5f,  $0b,  $57,  $4b,  $15,  $42,  $05,  $52,  $81,  $50,  $80,  $54 
	dc.w $f0,  $6a,  $b1,  $7a,  $b1,  $0a,  $bc,  $1e,  $a0,  $1e,  $2d,  $03,  $79,  $00,  $1b,  $40 
	dc.w $0c,  $0d,  $dc,  $00,  $9c,  $37,  $b0,  $07,  $b7,  $0d,  $a4,  $0d,  $a1,  $cd,  $e9,  $01 
	dc.w $a7,  $d2,  $87,  $7a,  $97,  $48,  $9d,  $e0,  $7d,  $20,  $7f,  $00,  $7f,  $00,  $7c,  $00 
	dc.w $aa,  $94,  $aa,  $90,  $a9,  $40,  $a5,  $43,  $a5,  $0f,  $94,  $3f,  $50,  $ff,  $40,  $ff 
	dc.w $55,  $a8,  $55,  $a0,  $56,  $83,  $5a,  $83,  $5a,  $0f,  $68,  $0f,  $a0,  $3f,  $a3,  $ff 
	dc.w $00,  $3d,  $00,  $f5,  $03,  $d5,  $03,  $56,  $0f,  $56,  $3d,  $5a,  $3d,  $6a,  $f5,  $aa 
	dc.w $ff,  $c5,  $ff,  $05,  $f0,  $16,  $f0,  $5a,  $c1,  $aa,  $c5,  $aa,  $19,  $aa,  $69,  $aa 
	dc.w $00,  $1a,  $00,  $1a,  $01,  $6a,  $05,  $aa,  $1a,  $aa,  $5a,  $96,  $6a,  $aa,  $aa,  $ab 
	dc.w $00,  $05,  $00,  $05,  $00,  $05,  $01,  $15,  $01,  $55,  $55,  $55,  $55,  $55,  $55,  $55 
	dc.w $a9,  $55,  $a9,  $15,  $a9,  $15,  $aa,  $55,  $aa,  $55,  $aa,  $55,  $aa,  $55,  $aa,  $55 
	dc.w $94,  $0f,  $90,  $0f,  $91,  $5f,  $91,  $53,  $95,  $57,  $a9,  $54,  $aa,  $54,  $aa,  $54 
	dc.w $52,  $aa,  $50,  $aa,  $54,  $2a,  $d4,  $0a,  $f4,  $0a,  $f5,  $02,  $fd,  $42,  $fd,  $50 
	dc.w $f2,  $aa,  $f0,  $aa,  $f0,  $2a,  $7c,  $2a,  $7f,  $0a,  $5f,  $02,  $57,  $c0,  $57,  $f0 
	dc.w $a0,  $00,  $68,  $00,  $5a,  $00,  $d6,  $80,  $d5,  $a8,  $f5,  $5a,  $fd,  $56,  $ff,  $d5 
	dc.w $eb,  $d5,  $f6,  $56,  $e5,  $55,  $eb,  $55,  $ea,  $95,  $58,  $17,  $a8,  $07,  $08,  $02 
	dc.w $d4,  $03,  $c5,  $03,  $b5,  $02,  $bd,  $42,  $f8,  $5f,  $ee,  $12,  $fb,  $82,  $ff,  $e3 
	dc.w $f0,  $00,  $f0,  $c0,  $ff,  $c0,  $fd,  $7f,  $f6,  $55,  $fa,  $55,  $3a,  $9a,  $fa,  $9a 
	dc.w $ff,  $e9,  $ff,  $a5,  $fe,  $a5,  $fa,  $94,  $ea,  $50,  $a9,  $50,  $a5,  $40,  $54,  $00 
	dc.w $aa,  $97,  $aa,  $9f,  $aa,  $5f,  $a9,  $7c,  $a9,  $f0,  $a5,  $f0,  $97,  $c0,  $5f,  $c0 
	dc.w $56,  $a0,  $56,  $80,  $5a,  $83,  $5a,  $03,  $5a,  $00,  $6a,  $0f,  $68,  $0f,  $a0,  $33 
	dc.w $00,  $06,  $00,  $0a,  $00,  $5a,  $01,  $aa,  $06,  $a6,  $1a,  $a6,  $1a,  $aa,  $0a,  $ab 
	dc.w $50,  $6a,  $55,  $6a,  $55,  $aa,  $6a,  $aa,  $aa,  $aa,  $6a,  $aa,  $aa,  $aa,  $aa,  $aa 
	dc.w $ff,  $aa,  $ff,  $ea,  $ff,  $fa,  $ff,  $fa,  $ff,  $fa,  $ff,  $fe,  $ff,  $fe,  $f5,  $4e 
	dc.w $a4,  $00,  $e9,  $00,  $a9,  $00,  $a9,  $00,  $a9,  $00,  $aa,  $90,  $aa,  $90,  $aa,  $90 
	dc.w $03,  $ff,  $40,  $ff,  $90,  $ff,  $90,  $3f,  $95,  $0f,  $69,  $4f,  $69,  $43,  $69,  $40 
	dc.w $29,  $55,  $2a,  $55,  $0a,  $95,  $02,  $a5,  $f0,  $a9,  $fc,  $2a,  $ff,  $0a,  $ff,  $02 
	dc.w $15,  $55,  $01,  $55,  $c0,  $55,  $f0,  $05,  $ff,  $01,  $af,  $c0,  $ab,  $fc,  $aa,  $bf 
	dc.w $aa,  $a2,  $2a,  $a8,  $02,  $a8,  $c0,  $0a,  $ff,  $00,  $5f,  $ff,  $55,  $ff,  $55,  $5d 
	dc.w $55,  $55,  $b5,  $55,  $ad,  $55,  $a2,  $d5,  $a8,  $25,  $aa,  $03,  $aa,  $80,  $aa,  $80 
	dc.w $5e,  $ff,  $5e,  $ff,  $5c,  $fe,  $5c,  $aa,  $56,  $2a,  $57,  $2a,  $35,  $08,  $09,  $c0 
	dc.w $55,  $68,  $55,  $a8,  $5a,  $a0,  $6a,  $00,  $aa,  $03,  $a0,  $03,  $88,  $f3,  $2f,  $6f 
	dc.w $aa,  $81,  $aa,  $85,  $aa,  $05,  $a8,  $15,  $a0,  $17,  $80,  $5f,  $01,  $7f,  $15,  $7f 
	dc.w $fc,  $52,  $fc,  $56,  $fc,  $16,  $f1,  $56,  $f1,  $96,  $f1,  $aa,  $01,  $aa,  $15,  $aa 
	dc.w $15,  $56,  $55,  $56,  $54,  $6a,  $54,  $5a,  $55,  $6a,  $1a,  $aa,  $1a,  $aa,  $56,  $aa 
	dc.w $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $a9,  $aa,  $a8,  $aa,  $ab 
	dc.w $00,  $00,  $00,  $50,  $01,  $39,  $06,  $f9,  $1f,  $f9,  $0f,  $fc,  $1f,  $fe,  $1b,  $ff 
	dc.w $76,  $56,  $76,  $56,  $b6,  $55,  $b5,  $d9,  $97,  $59,  $24,  $d5,  $21,  $f5,  $c5,  $f5 
	dc.w $55,  $55,  $95,  $6a,  $a5,  $a5,  $a9,  $94,  $aa,  $53,  $aa,  $4f,  $a8,  $4f,  $aa,  $8f 
	dc.w $a5,  $55,  $58,  $55,  $87,  $45,  $bf,  $25,  $fd,  $2a,  $fe,  $2a,  $f4,  $aa,  $f4,  $aa 
	dc.w $3f,  $ff,  $0f,  $ff,  $00,  $ff,  $a0,  $0f,  $6a,  $80,  $5a,  $a0,  $55,  $6a,  $55,  $6d 
	dc.w $ff,  $ff,  $bf,  $ff,  $aa,  $bf,  $6a,  $aa,  $55,  $aa,  $15,  $55,  $65,  $55,  $01,  $15 
	dc.w $aa,  $aa,  $aa,  $aa,  $02,  $a8,  $00,  $00,  $55,  $55,  $55,  $55,  $f5,  $5d,  $f4,  $ff 
	dc.w $c5,  $f3,  $c2,  $61,  $f0,  $97,  $fc,  $27,  $00,  $09,  $00,  $08,  $00,  $a8,  $05,  $a8 
	dc.w $78,  $2d,  $c0,  $2d,  $00,  $ad,  $82,  $af,  $e2,  $9f,  $52,  $af,  $d2,  $af,  $d0,  $af 
	dc.w $54,  $00,  $54,  $05,  $14,  $1f,  $11,  $7a,  $04,  $ea,  $11,  $aa,  $01,  $aa,  $07,  $6b 
	dc.w $55,  $6a,  $55,  $6a,  $15,  $6a,  $d5,  $6a,  $25,  $aa,  $0d,  $6a,  $3a,  $aa,  $fa,  $a9 
	dc.w $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $eb,  $ff,  $f7,  $6a,  $41,  $6b 
	dc.w $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $f5,  $5c,  $de,  $dc 
	dc.w $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $72,  $aa,  $52,  $aa 
	dc.w $aa,  $a9,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $a8 
	dc.w $ce,  $6a,  $cc,  $5a,  $cf,  $5a,  $cc,  $5a,  $ce,  $5a,  $ce,  $6a,  $3d,  $68,  $31,  $63 
	dc.w $8f,  $ff,  $63,  $ff,  $53,  $ff,  $58,  $ff,  $56,  $3f,  $55,  $cf,  $55,  $73,  $95,  $5c 
	dc.w $55,  $5a,  $55,  $3a,  $55,  $3a,  $55,  $2a,  $55,  $6a,  $54,  $ea,  $54,  $a6,  $42,  $b3 
	dc.w $0b,  $55,  $0b,  $55,  $0b,  $55,  $03,  $d5,  $01,  $d5,  $02,  $d5,  $02,  $d5,  $00,  $d7 
	dc.w $ff,  $f7,  $ff,  $70,  $fd,  $80,  $f6,  $08,  $d8,  $96,  $60,  $dd,  $40,  $d7,  $c0,  $9a 
	dc.w $a0,  $80,  $56,  $00,  $55,  $00,  $55,  $b0,  $56,  $3e,  $58,  $c0,  $63,  $f0,  $bf,  $c0 
	dc.w $01,  $00,  $17,  $a1,  $4a,  $a1,  $ea,  $a3,  $fa,  $ff,  $5e,  $fd,  $1e,  $f1,  $1e,  $f1 
	dc.w $df,  $3f,  $6a,  $cf,  $aa,  $9f,  $aa,  $83,  $aa,  $c3,  $6b,  $50,  $3d,  $03,  $14,  $40 
	dc.w $4a,  $f4,  $4a,  $f5,  $4a,  $f5,  $4a,  $f5,  $4a,  $f5,  $4a,  $f5,  $4a,  $f5,  $4a,  $f5 
	dc.w $aa,  $82,  $aa,  $35,  $a0,  $55,  $ad,  $55,  $8f,  $55,  $a0,  $d7,  $aa,  $d7,  $a8,  $95 
	dc.w $df,  $f0,  $9f,  $c5,  $93,  $12,  $bc,  $6a,  $8f,  $2a,  $87,  $d6,  $87,  $c6,  $87,  $c4 
	dc.w $be,  $aa,  $17,  $bb,  $54,  $be,  $50,  $b8,  $40,  $a1,  $40,  $b5,  $40,  $c3,  $40,  $0a 
	dc.w $45,  $04,  $3a,  $c4,  $ea,  $91,  $aa,  $d1,  $ab,  $f0,  $ff,  $f0,  $7f,  $f0,  $1f,  $f4 
	dc.w $82,  $aa,  $a2,  $aa,  $62,  $aa,  $62,  $aa,  $2a,  $aa,  $ea,  $aa,  $ea,  $aa,  $ea,  $aa 
	dc.w $aa,  $aa,  $aa,  $aa,  $aa,  $24,  $aa,  $24,  $aa,  $24,  $aa,  $27,  $aa,  $27,  $aa,  $27 
	dc.w $1b,  $f9,  $1f,  $f9,  $1f,  $f9,  $0f,  $e9,  $0f,  $a1,  $6f,  $84,  $6e,  $50,  $69,  $00 
	dc.w $2a,  $a9,  $da,  $aa,  $36,  $aa,  $0d,  $a9,  $03,  $55,  $00,  $c4,  $00,  $3f,  $00,  $00 
	dc.w $fa,  $82,  $aa,  $d2,  $ab,  $33,  $ac,  $54,  $b1,  $5c,  $45,  $5c,  $15,  $5d,  $55,  $5f 
	dc.w $aa,  $44,  $aa,  $c4,  $aa,  $c4,  $aa,  $d1,  $eb,  $f1,  $ef,  $d1,  $7d,  $05,  $34,  $01 
	dc.w $d5,  $8b,  $d5,  $70,  $d5,  $6c,  $25,  $56,  $3a,  $a5,  $0e,  $aa,  $03,  $aa,  $00,  $3f 
	dc.w $bf,  $c0,  $00,  $00,  $ba,  $c0,  $01,  $70,  $55,  $30,  $56,  $80,  $5a,  $f0,  $2f,  $f0 
	dc.w $e0,  $06,  $e0,  $06,  $e4,  $06,  $e4,  $06,  $e4,  $16,  $e4,  $5e,  $e4,  $6b,  $ff,  $af 
	dc.w $ff,  $c2,  $04,  $5a,  $0a,  $66,  $05,  $56,  $35,  $56,  $f1,  $02,  $f1,  $02,  $c1,  $01 
	dc.w $da,  $a3,  $da,  $a3,  $da,  $a3,  $da,  $93,  $da,  $53,  $da,  $4c,  $d9,  $fc,  $03,  $f0 
	dc.w $ab,  $15,  $ab,  $15,  $ab,  $15,  $ab,  $15,  $ab,  $15,  $ab,  $14,  $ab,  $12,  $aa,  $8f 
	dc.w $1e,  $5c,  $1e,  $9c,  $1d,  $5c,  $0d,  $59,  $1d,  $59,  $3a,  $59,  $fa,  $5a,  $ba,  $59 
	dc.w $aa,  $b3,  $aa,  $4f,  $a9,  $3f,  $ab,  $3f,  $a4,  $ff,  $a0,  $ff,  $93,  $ff,  $93,  $ff 
	dc.w $3a,  $ac,  $ca,  $a4,  $ca,  $a4,  $ca,  $a4,  $c6,  $94,  $c6,  $9c,  $c6,  $43,  $fd,  $0f 
	dc.w $b3,  $ff,  $43,  $ff,  $a3,  $ff,  $6f,  $ff,  $6f,  $ff,  $63,  $ff,  $63,  $ff,  $63,  $ff 
	dc.w $aa,  $61,  $aa,  $aa,  $aa,  $ab,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa 
	dc.w $e8,  $a0,  $5e,  $81,  $50,  $07,  $55,  $05,  $55,  $55,  $55,  $55,  $55,  $55,  $55,  $55 
	dc.w $56,  $90,  $aa,  $95,  $aa,  $ea,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa 
	dc.w $a8,  $07,  $ab,  $f3,  $fb,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	dc.w $95,  $54,  $09,  $68,  $0a,  $83,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00,  $00 
	dc.w $91,  $ff,  $90,  $0f,  $95,  $03,  $95,  $54,  $95,  $55,  $95,  $55,  $55,  $55,  $55,  $55 
	dc.w $55,  $7c,  $55,  $ff,  $57,  $ff,  $ff,  $bf,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	dc.w $5f,  $3c,  $55,  $c0,  $94,  $0a,  $aa,  $0a,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa 
	dc.w $e9,  $54,  $aa,  $99,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa 
	dc.w $81,  $01,  $a8,  $17,  $b5,  $7f,  $ff,  $7f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	dc.w $a9,  $33,  $6a,  $53,  $aa,  $40,  $aa,  $a2,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa 
	dc.w $01,  $6d,  $03,  $fd,  $7e,  $fc,  $ff,  $fd,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	dc.w $00,  $1a,  $d1,  $6a,  $65,  $6a,  $6a,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa,  $aa 
	dc.w $e5,  $14,  $fb,  $00,  $ec,  $03,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff 
	dc.w $87,  $ff,  $3f,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff,  $ff
    
	ORG $C04000
MERLIN_PAL

    	dc.w $42,  $08,  $00,  $00,  $00,  $00,  $00,  $00,  $42,  $08,  $42,  $08,  $00,  $00,  $00,  $00 
	dc.w $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c 
	dc.w $63,  $0c,  $84,  $10,  $63,  $0c,  $84,  $10,  $a5,  $14,  $c6,  $18,  $a5,  $14,  $84,  $10 
	dc.w $c6,  $18,  $e7,  $1c,  $e7,  $1c,  $08,  $21,  $4a,  $29,  $29,  $25,  $e7,  $1c,  $08,  $21 
	dc.w $29,  $25,  $08,  $21,  $09,  $21,  $2a,  $25,  $29,  $25,  $08,  $21,  $29,  $25,  $08,  $21 
	dc.w $e7,  $1c,  $08,  $21,  $09,  $21,  $c6,  $18,  $a5,  $14,  $c6,  $18,  $84,  $10,  $c6,  $18 
	dc.w $84,  $10,  $84,  $10,  $84,  $10,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c 
	dc.w $42,  $08,  $42,  $08,  $00,  $00,  $00,  $00,  $63,  $0c,  $42,  $08,  $42,  $08,  $00,  $00 
	dc.w $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c 
	dc.w $84,  $10,  $84,  $10,  $84,  $10,  $63,  $0c,  $a5,  $14,  $c6,  $18,  $c6,  $18,  $84,  $10 
	dc.w $e7,  $1c,  $08,  $21,  $29,  $25,  $c6,  $18,  $09,  $25,  $29,  $25,  $6b,  $2d,  $4a,  $29 
	dc.w $31,  $46,  $2a,  $25,  $6c,  $31,  $09,  $21,  $cf,  $3d,  $6c,  $2d,  $6b,  $2d,  $6c,  $31 
	dc.w $6c,  $2d,  $09,  $25,  $2a,  $29,  $6c,  $2d,  $08,  $21,  $4b,  $2d,  $6c,  $31,  $29,  $25 
	dc.w $08,  $21,  $c6,  $18,  $c6,  $18,  $e7,  $1c,  $84,  $10,  $a5,  $14,  $a5,  $14,  $84,  $10 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $84,  $10,  $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $42,  $08,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c 
	dc.w $84,  $10,  $84,  $10,  $63,  $0c,  $63,  $0c,  $a5,  $14,  $a5,  $14,  $84,  $10,  $c6,  $18 
	dc.w $29,  $25,  $08,  $21,  $c6,  $18,  $e7,  $1c,  $29,  $25,  $8c,  $31,  $4a,  $29,  $4b,  $29 
	dc.w $09,  $21,  $29,  $25,  $32,  $46,  $8d,  $35,  $cf,  $3d,  $6b,  $2d,  $6c,  $2d,  $6c,  $2d 
	dc.w $2a,  $29,  $6c,  $2d,  $6c,  $2d,  $09,  $25,  $09,  $25,  $09,  $25,  $4b,  $2d,  $09,  $25 
	dc.w $29,  $25,  $09,  $21,  $29,  $25,  $4b,  $2d,  $e7,  $1c,  $08,  $21,  $29,  $25,  $09,  $25 
	dc.w $a5,  $14,  $c6,  $18,  $a5,  $14,  $c6,  $18,  $84,  $10,  $63,  $0c,  $84,  $10,  $63,  $0c 
	dc.w $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $00,  $00,  $00,  $00 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $84,  $10,  $63,  $0c,  $63,  $0c,  $63,  $0c 
	dc.w $84,  $10,  $a5,  $14,  $a5,  $14,  $84,  $10,  $e7,  $1c,  $08,  $21,  $c6,  $18,  $c6,  $18 
	dc.w $4a,  $29,  $29,  $25,  $08,  $21,  $6b,  $2d,  $29,  $25,  $e8,  $20,  $cd,  $39,  $4a,  $29 
	dc.w $6a,  $2d,  $71,  $4e,  $ef,  $3d,  $a5,  $18,  $ee,  $41,  $e8,  $20,  $4a,  $29,  $8b,  $31 
	dc.w $f0,  $3d,  $2a,  $29,  $08,  $21,  $09,  $25,  $09,  $21,  $2a,  $25,  $09,  $25,  $ce,  $39 
	dc.w $09,  $21,  $09,  $25,  $2a,  $25,  $6b,  $2d,  $29,  $25,  $4a,  $29,  $4a,  $29,  $08,  $21 
	dc.w $a5,  $14,  $c6,  $18,  $c6,  $18,  $e7,  $1c,  $84,  $10,  $63,  $0c,  $84,  $10,  $63,  $0c 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $42,  $08,  $00,  $00,  $00,  $00 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $84,  $10,  $63,  $0c,  $84,  $10,  $63,  $0c 
	dc.w $a5,  $14,  $e7,  $1c,  $a6,  $14,  $29,  $25,  $08,  $21,  $e7,  $1c,  $29,  $25,  $29,  $25 
	dc.w $4a,  $29,  $29,  $25,  $8c,  $31,  $6b,  $2d,  $09,  $25,  $09,  $25,  $2a,  $25,  $09,  $21 
	dc.w $10,  $42,  $29,  $25,  $4b,  $29,  $e8,  $20,  $ce,  $3d,  $2a,  $25,  $09,  $25,  $08,  $21 
	dc.w $09,  $25,  $09,  $21,  $4a,  $29,  $09,  $25,  $8d,  $31,  $09,  $25,  $29,  $25,  $08,  $21 
	dc.w $09,  $21,  $ad,  $35,  $29,  $25,  $6b,  $2d,  $4a,  $29,  $6b,  $2d,  $08,  $21,  $29,  $25 
	dc.w $a5,  $14,  $c6,  $18,  $e7,  $1c,  $e7,  $1c,  $84,  $10,  $84,  $10,  $a5,  $14,  $63,  $0c 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $42,  $08,  $63,  $0c,  $42,  $08,  $42,  $08,  $00,  $00 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $84,  $10,  $84,  $10,  $84,  $10,  $63,  $0c 
	dc.w $a5,  $14,  $e8,  $1c,  $c6,  $18,  $a5,  $14,  $09,  $21,  $6c,  $2d,  $29,  $25,  $e7,  $1c 
	dc.w $ad,  $35,  $09,  $21,  $31,  $46,  $32,  $46,  $08,  $21,  $10,  $42,  $8c,  $31,  $32,  $46 
	dc.w $10,  $42,  $b2,  $5e,  $c7,  $1c,  $4a,  $29,  $c7,  $1c,  $73,  $4e,  $4b,  $29,  $ae,  $39 
	dc.w $f0,  $41,  $6b,  $2d,  $29,  $25,  $09,  $21,  $09,  $21,  $09,  $25,  $4b,  $29,  $09,  $25 
	dc.w $29,  $25,  $08,  $21,  $6b,  $2d,  $31,  $46,  $29,  $25,  $08,  $21,  $11,  $42,  $2a,  $29 
	dc.w $c6,  $18,  $c6,  $18,  $e7,  $1c,  $a5,  $14,  $84,  $10,  $84,  $10,  $a5,  $14,  $63,  $0c 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $42,  $08,  $00,  $00,  $00,  $00 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $84,  $10,  $84,  $10,  $84,  $10,  $63,  $0c 
	dc.w $c6,  $18,  $a5,  $14,  $e7,  $1c,  $a5,  $14,  $08,  $21,  $29,  $25,  $2a,  $29,  $e7,  $1c 
	dc.w $4a,  $29,  $6b,  $2d,  $09,  $25,  $8d,  $31,  $e8,  $1c,  $4a,  $29,  $09,  $25,  $cf,  $3d 
	dc.w $c6,  $1c,  $ed,  $45,  $d3,  $66,  $55,  $7b,  $0f,  $46,  $15,  $6b,  $4a,  $2d,  $85,  $10 
	dc.w $cf,  $39,  $4a,  $29,  $e8,  $20,  $29,  $25,  $09,  $25,  $4b,  $2d,  $29,  $25,  $09,  $25 
	dc.w $29,  $25,  $08,  $21,  $cf,  $3d,  $4b,  $29,  $08,  $21,  $2a,  $25,  $e8,  $1c,  $c7,  $1c 
	dc.w $c6,  $18,  $a5,  $14,  $c6,  $18,  $a5,  $14,  $63,  $0c,  $84,  $10,  $63,  $0c,  $84,  $10 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $42,  $08,  $63,  $0c,  $42,  $08,  $42,  $08,  $00,  $00 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $42,  $08,  $63,  $0c,  $84,  $10,  $63,  $0c,  $63,  $0c 
	dc.w $a5,  $14,  $84,  $10,  $c6,  $18,  $84,  $10,  $e7,  $1c,  $08,  $21,  $29,  $25,  $c6,  $18 
	dc.w $6b,  $2d,  $4a,  $29,  $29,  $25,  $8c,  $31,  $08,  $21,  $29,  $25,  $6c,  $31,  $11,  $42 
	dc.w $e7,  $20,  $29,  $25,  $f0,  $41,  $6c,  $31,  $cf,  $3d,  $29,  $25,  $6b,  $2d,  $6c,  $2d 
	dc.w $6b,  $2d,  $09,  $21,  $31,  $46,  $ae,  $35,  $6c,  $2d,  $2a,  $25,  $09,  $25,  $09,  $21 
	dc.w $4a,  $29,  $4a,  $29,  $6b,  $2d,  $29,  $25,  $c6,  $18,  $e7,  $1c,  $e7,  $1c,  $09,  $21 
	dc.w $a5,  $14,  $c6,  $18,  $84,  $10,  $84,  $10,  $63,  $0c,  $63,  $0c,  $84,  $10,  $63,  $0c 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $42,  $08,  $00,  $00,  $00,  $00 
	dc.w $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c 
	dc.w $84,  $10,  $a5,  $14,  $63,  $0c,  $84,  $10,  $a5,  $14,  $c6,  $18,  $e7,  $1c,  $c6,  $18 
	dc.w $08,  $21,  $29,  $25,  $29,  $25,  $4a,  $29,  $08,  $21,  $4b,  $29,  $29,  $25,  $11,  $42 
	dc.w $31,  $46,  $6b,  $2d,  $ce,  $39,  $09,  $21,  $6b,  $2d,  $6c,  $2d,  $6c,  $2d,  $6c,  $2d 
	dc.w $2a,  $25,  $ef,  $3d,  $6c,  $2d,  $09,  $21,  $29,  $25,  $4a,  $29,  $6b,  $2d,  $09,  $25 
	dc.w $e7,  $1c,  $29,  $25,  $4a,  $29,  $08,  $21,  $c6,  $18,  $e7,  $1c,  $a5,  $14,  $a5,  $14 
	dc.w $63,  $0c,  $84,  $10,  $63,  $0c,  $84,  $10,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c 
	dc.w $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $00,  $00,  $00,  $00 
	dc.w $42,  $08,  $42,  $08,  $00,  $00,  $00,  $00,  $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08 
	dc.w $63,  $0c,  $63,  $0c,  $84,  $10,  $63,  $0c,  $a5,  $14,  $c6,  $18,  $a5,  $14,  $84,  $10 
	dc.w $e7,  $1c,  $08,  $21,  $29,  $25,  $c6,  $18,  $29,  $25,  $2a,  $29,  $09,  $21,  $6c,  $2d 
	dc.w $29,  $25,  $09,  $21,  $10,  $42,  $6c,  $2d,  $6c,  $2d,  $6b,  $2d,  $ef,  $3d,  $8c,  $31 
	dc.w $4a,  $29,  $09,  $25,  $6b,  $2d,  $29,  $25,  $29,  $25,  $4a,  $29,  $4a,  $29,  $08,  $21 
	dc.w $c6,  $18,  $08,  $21,  $e7,  $1c,  $a5,  $14,  $a5,  $14,  $84,  $10,  $63,  $0c,  $84,  $10 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08 
	dc.w $42,  $08,  $42,  $08,  $00,  $00,  $00,  $00,  $63,  $0c,  $42,  $08,  $42,  $08,  $00,  $00 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $84,  $10,  $84,  $10,  $84,  $10,  $63,  $0c 
	dc.w $c6,  $18,  $a5,  $14,  $e7,  $1c,  $a5,  $14,  $29,  $25,  $08,  $21,  $08,  $21,  $e7,  $1c 
	dc.w $08,  $21,  $29,  $25,  $09,  $25,  $29,  $25,  $4b,  $29,  $ae,  $39,  $09,  $21,  $29,  $25 
	dc.w $29,  $25,  $08,  $21,  $e8,  $1c,  $29,  $25,  $c6,  $18,  $e7,  $1c,  $e7,  $1c,  $08,  $21 
	dc.w $84,  $10,  $a5,  $14,  $c6,  $18,  $84,  $10,  $63,  $0c,  $84,  $10,  $63,  $0c,  $63,  $0c 
	dc.w $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $63,  $0c,  $42,  $08,  $42,  $08,  $00,  $00 
	dc.w $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $84,  $10,  $84,  $10,  $a5,  $14,  $84,  $10,  $84,  $10 
	dc.w $c6,  $18,  $e7,  $1c,  $a5,  $14,  $a5,  $14,  $e7,  $1c,  $c6,  $18,  $08,  $21,  $c6,  $18 
	dc.w $a5,  $18,  $29,  $25,  $c6,  $18,  $08,  $21,  $a5,  $14,  $29,  $25,  $c6,  $18,  $e7,  $1c 
	dc.w $a5,  $14,  $c6,  $18,  $c5,  $14,  $84,  $10,  $84,  $10,  $84,  $10,  $84,  $10,  $63,  $0c 
	dc.w $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $00,  $00 
	dc.w $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $00,  $00,  $06,  $1d,  $0b,  $42 
	dc.w $42,  $08,  $42,  $08,  $63,  $0c,  $42,  $08,  $42,  $08,  $63,  $0c,  $63,  $0c,  $28,  $25 
	dc.w $21,  $04,  $84,  $10,  $63,  $0c,  $a9,  $31,  $84,  $10,  $64,  $0c,  $84,  $10,  $a5,  $14 
	dc.w $84,  $10,  $84,  $10,  $a5,  $14,  $a5,  $14,  $a5,  $14,  $a5,  $14,  $c6,  $18,  $84,  $10 
	dc.w $84,  $10,  $63,  $0c,  $84,  $10,  $a5,  $14,  $0c,  $42,  $a4,  $14,  $88,  $31,  $01,  $04 
	dc.w $63,  $0c,  $84,  $10,  $68,  $2d,  $21,  $04,  $84,  $10,  $63,  $0c,  $42,  $08,  $22,  $04 
	dc.w $21,  $04,  $63,  $0c,  $42,  $08,  $42,  $08,  $42,  $08,  $63,  $0c,  $42,  $08,  $42,  $08 
	dc.w $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $00,  $00 
	dc.w $84,  $10,  $0b,  $42,  $a9,  $35,  $21,  $04,  $01,  $00,  $c9,  $39,  $06,  $21,  $42,  $08 
	dc.w $01,  $04,  $42,  $08,  $ec,  $3d,  $c5,  $18,  $a8,  $35,  $63,  $0c,  $e5,  $1c,  $21,  $04 
	dc.w $0d,  $42,  $00,  $00,  $06,  $21,  $63,  $0c,  $63,  $0c,  $a9,  $35,  $c5,  $18,  $21,  $04 
	dc.w $c5,  $18,  $21,  $04,  $2d,  $42,  $89,  $31,  $42,  $08,  $01,  $04,  $aa,  $35,  $84,  $10 
	dc.w $63,  $10,  $01,  $04,  $ea,  $3d,  $67,  $2d,  $01,  $00,  $0b,  $42,  $63,  $0c,  $06,  $21 
	dc.w $63,  $0c,  $00,  $00,  $89,  $2d,  $42,  $08,  $89,  $31,  $0c,  $42,  $00,  $04,  $a4,  $14 
	dc.w $01,  $04,  $a4,  $14,  $0c,  $42,  $88,  $31,  $42,  $08,  $43,  $08,  $42,  $08,  $42,  $08 
	dc.w $43,  $08,  $42,  $08,  $42,  $08,  $62,  $0c,  $42,  $08,  $00,  $00,  $06,  $21,  $c9,  $39 
	dc.w $42,  $08,  $06,  $21,  $c9,  $39,  $21,  $04,  $00,  $00,  $22,  $08,  $68,  $2d,  $63,  $0c 
	dc.w $00,  $00,  $63,  $0c,  $c9,  $35,  $27,  $25,  $21,  $04,  $ea,  $3d,  $88,  $31,  $c5,  $18 
	dc.w $63,  $08,  $e5,  $1c,  $00,  $00,  $42,  $08,  $a9,  $35,  $06,  $21,  $00,  $00,  $63,  $0c 
	dc.w $42,  $08,  $63,  $0c,  $63,  $0c,  $42,  $08,  $42,  $08,  $06,  $21,  $c9,  $35,  $01,  $00 
	dc.w $a4,  $14,  $c9,  $35,  $42,  $08,  $22,  $04,  $c4,  $18,  $42,  $08,  $42,  $08,  $01,  $00 
	dc.w $00,  $00,  $a4,  $14,  $a8,  $35,  $42,  $08,  $00,  $00,  $06,  $21,  $a8,  $35,  $42,  $08 
	dc.w $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08 
	dc.w $42,  $08,  $42,  $08,  $21,  $04,  $43,  $0c,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08 
	dc.w $42,  $08,  $43,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $43,  $08 
	dc.w $42,  $08,  $42,  $08,  $43,  $08,  $21,  $04,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08 
	dc.w $42,  $08,  $42,  $08,  $42,  $08,  $42,  $04,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08 
	dc.w $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $21,  $04 
	dc.w $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08 
	dc.w $42,  $08,  $21,  $04,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08,  $42,  $08
	
    END MAIN





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
