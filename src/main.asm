.pc = $0801

//[G]AMETYPE _________ 0=GAME_SINGLE
//                     1=GAME_COMPETITION
//                     2=GAME_DEATHMATCH
//                     3=GAME_CIRCLETRAINING
//                     4=GAME_DRIVE_ME_NUTS
//[M]ULTIPLAYER ______ 0=NO
//                     1=YES
//[B]URGERS __________ 0=1
//                     1=2
//                     2=4
//[T]AKEMODE _________ 0=FIX
//                     1=SELECTABLE 
//[K]EYBOARD SUPPORT   0=NO
//                     1=YES
//
//                            76543210
//                            KTBBMGGG
.const GAME_SINGLE         = %10100000
.const GAME_COMPETITION    = %10101001
.const GAME_DEATHMATCH     = %01001010
.const GAME_CIRCLETRAINING = %01001011
.const GAME_DRIVE_ME_NUTS  = %01011100

.const FC_COLOR       = $d020
.const BG_COLOR       = $d021
.const COLOR_RAM      = $d800
.const USERPORT_DATA  = $dd01
.const USERPORT_DDR   = $dd03
.const JOYSTICK_PORT1 = $dc01
.const JOYSTICK_PORT2 = $dc00
.const CIA1_DATA_DIRA = $dc02 
.const CIA1_DATA_DIRB = $dc03 

.const CONTROLLER1 = controllerStates
.const CONTROLLER2 = controllerStates+1
.const CONTROLLER3 = controllerStates+2
.const CONTROLLER4 = controllerStates+3
.const FIREBUTTONS = controllerStates+4

.const GRAP_FCFS = 0  // First come first serve
.const GRAP_AWAL = 1  // All win / All loose

.const CONTROLLED_BY_KEYBOARD = 1 
.const CONTROLLED_BY_JOYSTICK = 0

.macro PlayerData(character) {
player:
  .word character4
playerName:
  .byte 20
playerScore:
  .word 0
playerComplete:
  .byte 0
playerMistakes:
  .byte 0
playerSelectedBurger:
  .byte 0
playerIngredientCount:
  .byte 0,0,0,0
playerBurgerOffsets:
  .word 0,0,0,0
}

.macro RandomIngredientTable(max){
  .for(var i=0;i<=256;i++) .byte random()*max
}

:BasicUpstart2(start)
//;*=$c000
//jmp start

controllerStates:
  .byte 0,0,0,0,0,0
canHaveRandomGaps:
  .byte 0
gameTypeSelected:
  .byte GAME_SINGLE
gameTypeList:
  .byte GAME_SINGLE, GAME_COMPETITION, GAME_DEATHMATCH, GAME_CIRCLETRAINING, GAME_DRIVE_ME_NUTS
gameTypeText:
  .text "    SINGLE     "
  .text "  COMPETITION  "
  .text "  DEATH MATCH  "
  .text "CIRCLE TRAINING"
  .text " DRIVE ME NUTS "
grapMode:
  .byte GRAP_FCFS
grapModeText:
  .text "FIRST COME FIRST SERVE"  
  .text "  ALL WIN/ALL LOOSE   "
highScorePointerList:
  .byte 0,1,2,3,4,5,6,7,8,9
highScoreTable:
  .text "AAA          "
  .byte 0
  .word 10
  .text "BBB          "
  .byte 0
  .word 9
  .text "CCC          "
  .byte 0
  .word 8
  .text "DDD          "
  .byte 0
  .word 7
  .text "EEE          "
  .byte 0
  .word 6
  .text "FFF          "
  .byte 0
  .word 5
  .text "GGG          "
  .byte 0
  .word 4
  .text "HHH          "
  .byte 0
  .word 3
  .text "III          "
  .byte 0
  .word 2
  .text "JJJ          "
  .byte 0
  .word 1
keyOrJoyFlag:
  .byte CONTROLLED_BY_JOYSTICK
keyOrJoyText:
  .text "JOYSTICK"
  .text "KEYBOARD"
ingredientSwapTime: // milliseconds
  .word 1000 
playTime:
  .word 300 // seconds
playTimeRemaining:
  .word 0
burgerCountList:
  .byte 1,2,4
playerCount:
  .byte 1
playerGrapFlags:
  .byte 1,2,4,8
playerGrapFlag:
  .byte 0
playerPointerList:
  .word player1, player2, player3, player4
player1:
 PlayerData(character1)
player2:
 PlayerData(character2)
player3:
 PlayerData(character3)
player4:
 PlayerData(character4)
  
burgerStyleSelected:
  .byte 0
burgerStylePointerList:
  .word burgerStyle1, burgerStyle2, burgerStyle3, burgerStyle4
burgerStyle1: // standard
  .byte 0,1,3,7,8,9,$ff
