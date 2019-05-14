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
INCLUDE "constants/std_constants.inc"

	object_const_def ; object_event constants
	const GOLDENRODNAMERATER_NAME_RATER


SECTION "maps/GoldenrodNameRater.asm", ROMX

GoldenrodNameRater_MapScripts::
	db 0 ; scene scripts

	db 0 ; callbacks

GoldenrodNameRater:
	faceplayer
	opentext
	special NameRater
	waitbutton
	closetext
	end

GoldenrodNameRaterBookshelf:
	jumpstd difficultbookshelf

GoldenrodNameRaterRadio:
	jumpstd radio2

INCLUDE "data/text/unused_sweet_honey.inc"

GoldenrodNameRater_MapEvents::
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  2,  7, GOLDENROD_CITY, 8
	warp_event  3,  7, GOLDENROD_CITY, 8

	db 0 ; coord events

	db 3 ; bg events
	bg_event  0,  1, BGEVENT_READ, GoldenrodNameRaterBookshelf
	bg_event  1,  1, BGEVENT_READ, GoldenrodNameRaterBookshelf
	bg_event  7,  1, BGEVENT_READ, GoldenrodNameRaterRadio

	db 1 ; object events
	object_event  2,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 2, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodNameRater, -1
