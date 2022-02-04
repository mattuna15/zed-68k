# Nex-68k
Nexys 4 DDR 68k

Nexys4DDR Motorola 68000 implementation of multicomp, Gameduino and MIC68K using the TG68 core. 
The ram code and memory map has been amended accordingly.
Some of the memory and clocking routines are based on work by Michael Jørgensen.
The VGA Engine is based on Gameduino by James Bowman - modified for the Nexys.

# Hardware
Digilent Nexys4 DDR: https://store.digilentinc.com/nexys-4-ddr-artix-7-fpga-trainer-board-recommended-for-ece-curriculum/
Uses a ps2 pmod in JA: https://reference.digilentinc.com/reference/pmod/pmodps2/start<br>

# Software

Roms assembled and converted using Easy68K and Srecord. 
Block Ram from $0000 to $FFFF, DDR from $10000 to $A00000
ZBug Monitor rom working at memory location $A00000.
EhBasic from Lee Davison and Jeff Tranter working in rom at $B00000.
Modified Gameduino v1 at $C00000

SREC Compiled can be uploaded via option L in the monitor, then sent via Serial connection at 115200. Data confirmed via option D to disassemble in monitor.

<hr>
Project acknowledgments: <br>

https://github.com/toivoh/gameduino-fpga-mods<br>
http://jefftranter.blogspot.com/search/label/Enhanced%20Basic<br>
https://github.com/kanpapa/mic68k<br>
https://github.com/ProfKelly/EASy68K<br>
https://github.com/TobiFlex/TG68K.C<br>
http://searle.x10host.com/Multicomp/index.html<br>
https://www.retrobrewcomputers.org/doku.php?id=boards:sbc:multicomp:papilio-duo:start<br>
https://github.com/MJoergen/dyoc <br>

License:

“By downloading these files you must agree to the following: The original copyright owners of ROM contents are respectfully acknowledged. Use of the contents of any file within your own projects is permitted freely, but any publishing of material containing whole or part of any file distributed here, or derived from the work that I have done here will contain an acknowledgement back to myself, Grant Searle, and a link back to this page. Any file published or distributed that contains all or part of any file from this page must be made available free of charge.” - http://searle.x10host.com/Multicomp/index.html

