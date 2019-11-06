*=$c000


;B : MAX BURGERS
;M : 1=MULTIPLAYER / 0=SINGLEPLAYER
;G : GAMETYPE
;                      BBB0MGGG
GAME_SINGLE         = %10000001
GAME_COMPETITION    = %10001010
GAME_DEATHMATCH     = %01001011
GAME_ZIRKELTRAINING = %01001100
GAME_DRIVE_ME_NUTS  = %01001101


GRAP_FCFS = 0
GRAP_AWAL = 1

jmp start
gameSelectedType:
  !byte GAME_SINGLE
gameTypeList
  !byte GAME_SINGLE,GAME_COMPETITION,GAME_DEATHMATCH,GAME_ZIRKELTRAINING,GAME_DRIVE_ME_NUTS
gameNames:
  !text "        SINGLE        "
  !text "      COMPETITION     "
  !text "      DEATHMATCH      "
  !text "    ZIRKELTRAINING    "
  !text "    DRIVE ME NUTS!    "
grapMode:
  !byte GRAP_FCFS
grapModeNames:
  !text "FIRST COME FIRST SERVE"  
  !text "  ALL WIN/ALL LOOSE   "
highScorePointerList:
  !byte 0,1,2,3,4,5,6,7,8,9
highScoreTable:
  !text "AAA       ",0
  !word 10
  !text "BBB       ",0
  !word 9
  !text "CCC       ",0
  !word 8
  !text "DDD       ",0
  !word 7
  !text "EEE       ",0
  !word 6
  !text "FFF       ",0
  !word 5
  !text "GGG       ",0
  !word 4
  !text "HHH       ",0
  !word 3
  !text "III       ",0
  !word 2
  !text "JJJ       ",0
  !word 1

ingridientSwapTime:
  !word 1000
playTime:
  !word 300
playTimeRemaining:
  !word 0
burgerCount:
  !byte 4
playerCount:
  !byte 1
playerGrapFlags:
  !byte 1,2,4,8
playerGrapFlag:
  !byte 0
playerPointerList:
  !word player1,player2,player3,player4
player1:
  !text "PLAYER1   ",0
player1Score:
  !word 0
player1Complete:
  !word 0
player1Mistakes:
  !word 0
player1SelectedBurger:
  !byte 0
player1LayerCount:
  !byte 6,6,6,6

player2:
  !text "PLAYER2   ",0
player2Score:
  !word 0
player2Complete:
  !word 0
player2Mistakes:
  !word 0
player2SelectedBurger:
  !byte 0
player2LayerCount:
  !byte 6,6,6,6

player3:
  !text "PLAYER3   ",0
player3Score:
  !word 0
player3Complete:
  !word 0
player3Mistakes:
  !word 0
player3SelectedBurger:
  !byte 0
player3LayerCount:
  !byte 6,6,6,6

player4:
  !text "PLAYER4   ",0
player4Score:
  !word 0
player4Complete:
  !word 0
player4Mistakes:
  !word 0
player4SelectedBurger:
  !byte 0
player4LayerCount:
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
start:

rts