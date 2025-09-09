.pc = $0801
.encoding "screencode_upper"
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

.const LEFT  = $1b
.const RIGHT = $17

.const CONTROLLED_BY_KEYBOARD = 1 
.const CONTROLLED_BY_JOYSTICK = 0

.const SHOW_CASE_DELAY_TIME = 20

.macro SaveCurrentTimerToAddress(address){
  lda $a2
  sta address+2
  lda $a1
  sta address+1
  lda $a0
  sta address
}

// layerNo ff means all layers else index
.macro drawBurgerAt(layerNo,x,y){
  lda #layerNo 
  sta $a4
  ldx #x 
  ldy #y
  jsr drawBurger
}

.macro AddToAddress(address,value){
  clc
  lda address
  adc #<value
  sta address
  bcc skip
  lda address+1
  adc #>value
  sta address+1
skip:
  nop
}

.macro SubstractFromAddress(address,value){
  sec
  lda address
  sbc #<value
  sta address
  lda address+1
  sbc #>value
  sta address+1
}
.macro PlayerData(characterPointer) {
player:
  .word characterPointer
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
nextLayer:
  .byte 1
}

.macro RandomIngredientTable(max){
  .for(var i=0;i<=256;i++) .byte random()*max
}

:BasicUpstart2(go)
go:
	jmp start

showCaseDelayStart:
  .byte 20,0,0
controllerStates:
  .byte 0,0,0,0,0
statesChanged:
  .byte 0,0,0,0
canHaveRandomGaps:
  .byte 0
showBurgerAndIngredientNames:
  .byte 0
layerWidth:
  .byte 26
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
 gameSpeedCurrent:
  .byte 0
gameSpeedMax:
  .byte 3
gameSpeedText:
  .text "   NUB   "
  .text "  SOLID  "
  .text " SKILLED "
  .text " GODLIKE "
takeMode:
  .byte GRAP_FCFS
takeModeText:
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
burgerStyleSelectedTemporary:
  .byte 0
maxBurgerStyles:
  .byte 4
maxBurgerLayers:
  .byte 8
burgerList:
  .word burger1, burger2, burger3, burger4, burger5, $ffff
burgerValue:
  .byte 50,60,70,60,60
burger1: // standard
  .byte 01,02,04,09,10,11,00,00,$ff
burger2: // cheese
  .byte 01,02,04,05,09,10,11,00,$ff
burger3: // bacon
  .byte 01,02,04,05,07,09,10,11,$ff
burger4: // vegan
  .byte 01,02,03,08,09,10,11,00,$ff
burger5: // double chili cheese
  .byte 01,02,04,06,04,09,11,00,$ff

burgerIngredientsCount:
  .byte 0
burgerRandomIngredient:
  .byte 0
burgerNames:
  .text "         HAMBURGER         "
  .text "       CHEESEBURGER        "
  .text "       CHICKENBURGER       "
  .text "    BACON CHEESEBURGER     "
  .text " DOUBLE BACON CHEESEBURGER "
  .text "  VEGAN GUACAMOLE BURGER   "
  .text "    DOUBLE CHILIBURGER     "

ingredientNames:
  .text "                  "
  .text " PLATE            "
  .text " BOTTOM BUN       "
  .text " VEGAN PATTY      "
  .text " BEEF PATTY       "
  .text " CHEESE           "
  .text " CHILI CHEESE     "
  .text " BACON            "
  .text " GUACAMOLE        "
  .text " KETCHUP/CUCUMBER "
  .text " SALAD            "
  .text " TOP BUN          "
  
