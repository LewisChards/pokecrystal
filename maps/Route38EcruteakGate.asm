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
	const ROUTE38ECRUTEAKGATE_OFFICER


SECTION "maps/Route38EcruteakGate.asm", ROMX

Route38EcruteakGate_MapScripts::
	db 0 ; scene scripts

	db 0 ; callbacks

Route38EcruteakGateOfficerScript:
	jumptextfaceplayer Route38EcruteakGateOfficerText

Route38EcruteakGateOfficerText:
	text "Where did you say"
	line "you're from?"

	para "NEW BARK TOWN?"

	para "PROF.ELM lives"
	line "over there, right?"

	para "You've come a long"
	line "way to get here."
	done

Route38EcruteakGate_MapEvents::
	db 0, 0 ; filler

	db 4 ; warp events
	warp_event  0,  4, ROUTE_38, 1
	warp_event  0,  5, ROUTE_38, 2
	warp_event  9,  4, ECRUTEAK_CITY, 14
	warp_event  9,  5, ECRUTEAK_CITY, 15

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route38EcruteakGateOfficerScript, -1
