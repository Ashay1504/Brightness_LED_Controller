; whack-a-mole
ORG 0

startGameAnimation:
	; animation
	LOAD Score
	OUT Hex0
	CALL RunStartAnimation
	CALL RunStartAnimation
	CALL RunStartAnimation

startGameLoop:
	; set to known state with lights
	; start incrementing randNum
	; once sw9 is up, go to firstRound
	LOAD all_lights
	OUT LEDs_p
	LOAD full_br
	OUT Gamma_p
	
	LOAD randNum
	ADDI 1
	STORE randNum
	
	IN Switches
	AND Bit9 ; check sw9
	JPOS nextRound
	
	JUMP startGameLoop
	
nextRound:
	; display the score onto hex1
	LOAD Score
	OUT Hex1
	
	CALL getMoleLocation
	nextRoundJumpTo:
	CALL RunRisingAnimation
	OUT Timer ; reset timer
	CALL moleCaptureLoop
		LOAD Score
		ADDI 1
		STORE Score ; increment score by 1 upon capturingMole
		LOAD Score
		OUT Hex1
	CALL RunFallingAnimation
	
	; check score
	LOAD Score
	ADDI -10
	JZERO winAnimation
	
	JUMP nextRound

winAnimation:
	CALL BlinkLights
	LOAD full_br
	OUT Gamma_p
	LOAD alt_lights
	OUT LEDs_p
	LOAD dif_lights
	OUT LEDs_p
	
	LOADI 0
	STORE Score
	
	IN Switches
	AND Bit9 ; check sw9
	JPOS startGameAnimation
	
	
	JUMP winAnimation


moleCaptureLoop:
	IN Timer
	STORE TimeSpent
	
	LOAD randNum
	ADDI 1
	STORE randNum
	
	LOAD TimeSpent
	ADDI -25
	JPOS decreaseScore
	
	IN Switches
	AND moleLocation 
	
	JZERO moleCaptureLoop ; if switches != moleLocation, go back to moleCaptureLoop
	returnFromDecreaseScore:
		NOP
	RETURN

decreaseScore:
	LOAD Score
	ADDI -1
	
	JNEG returnFromDecreaseScore ; set back to 0
	STORE Score
	JUMP returnFromDecreaseScore


getMoleLocation:
	; given some randomNumber
	; returns bit location
	LOAD randNum
	AND AND_const
	STORE randNum_AND
	
	LOAD randNum_AND
	JZERO ifZero
	
	LOAD randNum_AND
	ADDI -9
	JZERO ifNine
	
	LOAD randNum_AND
	ADDI -8
	JZERO ifEight
	
	LOAD randNum_AND
	ADDI -7
	JZERO ifSeven	
	
	LOAD randNum_AND
	ADDI -6
	JZERO ifSix
	
	LOAD randNum_AND
	ADDI -5
	JZERO ifFive
	
	LOAD randNum_AND
	ADDI -4
	JZERO ifFour
	
	LOAD randNum_AND
	ADDI -3
	JZERO ifThree
	
	LOAD randNum_AND
	ADDI -2
	JZERO ifTwo
	
	LOAD randNum_AND
	ADDI -1
	JZERO ifOne
	
	LOAD randNum_AND
	CALL ifZero
	RETURN
	
	
ifNine:
	LOADI &B0000001000000000
	STORE moleLocation
	JUMP nextRoundJumpTo
ifEight:
	LOADI &B0000000100000000
	STORE moleLocation
	JUMP nextRoundJumpTo
ifSeven:
	LOADI &B0000000010000000
	STORE moleLocation
	JUMP nextRoundJumpTo
ifSix:
	LOADI &B0000000001000000
	STORE moleLocation
	JUMP nextRoundJumpTo
ifFive:
	LOADI &B0000000000100000
	STORE moleLocation
	JUMP nextRoundJumpTo
ifFour:
	LOADI &B0000000000010000
	STORE moleLocation
	JUMP nextRoundJumpTo
ifThree:
	LOADI &B0000000000001000
	STORE moleLocation
	JUMP nextRoundJumpTo
ifTwo:
	LOADI &B0000000000000100
	STORE moleLocation
	JUMP nextRoundJumpTo
ifOne:
	LOADI &B0000000000000010
	STORE moleLocation
	JUMP nextRoundJumpTo
ifZero:
	LOADI &B0000000000000001
	STORE moleLocation
	JUMP nextRoundJumpTo


RunStartAnimation:
	CALL BlinkLights
	LOAD full_br
	CALL Delay
	RETURN
	
	