burgerLayer: 
  .byte  $20,$20,$20,$20,$20,$20,$20,$20,$20// 0  empty  
  .byte  $77,$e2,$e2,$e2,$e2,$e2,$e2,$e2,$77// 1  plate
  .byte  $5f,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$69// 2  bottom bun
  .byte  $66,$66,$66,$66,$66,$66,$66,$66,$66// 3  vegan patty
  .byte  $66,$66,$66,$66,$66,$66,$66,$66,$66// 4  beef patty
  .byte  $62,$62,$62,$62,$62,$62,$62,$62,$62// 5  cheese
  .byte  $e0,$62,$62,$79,$78,$62,$62,$78,$79// 6  chili cheese
  .byte  $e2,$f8,$f9,$f8,$62,$f9,$f8,$62,$e2// 7  bacon
  .byte  $62,$79,$62,$79,$62,$79,$62,$79,$62// 8  guacamole
  .byte  $62,$62,$62,$62,$62,$62,$62,$62,$62// 9  ketchup/cucumber
  .byte  $66,$66,$66,$66,$66,$66,$66,$66,$66// 10 salad
  .byte  $e9,$a7,$a7,$a7,$a7,$a7,$a7,$a7,$df// 11 top bun
  
  
burgerLayerColor:
  .byte  $00,$00,$00,$00,$00,$00,$00,$00,$00// 0  empty
  .byte  $01,$01,$01,$01,$01,$01,$01,$01,$01// 1  plate
  .byte  $08,$08,$08,$08,$08,$08,$08,$08,$08// 2  bottom bun
  .byte  $09,$05,$09,$05,$09,$05,$09,$05,$09// 3  vegan patty
  .byte  $09,$09,$09,$09,$09,$09,$09,$09,$09// 4  beef patty
  .byte  $07,$07,$07,$07,$07,$07,$07,$07,$07// 5  cheese
  .byte  $07,$05,$05,$07,$07,$05,$05,$07,$07// 6  chili cheese
  .byte  $0a,$02,$09,$02,$01,$09,$0a,$02,$09// 7  bacon
  .byte  $0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d// 8  guacamole
  .byte  $02,$0a,$02,$0a,$0d,$05,$0d,$05,$0d// 9  ketchup/cucumber
  .byte  $05,$0d,$05,$0d,$05,$0d,$05,$0d,$05// 10 salad
  .byte  $08,$08,$08,$08,$08,$08,$08,$08,$08// 11 top bun
    
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
  .byte 0
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
  jsr initRasterInterrupt
restart:
  jsr reset
  jsr showMainScreen
  jsr initTimer
  jsr runGame
  //jmp restart
  rts

init:
//init screen colors
  jsr initSeed
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
initRasterInterrupt:
  sei                  
  lda #%01111111       // switch off interrupt signals from CIA-1
  sta $DC0D

  and $D011            // clear most significant bit of VIC's raster register
  sta $D011

  lda $DC0D            // acknowledge pending interrupts from CIA-1
  lda $DD0D            // acknowledge pending interrupts from CIA-2

  lda #0              // set rasterline where interrupt shall occur
  sta $D012

  lda #irqServiceRoutine
  sta $0314
  lda #>irqServiceRoutine
  sta $0315

  lda #%00000001       // enable raster interrupt signals from VIC
  sta $D01A

  cli
  rts

irqServiceRoutine:
  dec showCaseDelayStart
  asl $d019
  jmp $ea81
    
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
  cmp CONTROLLER1
  beq rjStateNotChanged1
  sta CONTROLLER1
  lda #$01
  jmp rjSetState1
rjStateNotChanged1:
  lda #$00
rjSetState1:  
  sta statesChanged
  
  lda JOYSTICK_PORT2 // read Port2
  and #$1F
  cmp CONTROLLER2
  beq rjStateNotChanged2
  sta CONTROLLER2
  lda #$01
  jmp rjSetState2
rjStateNotChanged2:
  lda #$00
rjSetState2:  
  sta statesChanged+1

  lda USERPORT_DATA // CIA2 PortB Bit7 = 1
  ora #$80
  sta USERPORT_DATA
  lda USERPORT_DATA // read Port3
  and #$1F
  cmp CONTROLLER3
  beq rjStateNotChanged3
  sta CONTROLLER3
  lda #$01
  jmp rjSetState3
rjStateNotChanged3:
  lda #$00
