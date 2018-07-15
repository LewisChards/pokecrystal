; Functions relating to the timer interrupt and the real-time-clock.

LatchClock::
; latch clock counter data
	ld a, 0
	ld [MBC3LatchClock], a
	ld a, 1
	ld [MBC3LatchClock], a
	ret

UpdateTime::
	call GetClock
	call FixDays
	call FixTime
	farcall GetTimeOfDay
	ret

GetClock::
; store clock data in hRTCDayHi-hRTCSeconds

; enable clock r/w
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a

; clock data is 'backwards' in hram

	call LatchClock
	ld hl, MBC3SRamBank
	ld de, MBC3RTC

	ld [hl], RTC_S
	ld a, [de]
	maskbits 60
	ld [hRTCSeconds], a

	ld [hl], RTC_M
	ld a, [de]
	maskbits 60
	ld [hRTCMinutes], a

	ld [hl], RTC_H
	ld a, [de]
	maskbits 24
	ld [hRTCHours], a

	ld [hl], RTC_DL
	ld a, [de]
	ld [hRTCDayLo], a

	ld [hl], RTC_DH
	ld a, [de]
	ld [hRTCDayHi], a

; unlatch clock / disable clock r/w
	call CloseSRAM
	ret

FixDays::
; fix day count
; mod by 140

; check if day count > 255 (bit 8 set)
	ld a, [hRTCDayHi] ; DH
	bit 0, a
	jr z, .daylo
; reset dh (bit 8)
	res 0, a
	ld [hRTCDayHi], a ; DH

; mod 140
; mod twice since bit 8 (DH) was set
	ld a, [hRTCDayLo] ; DL
.modh
	sub 140
	jr nc, .modh
.modl
	sub 140
	jr nc, .modl
	add 140

; update dl
	ld [hRTCDayLo], a ; DL

; flag for sRTCStatusFlags
	ld a, %01000000
	jr .set

.daylo
; quit if fewer than 140 days have passed
	ld a, [hRTCDayLo] ; DL
	cp 140
	jr c, .quit

; mod 140
.mod
	sub 140
	jr nc, .mod
	add 140

; update dl
	ld [hRTCDayLo], a ; DL

; flag for sRTCStatusFlags
	ld a, %00100000

.set
; update clock with modded day value
	push af
	call SetClock
	pop af
	scf
	ret

.quit
	xor a
	ret

FixTime::
; add ingame time (set at newgame) to current time
;				  day     hr    min    sec
; store time in wCurDay, hHours, hMinutes, hSeconds

; second
	ld a, [hRTCSeconds] ; S
	ld c, a
	ld a, [wStartSecond]
	add c
	sub 60
	jr nc, .updatesec
	add 60
.updatesec
	ld [hSeconds], a

; minute
	ccf ; carry is set, so turn it off
	ld a, [hRTCMinutes] ; M
	ld c, a
	ld a, [wStartMinute]
	adc c
	sub 60
	jr nc, .updatemin
	add 60
.updatemin
	ld [hMinutes], a

; hour
	ccf ; carry is set, so turn it off
	ld a, [hRTCHours] ; H
	ld c, a
	ld a, [wStartHour]
	adc c
	sub 24
	jr nc, .updatehr
	add 24
.updatehr
	ld [hHours], a

; day
	ccf ; carry is set, so turn it off
	ld a, [hRTCDayLo] ; DL
	ld c, a
	ld a, [wStartDay]
	adc c
	ld [wCurDay], a
	ret

InitTimeOfDay::
	xor a
	ld [wStringBuffer2], a
	ld a, $0 ; useless
	ld [wStringBuffer2 + 3], a
	jr InitTime

InitDayOfWeek::
	call UpdateTime
	ld a, [hHours]
	ld [wStringBuffer2 + 1], a
	ld a, [hMinutes]
	ld [wStringBuffer2 + 2], a
	ld a, [hSeconds]
	ld [wStringBuffer2 + 3], a
	jr InitTime ; useless

InitTime::
	farcall _InitTime
	ret

PanicResetClock::
	call .ClearhRTC
	call SetClock
	ret

.ClearhRTC:
	xor a
	ld [hRTCSeconds], a
	ld [hRTCMinutes], a
	ld [hRTCHours], a
	ld [hRTCDayLo], a
	ld [hRTCDayHi], a
	ret

SetClock::
; set clock data from hram

; enable clock r/w
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a

; set clock data
; stored 'backwards' in hram

	call LatchClock
	ld hl, MBC3SRamBank
	ld de, MBC3RTC

; seems to be a halt check that got partially commented out
; this block is totally pointless
	ld [hl], RTC_DH
	ld a, [de]
	bit 6, a ; halt
	ld [de], a

; seconds
	ld [hl], RTC_S
	ld a, [hRTCSeconds]
	ld [de], a
; minutes
	ld [hl], RTC_M
	ld a, [hRTCMinutes]
	ld [de], a
; hours
	ld [hl], RTC_H
	ld a, [hRTCHours]
	ld [de], a
; day lo
	ld [hl], RTC_DL
	ld a, [hRTCDayLo]
	ld [de], a
; day hi
	ld [hl], RTC_DH
	ld a, [hRTCDayHi]
	res 6, a ; make sure timer is active
	ld [de], a

; cleanup
	call CloseSRAM ; unlatch clock, disable clock r/w
	ret

RecordRTCStatus::
; append flags to sRTCStatusFlags
	ld hl, sRTCStatusFlags
	push af
	ld a, BANK(sRTCStatusFlags)
	call GetSRAMBank
	pop af
	or [hl]
	ld [hl], a
	call CloseSRAM
	ret

CheckRTCStatus::
; check sRTCStatusFlags
	ld a, BANK(sRTCStatusFlags)
	call GetSRAMBank
	ld a, [sRTCStatusFlags]
	call CloseSRAM
	ret
