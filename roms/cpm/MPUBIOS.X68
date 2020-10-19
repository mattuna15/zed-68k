* 7/29/17, fork from rev 3 of TinyBIOS for Tiny68000
* This BIOS assumes CPM15000 will be loaded
* It also assume the disk is reside in flash from location $420000 to $5FFFFF
* The disk already contains CP/M 68K distribution files
*****************************************************************

_ccp     equ $150BC                  * hard location for _ccp of CPM15000.SR
         org $1B000                 * this is the hard location for _init for CPM15000.SR
_init:	
         move.w #$2700,sr           * mask off all interrupts
**********remove for real hardware
         move.b #12,d0              * don't echo back keyboard
         move.b #0,d1               * no echo -- use this for simulation
*         move.b #1,d1              * echo back -- use this for real hardware
         trap #15
**********remove for real hardware
         move.l	#traphndl,$8c	* set up trap #3 handler
	clr.l	d0		* log on disk A, user 0
*	move.b   #$40,CF2427       * set Logical Address addressing mode
	rts

traphndl:
	cmpi	#nfuncs,d0
	bcc	trapng
	lsl	#2,d0		* multiply bios function by 4
**X won't assemble         movea.l 6(pc,d0),a0        * get handler address
**X replace with this:
	movea.l	*+8(pc,d0),a0	* get handler address
	jsr	(a0)		* call handler
trapng:
	rte

biosbase:
	dc.l  _init
	dc.l  wboot
	dc.l  constat
	dc.l  conin
	dc.l  conout
	dc.l  lstout
	dc.l  pun
	dc.l  rdr
	dc.l  home
	dc.l  seldsk
	dc.l  settrk
	dc.l  setsec
	dc.l  setdma
	dc.l  read
	dc.l  write
	dc.l  listst
	dc.l  sectran
	dc.l  setdma
	dc.l  getseg
	dc.l  getiob
	dc.l  setiob
	dc.l  flush
	dc.l  setexc

nfuncs   equ (*-biosbase)/4

wboot:	jmp	_ccp

constat: 
* Check for keyboard input. Set d0 to 1 if keyboard input is pending, otherwise set to 0.

         move.b #7,d0      * use EASy68k trap 15 task 7
         trap #15          * d1.b = 1 if keyboard ready, otherwise = 0
         clr.l d0
         move.b d1,d0
         rts
         
conin:	
* Read single ASCII character from the keyboard into d0
         bsr constat                * see if key pressed
         tst d0
         beq conin
         move.b #5,d0               * use EASy68k trap 15 task 5
         trap #15          * d1.b contains the ascii character
         move.b d1,d0      
         and.l #$7f,d0     * only use 7 bit character set
	rts

conout: 
* Display single ASCII character in d1
         move.b #6,d0               * use EASy68k trap 15 task 6
         trap #15
	rts			* and exit

lstout:	rts

pun:	rts

rdr:	rts

listst:	move.b	#$ff,d0
	rts

maxdsk   equ 3             * three RAM drives
dphlen   equ 26            * length of disk parameter header

home:	clr.b	track
	rts

seldsk:	
*	select disk given by register d1.b
	moveq	#0,d0
	cmp.b	#maxdsk,d1	* valid drive number?
	bpl	selrtn		* if no, return 0 in d0
	move.b	d1,seldrv	* else, save drive number
	move.b	seldrv,d0
	mulu	#dphlen,d0
	add.l	#dph0,d0	         * point d0 at correct dph
selrtn:	rts

settrk:	move.w	d1,track
	rts

setsec:	
         move.w	d1,sector
	rts

sectran:
*	no sector translate, put d1 into d0 and return
         move.w d1,d0
         rts

setdma:
	move.l	d1,dma
	rts

read:
* Read one sector from requested disk, track, sector to dma address
* Both drive A, B & C are RAM drives
* drive A starts from 0x420000 to 0x5BFFFF
* drive B starts from 0xC0000 to 0xFFFFF


         bsr setupRD                * translate track/sector values into RAM loc
RAMdrvR:
         move.l (a0)+,(a1)+
         dbra d2,RAMdrvR
readexit:
         clr.l d0                   * return OK status         
         rts         
setupRD:
* translate track/sector into RAM location on the RAM drive
         move.l track,d0            * get track & sector values
         lsl.w #6,d0                * multiply by 64
         lsl.l #1,d0                * multiply the track/sector by 128 to index into RAM
         cmp.b #2,seldrv            * drive C is RAM drive
         beq RAMdrv
         add.l #$420000,d0          * add base address of RAM drive
         bra getdata
RAMdrv:  add.l #$C0000,d0
getdata:
         move.l d0,a0               * point to the track/sector in RAM drive
         move.l dma,a1             * get dma
         move.w #(128/4)-1,d2        * long word move 128 bytes of sector data
         rts

write:
* Write one sector to requested disk, track, sector from dma address
* Both drive A & B are RAM drive
         cmp.b #2,seldrv            * only drive C can be written
         bne wrbad
         bsr setupRD                * translate track/sector values into RAM loc
RAMdrvW:
         move.l (a1)+,(a0)+
         dbra d2,RAMdrvW
