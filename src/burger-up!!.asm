*=$c000


;[G]AMETYPE _________ 0=GAME_SINGLE
;                     1=GAME_COMPETITION
;                     2=GAME_DEATHMATCH
;                     3=GAME_CIRCLETRAINING
;                     4=GAME_DRIVE_ME_NUTS
;[M]ULTIPLAYER ______ 0=NO
;                     1=YES
;[B]URGERS __________ 0=1
;                     1=2
;                     2=4
;[T]AKEMODE _________ 0=FIX
;                     1=SELECTABLE 
;[K]EYBOARD SUPPORTED 0=NO
;                     1=YES
;
;                      76543210
;                      KTBBMGGG
GAME_SINGLE         = %10100000
GAME_COMPETITION    = %10101001
GAME_DEATHMATCH     = %01001010
GAME_CIRCLETRAINING = %01001011
GAME_DRIVE_ME_NUTS  = %01011100

FC_COLOR      = $d020
BG_COLOR      = $d021
COLOR_RAM     = $d800
USERPORT_DATA = $dd01
USERPORT_DDR  = $dd03

GRAP_FCFS = 0
GRAP_AWAL = 1

jmp start
gameSelectedType:
  !byte GAME_SINGLE
gameTypeList
  !byte GAME_SINGLE,GAME_COMPETITION,GAME_DEATHMATCH,GAME_CIRCLETRAINING,GAME_DRIVE_ME_NUTS
gameNames:
  !text "        SINGLE        "
  !text "      COMPETITION     "
  !text "      DEATHMATCH      "
  !text "    CIRCLETRAINING    "
  !text "    DRIVE ME NUTS!    "
grapMode:
  !byte GRAP_FCFS
grapModeNames:
  !text "FIRST COME FIRST SERVE"  
  !text "  ALL WIN/ALL LOOSE   "
highScorePointerList:
  !byte 0,1,2,3,4,5,6,7,8,9
highScoreTable:
  !text "AAA           ",0
  !word 10
  !text "BBB          ",0
  !word 9
  !text "CCC          ",0
  !word 8
  !text "DDD          ",0
  !word 7
  !text "EEE          ",0
  !word 6
  !text "FFF          ",0
  !word 5
  !text "GGG          ",0
  !word 4
  !text "HHH          ",0
  !word 3
  !text "III          ",0
  !word 2
  !text "JJJ          ",0
  !word 1

ingridientSwapTime:
  !word 1000
playTime:
  !word 300
playTimeRemaining:
  !word 0
burgerCountList:
  !byte 1,2,4
playerCount:
  !byte 1
playerGrapFlags:
  !byte 1,2,4,8
playerGrapFlag:
  !byte 0
playerPointerList:
  !word player1,player2,player3,player4
player1:
  !word character1
player1Score:
  !word 0
player1Complete:
  !byte 0
player1Mistakes:
  !byte 0
player1SelectedBurger:
  !byte 0
player1IngridentCount:
  !byte 6,6,6,6

player2:
  !word character2
player2Score:
  !word 0
player2Complete:
  !byte 0
player2Mistakes:
  !byte 0
player2SelectedBurger:
  !byte 0
player2IngridentCount:
  !byte 6,6,6,6

player3:
 !word character3
player3Score:
  !word 0
player3Complete:
  !byte 0
player3Mistakes:
  !byte 0
player3SelectedBurger:
  !byte 0
player3IngridentCount:
  !byte 6,6,6,6

player4:
  !word character4
player4Score:
  !word 0
player4Complete:
  !byte 0
player4Mistakes:
  !byte 0
player4SelectedBurger:
  !byte 0
player4IngridentCount:
  !byte 6,6,6,6

burgerStyle1: ; default
  !byte 9,8,7,4,3,1,0
burgerStyle2: ; bacon
  !byte 9,8,7,5,4,3,1,0
burgerStyle3: ; vegan
  !byte 9,8,7,6,2,1,0
  
burger_chars:  
!byte $e9,$a7,$a7,$a7,$a7,$df ; 9 top bun
!byte $66,$66,$66,$66,$66,$66 ; 8 salad
!byte $62,$62,$62,$62,$62,$62 ; 7 ketchup/cucumber
!byte                         ; 6 guacamole
!byte                         ; 5 bacon
!byte $62,$62,$62,$62,$62,$62 ; 4 cheese
!byte $66,$66,$66,$66,$66,$66 ; 3 beef patty
!byte $66,$66,$66,$66,$66,$66 ; 2 vegan patty
!byte $5f,$a0,$a0,$a0,$a0,$69 ; 1 bottom bun
!byte $77,$78,$78,$78,$78,$77 ; 0 plate

burger_colors:
!byte $08,$08,$08,$08,$08,$08 ; 9 top bun 
!byte $05,$0d,$05,$0d,$05,$0d ; 8 salad
!byte $02,$0a,$02,$05,$0d,$05 ; 7 ketchup/cucumber
!byte                         ; 6 guacamole
!byte                         ; 5 bacon
!byte $07,$07,$07,$07,$07,$08 ; 4 cheese
!byte $09,$09,$09,$09,$09,$09 ; 3 beef patty
!byte $09,$09,$09,$09,$09,$09 ; 2 vegan patty
!byte $08,$08,$08,$08,$08,$08 ; 1 buttom bun
!byte $01,$01,$01,$01,$01,$01 ; 0 plate

character1:
!text "CHARLY CHEESE",0
character2:
!text "PATTY PAT    ",0
character3:
!text "BEEF BOB     ",0
character4:
!text "TOMATO TAM   ",0
character5:
!text "ONION OLLI   ",0
character6:
!text "CRUNCHY CHRIS",0
character7:
!text "SALTY SALLY  ",0
character8:
!text "CHILI CHASE  ",0
character9:
!text "BACON BENNY  ",0
character10:
!text "VEGAN VIVIAN ",0

init:
  lda #$00
  sta FC_COLOR
  sta BG_COLOR
  
  
start:
  
rts
