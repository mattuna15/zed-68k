*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $0400
START:                  ; first instruction of program
    pea  test.l
    
   ; trap #2

* Put variables and constants here
    dc.l test

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