burgerStyle2: // cheese
  .byte 0,1,3,4,7,8,9,$ff
burgerStyle3: // bacon
  .byte 0,1,3,4,5,7,8,9,$ff
burgerStyle4: // vegan
  .byte 0,1,2,6,7,8,9,$ff
burgerIngredientsCount:
  .byte 5
burgerRandomIngredient:
  .byte 0
burgerNames:
  .text "       HAMBURGER      "
  .text "     CHEESEBURGER     "
  .text "  BACON CHEESEBURGER  "
  .text "VEGAN GUACAMOLE BURGER"

burgerChars: 
.byte  $77,$e2,$e2,$e2,$e2,$e2,$e2,$e2,$77// 0 plate
.byte  $5f,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$69// 1 bottom bun
.byte  $66,$66,$66,$66,$66,$66,$66,$66,$66// 2 vegan patty
.byte  $66,$66,$66,$66,$66,$66,$66,$66,$66// 3 beef patty
.byte  $62,$62,$62,$62,$62,$62,$62,$62,$62// 4 cheese
.byte  $e2,$f8,$f9,$f8,$62,$f9,$f8,$62,$e2// 5 bacon
.byte  $62,$79,$62,$79,$62,$79,$62,$79,$62// 6 guacamole
.byte  $62,$62,$62,$62,$62,$62,$62,$62,$62// 7 ketchup/cucumber
.byte  $66,$66,$66,$66,$66,$66,$66,$66,$66// 8 salad
.byte  $e9,$a7,$a7,$a7,$a7,$a7,$a7,$a7,$df// 9 top bun


burgerColors:
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01// 0 plate
.byte  $08,$08,$08,$08,$08,$08,$08,$08,$08// 1 bottom bun
.byte  $09,$05,$09,$05,$09,$05,$09,$05,$09// 2 vegan patty
.byte  $09,$09,$09,$09,$09,$09,$09,$09,$09// 3 beef patty
.byte  $07,$07,$07,$07,$07,$07,$07,$07,$07// 4 cheese
.byte  $0a,$02,$09,$02,$01,$09,$0a,$02,$09// 5 bacon
.byte  $0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d// 6 guacamole
.byte  $02,$0a,$02,$0a,$0d,$05,$0d,$05,$0d// 7 ketchup/cucumber
.byte  $05,$0d,$05,$0d,$05,$0d,$05,$0d,$05// 8 salad
.byte  $08,$08,$08,$08,$08,$08,$08,$08,$08// 9 top bun



character1:
.text "CHARLY CHEESE"
.byte 0
character2:
.text "PATTY PAT    "
.byte 0
character3:
.text "BEEF BOB     "
.byte 0
character4:
.text "TOMATO TAM   "
.byte 0
character5:
.text "ONION OLLI   "
.byte 0
character6:
.text "CRUNCHY CHRIS"
.byte 0
character7:
.text "SALTY SALLY  "
.byte 0
character8:
.text "CHILI CHASE  "
.byte 0
character9:
.text "BACON BENNY  "
.byte 0
character10:
.text "VEGAN VIVIAN "
.byte 0

random5:
 RandomIngredientTable(5)
random6:
 RandomIngredientTable(6)
random7:
 RandomIngredientTable(7)
seed:
  .byte %11001010
// {SPACE}=FIRE,{[Z]or[.]=LEFT],{[X][/]=RIGHT}
//      SPACE     Z         .        X         /
keyRowMatrix:
 .byte %01111111,%11111101,%11011110,%11111011,%10111111,%01111111,%01111111,%11111101,%11111101,0
keyColumnMatrix:
 .byte %00010000,%00010000,%10000000,%10000000,%10000000,%00000001,%00001000,%00000001,%00001000
keyDirection:
 .byte %00001111,%00011011,%00011011,%00010111,%00010111
start:
  //;rts
  jsr init
restart:
  jsr reset
  jsr showMainScreen
  jsr runGame
  //jmp restart
  rts

init:
//init screen colors
 
  lda #$00
  sta FC_COLOR
  sta BG_COLOR
  jsr $e544
//init 4 player adapter  
  lda #$80
  sta USERPORT_DDR 
  lda USERPORT_DATA 
  sta USERPORT_DATA 
//prepare CIA1 for reading keyboard  
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
  cmp #CONTROLLED_BY_JOYSTICK
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
  cmp #CONTROLLED_BY_KEYBOARD
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
  lda JOYSTICK_PORT1 // read Port1
  and #$1F
  sta CONTROLLER1
  lda JOYSTICK_PORT2 // read Port2
  and #$1F
  sta CONTROLLER2
  lda USERPORT_DATA // CIA2 PortB Bit7 = 1
  ora #$80
  sta USERPORT_DATA
  lda USERPORT_DATA // read Port3
  and #$1F
  sta CONTROLLER3
  lda USERPORT_DATA // CIA2 PortB Bit7 = 0
  and #$7F
  sta USERPORT_DATA
  lda USERPORT_DATA // read Port4
  pha // Attention: FIRE for Port4 on Bit5, NOT 4.
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