rjSetState3:  
  sta statesChanged+2

  lda USERPORT_DATA // CIA2 PortB Bit7 = 0
  and #$7F
  sta USERPORT_DATA
  lda USERPORT_DATA // read Port4
  cmp CONTROLLER4
  beq rjStateNotChanged4
  pha // Attention: FIRE for Port4 on Bit5, NOT 4.
  and #$0F
  sta CONTROLLER4
  pla
  and #$20
  lsr
  ora CONTROLLER4
  sta CONTROLLER4
  lda #$01
  jmp rjSetState4
rjStateNotChanged4:
  lda #$00
rjSetState4:  
  sta statesChanged+3
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

initSeed:
  lda #$ff
  sta $d40e
  sta $d40f
  lda #$80
  sta $d412
  lda $d41b
  sta seed
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
  tax
  lda burgerIngredientsCount
  cmp #$05
  bne six
  lda random5,x
  jmp ingredientFound
six:  
  cmp #$06
  bne seven
  lda random6,x
  jmp ingredientFound
seven:
  lda random7,x
ingredientFound:  
  sta burgerRandomIngredient
  rts
  
  
browseBurgerVariants:
  lda statesChanged
  cmp #$00
  beq exitShowBurger
  lda burgerStyleSelected
  
  
  /*
  sta burgerStyleSelectedTemporary
  lda #$05
  sta burgerStyleSelected
  lda #$ff // show empty burger
  sta $a4
  ldx #01 
  ldy #10
  jsr drawBurger

  lda burgerStyleSelectedTemporary
  */
  
  
  sta burgerStyleSelected
  drawBurgerAt($ff,0,9)

  lda CONTROLLER1
  cmp #RIGHT
  bne isLeft
  inc burgerStyleSelected
  lda burgerStyleSelected
  cmp maxBurgerStyles 
  bne exitShowBurger
  lda #00
  sta burgerStyleSelected
  jmp exitShowBurger
isLeft:
  cmp #LEFT
  bne exitShowBurger
  dec burgerStyleSelected 
  lda burgerStyleSelected 
  cmp #$00
  bpl exitShowBurger
  lda #$04
  sta burgerStyleSelected
exitShowBurger:
  rts
  
drawBurger:
  txa
  pha
  tya
  pha
  ldx burgerStyleSelected
  txa 
  asl
  tax
  lda burgerList,x
  sta $94
  inx
  lda burgerList,x
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
  cmp #$ff
  beq burgerCompleteDrawn
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
  adc #09
  dex
  jmp calculateIngredientOffset
calculateIngredientOffsetExit:
  tax
  ldy #$00
drawIngredientLoop:
  lda burgerLayer,x
  sta ($92),y
  lda burgerLayerColor,x
  sta ($f7),y
  inx
  iny
  cpy #09  
  bne drawIngredientLoop
  SubstractFromAddress($92,$28)
  SubstractFromAddress($f7,$28)
  pla
  tay
  rts
  
  
  
showMainScreen:
  rts

initTimer:
 //SaveCurrentTimerToAddress(showCaseDelayStart)
 //AddToAddress(showCaseDelayStart,30)
 lda #4
 sta burgerStyleSelected
  
runGame:
loop:
  //jsr readController
  //jsr logControllers
  //jsr browseBurgerVariants
  
	
  jsr burgerShowCase
 
  
  //jsr setRandomIngredient
  //jsr logRandomIngredient
  //jsr logTimer

  jmp loop
end:
  rts

burgerShowCase:

  lda showCaseDelayStart
  bne burgerShowCase
  lda #SHOW_CASE_DELAY_TIME
  sta showCaseDelayStart
  
  drawBurgerAt($ff,0,9)
  drawBurgerAt($ff,20,9)
  drawBurgerAt($ff,0,20)
  drawBurgerAt($ff,20,20)
  

  dec burgerStyleSelected
  bpl loop
  lda #4
  sta burgerStyleSelected
  lda #SHOW_CASE_DELAY_TIME
  sta showCaseDelayStart
  jmp burgerShowCase
  
logRandomIngredient:
  lda burgerRandomIngredient
  adc #48
  sta $0400
  rts
  
logTimer:
  lda $a0
  
  sta $0400
  lda $a1
  
  sta $0402
  lda $a2
  
  sta $0404
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
  

