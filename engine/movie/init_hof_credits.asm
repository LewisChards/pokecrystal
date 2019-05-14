INCLUDE "charmap.inc"
INCLUDE "macros/coords.inc"
INCLUDE "macros/enum.inc"
INCLUDE "macros/gfx.inc"
INCLUDE "macros/scripts/text.inc"
INCLUDE "constants/gfx_constants.inc"
INCLUDE "constants/hardware_constants.inc"


SECTION "engine/movie/init_hof_credits.asm@InitDisplayForHallOfFame", ROMX

InitDisplayForHallOfFame::
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	call LoadStandardFont
	call LoadFontsBattleExtra
	hlbgcoord 0, 0
	ld bc, vBGMap1 - vBGMap0
	ld a, " "
	call ByteFill
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	call EnableLCD
	ld hl, .SavingRecordDontTurnOff
	call PrintText
	call WaitBGMap2
	call SetPalettes
	ret

.SavingRecordDontTurnOff:
	; SAVING RECORD… DON'T TURN OFF!
	text_far _SavingRecordText
	text_end


SECTION "engine/movie/init_hof_credits.asm@InitDisplayForRedCredits", ROMX

InitDisplayForRedCredits::
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	call LoadStandardFont
	call LoadFontsBattleExtra
	hlbgcoord 0, 0
	ld bc, vBGMap1 - vBGMap0
	ld a, " "
	call ByteFill
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	ld hl, wBGPals1
	ld c, 4 tiles
.load_white_palettes
	ld a, LOW(PALRGB_WHITE)
	ld [hli], a
	ld a, HIGH(PALRGB_WHITE)
	ld [hli], a
	dec c
	jr nz, .load_white_palettes
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	call EnableLCD
	call WaitBGMap2
	call SetPalettes
	ret


SECTION "engine/movie/init_hof_credits.asm@ResetDisplayBetweenHallOfFameMons", ROMX

ResetDisplayBetweenHallOfFameMons::
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	ld hl, wDecompressScratch
	ld bc, wScratchAttrMap - wDecompressScratch
	ld a, " "
	call ByteFill
	hlbgcoord 0, 0
	ld de, wDecompressScratch
	ld b, 0
	ld c, 4 tiles
	call Request2bpp
	pop af
	ldh [rSVBK], a
	ret
