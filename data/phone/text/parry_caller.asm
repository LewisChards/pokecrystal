INCLUDE "charmap.inc"
INCLUDE "macros/enum.inc"
INCLUDE "macros/scripts/text.inc"



SECTION "data/phone/text/parry_caller.asm", ROMX

ParryNoMatchText::
	text "Nothing can match"
	line "my @"
	text_ram wStringBuffer4
	text " now."
	done

UnknownText_0x66fc0::
	text "Yeah, we KO'd a"
	line "wild @"
	text_ram wStringBuffer4
	text "!"

	para "That was OK, but I"
	line "wanted to get it…"
	done

UnknownText_0x67001::
	text "And yesterday, we"
	line "spotted a wild"

	para "@"
	text_ram wStringBuffer4
	text "."
	line "We were debating"

	para "whether to catch"
	line "it or beat it."

	para "When along came"
	line "another guy who"

	para "caught it!"
	line "How about that!"
	done

UnknownText_0x67096::
	text "You're thinking"
	line "you'd like to"

	para "battle me. Am I"
	line "right or what?"

	para "Yep! We'll meet on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done

UnknownText_0x670eb::
	text "OK, give me a call"
	line "again!"
	done

ParryBattleWithMeText::
	text "You'll battle with"
	line "me again, right?"
	done

ParryHaventYouGottenToText::
	text "Haven't you gotten"
	line "to @"
	text_ram wStringBuffer5
	text "?"

	para "Waiting here isn't"
	line "bad, but I'd sure"
	cont "like to battle!"
	done
