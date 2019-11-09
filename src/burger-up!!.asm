 *=$0801
!to "../bin/burger-up!!.prg",cbm

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
;[K]EYBOARD SUPPORT   0=NO
;                     1=YES
;
;                      76543210
;                      KTBBMGGG
GAME_SINGLE         = %10100000
GAME_COMPETITION    = %10101001
GAME_DEATHMATCH     = %01001010
GAME_CIRCLETRAINING = %01001011
GAME_DRIVE_ME_NUTS  = %01011100

FC_COLOR       = $d020
BG_COLOR       = $d021
COLOR_RAM      = $d800
USERPORT_DATA  = $dd01
USERPORT_DDR   = $dd03
JOYSTICK_PORT1 = $dc01
JOYSTICK_PORT2 = $dc00
CIA1_DATA_DIRA = $dc02 
CIA1_DATA_DIRB = $dc03 

CONTROLLER1 = controllerStates
CONTROLLER2 = controllerStates+1
CONTROLLER3 = controllerStates+2
CONTROLLER4 = controllerStates+3
FIREBUTTONS = controllerStates+4

GRAP_FCFS = 0
GRAP_AWAL = 1

CONTROLLER_IS_KEYBOARD = 1
CONTROLLER_IS_JOYSTICK = 0

!basic 2019,start
;*=$c000
;jmp start

controllerStates:
  !byte 0,0,0,0,0,0
gameTypeSelected:
  !byte GAME_SINGLE
gameTypeList
  !byte GAME_SINGLE, GAME_COMPETITION, GAME_DEATHMATCH, GAME_CIRCLETRAINING, GAME_DRIVE_ME_NUTS
gameTypeText:
  !text "        SINGLE        "
  !text "      COMPETITION     "
  !text "      DEATHMATCH      "
  !text "    CIRCLETRAINING    "
  !text "    DRIVE ME NUTS!    "
grapMode:
  !byte GRAP_FCFS
grapModeText:
  !text "FIRST COME FIRST SERVE"  
  !text "  ALL WIN/ALL LOOSE   "
highScorePointerList:
  !byte 0,1,2,3,4,5,6,7,8,9
highScoreTable:
  !text "AAA          ",0
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
keyOrJoyFlag:
  !byte CONTROLLER_IS_KEYBOARD
keyOrJoyText
  !text "JOYSTICK"
  !text "KEYBOARD"
ingredientSwapTime:
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
  !word player1, player2, player3, player4
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
player1IngredientCount:
  !byte 0,0,0,0

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
player2IngredientCount:
  !byte 0,0,0,0

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
player3IngredientCount:
  !byte 0,0,0,0

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
player4IngredientCount:
  !byte 0,0,0,0

burgerStyleSelected:
  !byte 0
burgerStylePointerList:
  !word burgerStyle1, burgerStyle2, burgerStyle3, burgerStyle4
burgerStyle1: ; standard
  !byte 9,8,7,3,1,0,$ff
burgerStyle2: ; cheese
  !byte 9,8,7,4,3,1,0,$ff
burgerStyle3: ; bacon
  !byte 9,8,7,5,4,3,1,0,$ff
burgerStyle4: ; vegan
  !byte 9,8,7,6,2,1,0,$ff
burgerIngredientsCount:
  !byte 0
burgerNames:
  !text "HAMBURGER             "
  !text "CHEESEBURGER          "
  !text "BACON CHEESEBURGER    "
  !text "VEGAN GUACAMOLE BURGER"
  
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

random4:
!byte $03,$00,$03,$01,$03,$01,$00,$01,$00,$02,$01,$01,$03,$01,$02,$03
!byte $01,$01,$00,$02,$01,$02,$02,$02,$00,$00,$03,$03,$00,$02,$00,$02
!byte $00,$00,$02,$01,$00,$00,$00,$02,$03,$02,$02,$03,$01,$03,$02,$00
!byte $00,$02,$02,$02,$02,$02,$02,$01,$02,$00,$00,$02,$03,$02,$00,$03
!byte $03,$03,$03,$02,$03,$00,$01,$01,$01,$00,$01,$03,$01,$03,$02,$00
!byte $01,$00,$02,$03,$01,$00,$01,$03,$02,$01,$01,$00,$00,$02,$03,$01
!byte $00,$00,$02,$02,$01,$00,$01,$01,$01,$01,$00,$03,$02,$01,$02,$01
!byte $01,$03,$01,$03,$00,$03,$00,$02,$03,$03,$02,$00,$00,$03,$01,$02
!byte $00,$00,$02,$01,$03,$02,$00,$00,$01,$02,$03,$00,$03,$01,$00,$02
!byte $00,$00,$02,$02,$02,$00,$02,$01,$03,$01,$03,$00,$00,$00,$00,$02
!byte $01,$00,$00,$02,$01,$01,$02,$00,$01,$03,$02,$02,$00,$02,$01,$00
!byte $01,$02,$01,$03,$03,$01,$03,$00,$03,$02,$00,$02,$01,$03,$01,$02
!byte $02,$02,$00,$03,$03,$02,$02,$03,$03,$02,$00,$02,$00,$01,$00,$01
!byte $00,$03,$01,$01,$02,$00,$02,$02,$03,$01,$03,$00,$00,$01,$00,$03
!byte $03,$02,$03,$03,$00,$03,$00,$02,$01,$00,$01,$01,$03,$00,$03,$02
!byte $02,$01,$03,$02,$03,$03,$01,$00,$02,$03,$03,$00,$02,$01,$00,$00

