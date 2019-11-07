*=$c000


;B : BURGERS 0=1 / 1=2 / 2=4
;M : 1=MULTIPLAYER / 0=SINGLEPLAYER
;G : GAMETYPE 1=GAME_SINGLE, 2=GAME_COMPETITION, 3=GAME_DEATHMATCH, 4=GAME_CIRCLETRAINING, 5=GAME_DRIVE_ME_NUTS
;T : GRAPSTYLE 0=FIX / 1=SELECTABLE 
;_ : FREE
;                      _TBBMGGG
GAME_SINGLE         = %00100001
GAME_COMPETITION    = %00101010
GAME_DEATHMATCH     = %01001011
GAME_CIRCLETRAINING = %01001100
GAME_DRIVE_ME_NUTS  = %01011101

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

burger_chars:  
!byte $e9,$a7,$a7,$a7,$a7,$df ; top bun
!byte $66,$66,$66,$66,$66,$66 ; salad
!byte $62,$62,$62,$62,$62,$62 ; ketchup/cucumber
!byte $62,$62,$62,$62,$62,$62 ; cheese
!byte $66,$66,$66,$66,$66,$66 ; patty
!byte $5f,$a0,$a0,$a0,$a0,$69 ; bottom bun
!byte $77,$78,$78,$78,$78,$77 ; plate

burger_colors:
!byte $08,$08,$08,$08,$08,$08 ; top bun 
!byte $05,$0d,$05,$0d,$05,$0d ; salad
!byte $02,$0a,$02,$05,$0d,$05 ; ketchup/cucumber
!byte $07,$07,$07,$07,$07,$08 ; cheese
!byte $09,$09,$09,$09,$09,$09 ; patty
!byte $08,$08,$08,$08,$08,$08 ; buttom bun
!byte $01,$01,$01,$01,$01,$01 ; plate

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
!text "CRUNCH CHRIS ",0
character7:
!text "SALTY SALLY  ",0
character8:
!text "CHILI CHASE  ",0

init:
  lda #$00
  sta FC_COLOR
  sta BG_COLOR
  
  
start:
  
rts
