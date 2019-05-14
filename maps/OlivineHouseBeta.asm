INCLUDE "charmap.inc"
INCLUDE "macros/data.inc"
INCLUDE "macros/enum.inc"
INCLUDE "macros/scripts/events.inc"
INCLUDE "macros/scripts/maps.inc"
INCLUDE "macros/scripts/text.inc"
INCLUDE "constants/wram_constants.inc"
INCLUDE "constants/gfx_constants.inc"
INCLUDE "constants/map_constants.inc"
INCLUDE "constants/map_object_constants.inc"
INCLUDE "constants/pokemon_constants.inc"
INCLUDE "constants/script_constants.inc"
INCLUDE "constants/sprite_constants.inc"
INCLUDE "constants/std_constants.inc"

	object_const_def ; object_event constants
	const OLIVINEHOUSEBETA_TEACHER
	const OLIVINEHOUSEBETA_RHYDON


SECTION "maps/OlivineHouseBeta.asm", ROMX

OlivineHouseBeta_MapScripts::
	db 0 ; scene scripts

	db 0 ; callbacks

OlivineHouseBetaTeacherScript:
	jumptextfaceplayer OlivineHouseBetaTeacherText

OlivineHouseBetaRhydonScript:
	opentext
	writetext OlivineHouseBetaRhydonText
	cry RHYDON
	waitbutton
	closetext
	end

OlivineHouseBetaBookshelf1:
	jumpstd picturebookshelf

OlivineHouseBetaBookshelf2:
	jumpstd magazinebookshelf

OlivineHouseBetaTeacherText:
	text "When my #MON"
	line "got sick, the"

	para "PHARMACIST in"
	line "ECRUTEAK made some"
	cont "medicine for me."
	done

OlivineHouseBetaRhydonText:
	text "RHYDON: Gugooh!"
	done

OlivineHouseBeta_MapEvents::
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  2,  7, OLIVINE_CITY, 4
	warp_event  3,  7, OLIVINE_CITY, 4

	db 0 ; coord events

	db 2 ; bg events
	bg_event  0,  1, BGEVENT_READ, OlivineHouseBetaBookshelf1
	bg_event  1,  1, BGEVENT_READ, OlivineHouseBetaBookshelf2

	db 2 ; object events
	object_event  2,  3, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineHouseBetaTeacherScript, -1
	object_event  6,  4, SPRITE_RHYDON, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineHouseBetaRhydonScript, -1
