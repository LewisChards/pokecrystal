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
INCLUDE "constants/script_constants.inc"
INCLUDE "constants/sprite_constants.inc"
INCLUDE "constants/sprite_data_constants.inc"

	object_const_def ; object_event constants
	const ROUTE32RUINSOFALPHGATE_OFFICER
	const ROUTE32RUINSOFALPHGATE_POKEFAN_M
	const ROUTE32RUINSOFALPHGATE_YOUNGSTER


SECTION "maps/Route32RuinsOfAlphGate.asm", ROMX

Route32RuinsOfAlphGate_MapScripts::
	db 0 ; scene scripts

	db 0 ; callbacks

Route32RuinsOfAlphGateOfficerScript:
	jumptextfaceplayer Route32RuinsOfAlphGateOfficerText

Route32RuinsOfAlphGatePokefanMScript:
	jumptextfaceplayer Route32RuinsOfAlphGatePokefanMText

Route32RuinsOfAlphGateYoungsterScript:
	jumptextfaceplayer Route32RuinsOfAlphGateYoungsterText

Route32RuinsOfAlphGateOfficerText:
	text "RUINS OF ALPH"

	para "A Look-and-Touch"
	line "Tourist Site"

	para "Try the sliding"
	line "stone panels!"
	done

Route32RuinsOfAlphGatePokefanMText:
	text "You're studying"
	line "the RUINS?"

	para "I see a scientist"
	line "in the making."
	done

Route32RuinsOfAlphGateYoungsterText:
	text "There are drawings"
	line "on stone panels."

	para "I tried moving"
	line "them. I wonder"
	cont "what they are."
	done

Route32RuinsOfAlphGate_MapEvents::
	db 0, 0 ; filler

	db 4 ; warp events
	warp_event  0,  4, RUINS_OF_ALPH_OUTSIDE, 10
	warp_event  0,  5, RUINS_OF_ALPH_OUTSIDE, 11
	warp_event  9,  4, ROUTE_32, 2
	warp_event  9,  5, ROUTE_32, 3

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route32RuinsOfAlphGateOfficerScript, -1
	object_event  8,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route32RuinsOfAlphGatePokefanMScript, -1
	object_event  1,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route32RuinsOfAlphGateYoungsterScript, -1