random5:
!byte $03,$04,$03,$00,$04,$01,$04,$02,$01,$00,$04,$02,$00,$00,$01,$00
!byte $04,$03,$02,$02,$03,$00,$00,$02,$03,$02,$00,$01,$04,$04,$04,$04
!byte $01,$04,$02,$00,$01,$00,$00,$02,$03,$03,$02,$01,$04,$04,$02,$03
!byte $04,$01,$02,$03,$04,$02,$03,$01,$01,$04,$03,$01,$01,$03,$00,$00
!byte $03,$03,$02,$00,$04,$04,$02,$03,$01,$00,$01,$02,$04,$00,$01,$02
!byte $03,$01,$00,$04,$00,$02,$00,$02,$04,$02,$00,$04,$01,$01,$02,$04
!byte $02,$02,$04,$02,$02,$02,$02,$01,$00,$01,$04,$01,$01,$00,$01,$02
!byte $02,$01,$04,$03,$01,$02,$01,$03,$01,$04,$02,$00,$04,$03,$04,$02
!byte $04,$03,$00,$00,$02,$02,$04,$00,$04,$00,$01,$02,$00,$01,$01,$02
!byte $04,$02,$03,$04,$02,$02,$03,$02,$01,$04,$04,$01,$01,$01,$04,$00
!byte $00,$04,$01,$02,$00,$04,$01,$02,$01,$01,$02,$01,$03,$03,$00,$04
!byte $01,$04,$02,$02,$03,$03,$04,$03,$02,$01,$02,$02,$01,$01,$04,$02
!byte $01,$02,$03,$01,$03,$03,$03,$01,$03,$01,$02,$01,$01,$00,$02,$04
!byte $04,$00,$01,$01,$02,$04,$00,$04,$04,$04,$03,$02,$02,$02,$03,$00
!byte $01,$00,$03,$04,$00,$00,$00,$00,$03,$01,$02,$03,$04,$04,$01,$04
!byte $04,$01,$02,$02,$02,$03,$01,$03,$02,$02,$03,$04,$00,$01,$01,$04

random6:
!byte $01,$00,$01,$05,$01,$03,$02,$00,$01,$01,$03,$01,$02,$02,$01,$04
!byte $02,$01,$01,$02,$04,$02,$05,$02,$04,$01,$05,$03,$00,$02,$03,$00
!byte $03,$02,$02,$00,$04,$04,$03,$02,$05,$02,$03,$05,$03,$01,$01,$04
!byte $03,$05,$01,$03,$02,$02,$04,$05,$00,$05,$00,$03,$03,$05,$03,$02
!byte $04,$03,$03,$00,$01,$01,$01,$00,$04,$01,$02,$05,$03,$05,$01,$01
!byte $04,$01,$05,$00,$03,$05,$03,$03,$01,$00,$01,$04,$04,$00,$05,$03
!byte $00,$02,$05,$05,$01,$00,$01,$04,$00,$03,$05,$01,$04,$00,$04,$00
!byte $00,$02,$00,$01,$00,$04,$05,$02,$00,$01,$04,$02,$03,$05,$00,$03
!byte $02,$02,$02,$01,$05,$03,$03,$05,$04,$03,$03,$04,$05,$02,$01,$02
!byte $04,$02,$05,$01,$02,$04,$05,$00,$05,$03,$01,$02,$03,$00,$03,$02
!byte $01,$03,$03,$00,$02,$03,$03,$02,$05,$05,$02,$05,$04,$04,$05,$05
!byte $02,$05,$01,$02,$00,$02,$02,$05,$00,$04,$04,$04,$05,$05,$05,$03
!byte $03,$03,$04,$00,$01,$01,$01,$02,$01,$03,$00,$03,$05,$03,$04,$05
!byte $02,$04,$01,$04,$00,$04,$04,$00,$03,$02,$04,$01,$04,$02,$00,$01
!byte $00,$03,$00,$03,$01,$04,$00,$00,$00,$05,$01,$05,$04,$04,$01,$03
!byte $01,$03,$02,$03,$02,$03,$04,$05,$00,$03,$04,$03,$05,$03,$01,$03

; {SPACE}=FIRE,{[Z]or[.]=LEFT],{[X][/]=RIGHT}
;      SPACE     Z         .        X         /
keyRowMatrix:
 !byte %01111111,%11111101,%11011110,%11111011,%10111111,0
keyColumnMatrix:
 !byte %00010000,%00010000,%10000000,%10000000,%10000000
keyDirection:
 !byte %00001111,%00011011,%00011011,%00010111,%00010111
start:
  jsr init
restart:
  jsr reset
  jsr showMainScreen
  jsr runGame
  jmp restart
  rts

init:
;init screen colors
  lda #$00
  sta FC_COLOR
  sta BG_COLOR
;init 4 player adapter  
  lda #$80
  sta USERPORT_DDR 
  lda USERPORT_DATA 
  sta USERPORT_DATA 
;prepare CIA1 for reading keyboard  
  lda #$ff
  sta CIA1_DATA_DIRA
  lda #$00
  sta CIA1_DATA_DIRB
  rts
  
reset:
  rts

readController:
  pha
  lda keyOrJoyFlag
  cmp #CONTROLLER_IS_JOYSTICK
  bne chooseKeyboard
  jsr readJoysticks
  jmp controllerSelected
chooseKeyboard:
  jsr readKeyboard
controllerSelected:  
  lda #$00
  sta FIREBUTTONS
  lda CONTROLLER1
  eor #$ff
  and #%00010000
  beq skip1
  lsr
  lsr
  lsr
  lsr
  ora FIREBUTTONS
  sta FIREBUTTONS
skip1:
  lda keyOrJoyFlag
  cmp #CONTROLLER_IS_KEYBOARD
  beq skip4
  lda CONTROLLER2
  eor #$ff
  and #%00010000
  beq skip2
  lsr
  lsr
  lsr
  ora FIREBUTTONS
  sta FIREBUTTONS
skip2:
  lda CONTROLLER3
  eor #$ff 
  and #%00010000
  beq skip3
  lsr
  lsr
  ora FIREBUTTONS
  sta FIREBUTTONS
skip3:
  lda CONTROLLER4
  eor #$ff
  and #%00010000
  beq skip4
  lsr
  ora FIREBUTTONS
  sta FIREBUTTONS
skip4:
  pla
  rts
  
readJoysticks:
  lda JOYSTICK_PORT1 ; read Port1
  and #$1F
  sta CONTROLLER1
  lda JOYSTICK_PORT2 ; read Port2
  and #$1F
  sta CONTROLLER2
  lda USERPORT_DATA ; CIA2 PortB Bit7 = 1
  ora #$80
  sta USERPORT_DATA
  lda USERPORT_DATA ; read Port3
  and #$1F
  sta CONTROLLER3
  lda USERPORT_DATA ; CIA2 PortB Bit7 = 0
  and #$7F
  sta USERPORT_DATA
  lda USERPORT_DATA ; read Port4
  pha ; Attention: FIRE for Port4 on Bit5, NOT 4!
  and #$0F
  sta CONTROLLER4
  pla
  and #$20
  lsr
  ora CONTROLLER4
  sta CONTROLLER4
  rts 

readKeyboard:
  lda #$1f
  tay
  sta CONTROLLER1
  ldx #$00
scanLoop:
  lda keyRowMatrix,x
  beq noKeyFound
  sta $dc00
  lda $dc01
  and keyColumnMatrix,x
  beq keyFound
  inx
  jmp scanLoop
keyFound:
  lda keyDirection,x
  and #$1f
  jmp set
noKeyFound:
  tya
set:
  sta CONTROLLER1
  rts  
  
showMainScreen:
  rts
  
runGame:
joyLoop:
  jsr readController
  jsr logControllers
  jmp joyLoop
  rts

logControllers:
  lda CONTROLLER1
  sta $0400
  lda CONTROLLER2
  sta $0401
  lda CONTROLLER3
  sta $0402
  lda CONTROLLER4
  sta $0403
  lda FIREBUTTONS
  sta $0404
  lda keyOrJoyFlag
  clc
  adc #10
  sta $0408
  rts
  

;FLAPPY-PONG-OUT