Delay: 
 	OUT Timer
    WaitingLoop:
    IN Timer
    ADDI -1 ; 100ms second delay
    JNEG WaitingLoop
    RETURN

BlinkLights:
	; reset lights to a known state
    LOAD all_lights
    OUT LEDs_p
    
	Load zero_br
	OUT Gamma_p
	CALL Delay
	CALL Delay
	CALL Delay
	
    LOAD ten_br
    OUT Gamma_p
    CALL Delay
    
    LOAD twenty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD thirty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD forty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD fifty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD sixty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD seventy_br
    OUT Gamma_p
    CALL Delay
    
    LOAD eighty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD ninety_br
    OUT Gamma_p
    CALL Delay
    
    LOAD full_br
    OUT Gamma_p
    CALL Delay
	
    LOAD ninety_br
    OUT Gamma_p
    CALL Delay

    LOAD eighty_br
    OUT Gamma_p
    CALL Delay

    LOAD seventy_br
    OUT Gamma_p
    CALL Delay

    LOAD sixty_br
    OUT Gamma_p
    CALL Delay

    LOAD fifty_br
    OUT Gamma_p
    CALL Delay

    LOAD forty_br
    OUT Gamma_p
    CALL Delay

    LOAD thirty_br
    OUT Gamma_p
    CALL Delay

    LOAD twenty_br
    OUT Gamma_p
    CALL Delay

    LOAD ten_br
    OUT Gamma_p
    CALL Delay  
    RETURN

RunRisingAnimation:
	; set lights to moleLocation
    LOAD moleLocation
    OUT LEDs_p
    ; run animation
	Load zero_br
	OUT Gamma_p
	CALL Delay
	CALL Delay
	CALL Delay
	
    LOAD ten_br
    OUT Gamma_p
    CALL Delay
    
    LOAD twenty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD thirty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD forty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD fifty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD sixty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD seventy_br
    OUT Gamma_p
    CALL Delay
    
    LOAD eighty_br
    OUT Gamma_p
    CALL Delay
    
    LOAD ninety_br
    OUT Gamma_p
    CALL Delay
    
    LOAD full_br
    OUT Gamma_p
    CALL Delay
    
    RETURN
    
RunFallingAnimation:
	; set lights to moleLocation
	LOAD moleLocation
	OUT LEDs_p
	
	; run animation
	LOAD full_br
	OUT Gamma_p
    CALL Delay
	
    LOAD ninety_br
    OUT Gamma_p
    CALL Delay

    LOAD eighty_br
    OUT Gamma_p
    CALL Delay

    LOAD seventy_br
    OUT Gamma_p
    CALL Delay

    LOAD sixty_br
    OUT Gamma_p
    CALL Delay

    LOAD fifty_br
    OUT Gamma_p
    CALL Delay

    LOAD forty_br
    OUT Gamma_p
    CALL Delay

    LOAD thirty_br
    OUT Gamma_p
    CALL Delay

    LOAD twenty_br
    OUT Gamma_p
    CALL Delay

    LOAD ten_br
    OUT Gamma_p
    CALL Delay
    
    LOAD zero_br
    OUT Gamma_p
    Call Delay
    RETURN


; Game variables
Score:		DW 0
randNum:	DW 0
randNum_AND: DW 0

Bit9:		DW &B1000000000 ; used for masking with bit9
AND_const:	DW &B0000000000001111 ; 
TimeSpent:  DW 0

moleLocation: DW &B0000001111111111

; IO ADDR Peripherals
Switches: 	equ 000
Timer: 		equ 002
Hex0:		equ 004
Hex1:		equ 005

	; switch values if necessary
LEDs_p:		equ &H021
Gamma_p: 	equ &H020
	; daniel peripheral LED: 021	Gamma: 020
	; omar   peripheral LED: 020	Gamma: 021

; led configurations
all_lights: DW &B0000001111111111
alt_lights: DW &B0000001010101010
dif_lights: DW &B0000000101010101

; brightness values
zero_br:	DW &B0000000000000000
ten_br:		DW &B0000000000011010
twenty_br:	DW &B0000000000110100
thirty_br:	DW &B0000000001001101
forty_br:	DW &B0000000001100111
fifty_br:	DW &B0000000010000000
sixty_br:	DW &B0000000010011010
seventy_br: DW &B0000000010110011
eighty_br:	DW &B0000000011001101
ninety_br:	DW &B0000000011100110
full_br:	DW &B0000000011111111