setRandomIngredient:
  lda seed
  beq doEor
  asl
  beq noEor
  bcc noEor
doEor:    
  eor #$1d
noEor:  
  sta seed
  jmp ingredientFound
  tax
  lda burgerIngredientsCount
  cmp #$05
  bne six
  txa
  lda random5,x
  jmp ingredientFound
six:  
  cmp #$06
  bne seven
  txa
  lda random6,x
  jmp ingredientFound
seven:
  txa
  lda random7,x
ingredientFound:  
  sta burgerRandomIngredient
  rts
  
showBurgerVariants:
  lda #$01
  sta $a4
  lda #00 // hamburger
  ldx #00 
  ldy #13
  sta burgerStyleSelected
  jsr displayCompleteBurger
  lda #$02
  sta $a4
  lda #00 // cheeseburger
  ldx #10 
  ldy #13
  sta burgerStyleSelected
  jsr displayCompleteBurger
  lda #$03
  sta $a4
  lda #00 // bacon chesse burger
  ldx #21 
  ldy #13
  sta burgerStyleSelected
  jsr displayCompleteBurger
  lda #$04
  sta $a4
  lda #00 // vegan burger
  ldx #31 
  ldy #13
  sta burgerStyleSelected
  jsr displayCompleteBurger
  lda #$05
  sta $a4
  lda #00 // hamburger
  ldx #00 
  ldy #24
  sta burgerStyleSelected
  jsr displayCompleteBurger
  lda #$06
  sta $a4
  lda #01 // cheeseburger
  ldx #10 
  ldy #24
  sta burgerStyleSelected
  jsr displayCompleteBurger
  lda #$07
  sta $a4
  lda #01 // bacon chesse burger
  ldx #21 
  ldy #24
  sta burgerStyleSelected
  jsr displayCompleteBurger
  /*
  lda #03 //; vegan burger
  ldx #31 
  ldy #24
  sta burgerStyleSelected
  jsr displayCompleteBurger
  */
  rts
  
displayCompleteBurger:
  txa
  pha
  tya
  pha
  ldx burgerStyleSelected
  txa 
  asl
  tax
  lda burgerStylePointerList,x
  sta $94
  inx
  lda burgerStylePointerList,x
  sta $95
  ldy #$00
getNextIngredient:
  lda ($94),y
  cmp #$ff
  beq burgerSizeFound
  iny
  jmp getNextIngredient
burgerSizeFound:
  dey
  sty burgerIngredientsCount
  pla
  tay
  pla
//calculate plate offset
  sta $92
  sta $f7
  lda #$04
  sta $93
  lda #$d8
  sta $f8
calcPlateLoop:  
  clc
  lda $92
  adc #$28
  sta $92
  bcc noCarryBitChar
  inc $93
noCarryBitChar:  
  clc
  lda $f7
  adc #$28
  sta $f7
  bcc noCarryBitColor
  inc $f8
noCarryBitColor:
  dey
  beq exitCalcPlateLoop
  jmp calcPlateLoop
exitCalcPlateLoop:
  ldy #$00
getNextIngredientIndex:  
  lda ($94),y
  //cmp #$ff
  cpy $a4
  beq burgerCompleteDrawn
  sta ingredientIndex
  jsr drawIngredient
  iny
  jmp getNextIngredientIndex
burgerCompleteDrawn:
  rts
ingredientIndex:
  .byte 0
drawIngredient:
  tya
  pha
  
  lda #$00
  ldx ingredientIndex
calculateIngredientOffset:
  beq calculateIngredientOffsetExit
  clc
  adc #$09
  dex
  jmp calculateIngredientOffset
calculateIngredientOffsetExit:
  tax
  
  ldy #$00
drawIngredientLoop:
  lda burgerChars,x
  sta ($92),y
  lda burgerColors,x
  sta ($f7),y
  inx
  iny
  cpy #$09
  bne drawIngredientLoop
  sec
  lda $92
  sbc #$28
  sta $92
  lda $93
  sbc #$00
  sta $93
  sec
  lda $f7
  sbc #$28
  sta $f7
  lda $f8
  sbc #$00
  sta $f8
  
  
  pla
  tay
  rts
  
  
  
showMainScreen:
  rts
  
runGame:
loop:
  jsr readController
  jsr logControllers
  jsr showBurgerVariants
  //jsr logRandomIngredient

  //jmp loop
  rts

logRandomIngredient:
  lda  seed
  sta  $0400
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
  sta $0405
  rts
  