wrexit:
         clr.l d0
         rts         
wrbad:
         move.l #-1,d0
         rts
flush:
	clr.l	d0		* return successful
	rts

getseg:
	move.l	#memrgn,d0	* return address of mem region table
	rts

getiob:
	rts

setiob:
	rts

setexc:
	andi.l	#$ff,d1		* do only for exceptions 0 - 255
	cmpi	#47,d1
	beq	noset		* this BIOS doesn't set Trap 15
	cmpi	#9,d1		* or Trace
	beq	noset
	lsl	#2,d1		* multiply exception nmbr by 4
	movea.l	d1,a0
	move.l	(a0),d0		* return old vector value
	move.l	d2,(a0)		* insert new vector
noset:	rts


**X	.data

seldrv:	dc.b	$ff	* drive requested by seldsk
resv:    dc.b    0         * reserve byte, padding
curCFsect: dc.l   -1 * current CF sector, the 512 bytes data of curtrk is in sectCF
track:	dc.w	0	* track requested by settrk
sector:	dc.w	0        * max sector value is 0x3FF
dma:	dc.l	0
selcode: dc.b	0	* reserve byte
resv1:   dc.b     0        * reserve byte, padding

memrgn:	dc.w	1	* 1 memory region
         dc.l     $20000   * right after the CP/M 
         dc.l     $A0000  * goes until $C0000, 655K bytes  

* disk parameter headers

dph0:	
         dc.l     0        * no sector translation table
	dc.w	0	* dummy
	dc.w	0
	dc.w	0
	dc.l	dirbuf	* ptr to directory buffer
	dc.l	dpb0	* ptr to disk parameter block
	dc.l	0	* permanent drive, no check vector
	dc.l	alv0	* ptr to allocation vector

dph1:
         dc.l     0        * no sector translation table
	dc.w	0	* dummy
	dc.w	0
	dc.w	0
	dc.l	dirbuf	* ptr to directory buffer
	dc.l	dpb1	* ptr to disk parameter block
	dc.l	0	* permanent drive, no check vector
	dc.l	alv1	* ptr to allocation vector
dph2:
         dc.l     0        * no sector translation table
	dc.w	0	* dummy
	dc.w	0
	dc.w	0
	dc.l	dirbuf	* ptr to directory buffer
	dc.l	dpb2	* ptr to disk parameter block
	dc.l	0	* permanent drive, no check vector
	dc.l	alv2	* ptr to allocation vector

* disk parameter block
* flash drive from $420000 to 59FFFF,
* choose a BLS of 2048
* 1024 sectors (128 byte sector) per track
* 16 sectors per block
* 12 tracks per drive 
dpb0:	
         dc.w     1024     * 1024 sectors per track
         dc.b     4        * block shift for BLS of 2048
         dc.b     15       * block mask for BLS of 2048
	dc.b	0	* extent mask, EXM
	dc.b	0	* dummy fill
         dc.w     767     * DSM, (12 tracks * 1024 sectors * 128 bytes /2048)-1
                           
         dc.w     255      * DRM, 256 directory entries
	dc.w	0	* directory mask
         dc.w     0        * permanent mounted drive, check size is zero
         dc.w     0        * no track offset

* flash drive from $5A0000 to $5FFFFF
* choose a BLS of 2048
* 1024 sectors (128 byte sector) per track
* 16 sectors per block
* 3 tracks per drive 
dpb1:	
         dc.w     1024     * 1024 sectors per track
         dc.b     4        * block shift for BLS of 2048
         dc.b     15       * block mask for BLS of 2048
	dc.b	0	* extent mask, EXM
	dc.b	0	* dummy fill
         dc.w     191     * DSM, (3 tracks * 1024 sectors * 128 bytes /2048)-1
                           
         dc.w     255      * DRM, 256 directory entries
	dc.w	0	* directory mask
         dc.w     0        * permanent mounted drive, check size is zero
         dc.w     12        * no track offset
         
* use the battery-back RAM in ADC MPU as small RAMdisk, $C0000-$FFFFF
* disk parameter block
* choose a BLS of 1024
* 1024 sectors (128 byte sector) per track
* 8 sectors per block
* 2 tracks per drive 
dpb2:	
         dc.w     1024     * 1024 sectors per track
         dc.b     3        * block shift for BLS of 1024
         dc.b     7       * block mask for BLS of 1024
	dc.b	0	* extent mask, EXM
	dc.b	0	* dummy fill
         dc.w     255     * DSM, (2 tracks * 1024 sectors * 128 bytes /2048)-1
* force the block number to be words rather than bytes                           
         dc.w     127      * DRM, 128 directory entries
	dc.w	0	* directory mask
         dc.w     0        * permanent mounted drive, check size is zero
         dc.w     0        * no track offset

**X no sector translation table

**X	.bss

dirbuf:	ds.b	128	* directory buffer

alv0:	ds.b	256	* allocation vector, DSM/8+1 = 128
alv1:	ds.b	256      * DSM/8 +1 = 128, round up to 256
alv2:	ds.b	256      * DSM/8 +1 = 128, round up to 256

*	end $15000        * start executing CPM at $15000
         end 0



























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~9~
