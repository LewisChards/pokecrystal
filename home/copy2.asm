CopyBytes::
; copy bc bytes from hl to de
	inc b ; we bail the moment b hits 0, so include the last run
	inc c ; same thing; include last byte
	jr .HandleLoop
.CopyByte:
	ld a, [hli]
	ld [de], a
	inc de
.HandleLoop:
	dec c
	jr nz, .CopyByte
	dec b
	jr nz, .CopyByte
	ret

ByteFill::
; fill bc bytes with the value of a, starting at hl
	inc b ; we bail the moment b hits 0, so include the last run
	inc c ; same thing; include last byte
	jr .HandleLoop
.PutByte:
	ld [hli], a
.HandleLoop:
	dec c
	jr nz, .PutByte
	dec b
	jr nz, .PutByte
	ret

GetFarByte::
; retrieve a single byte from a:hl, and return it in a.
	; bankswitch to new bank
	ld [hBuffer], a
	ld a, [hROMBank]
	push af
	ld a, [hBuffer]
	rst Bankswitch

	; get byte from new bank
	ld a, [hl]
	ld [hBuffer], a

	; bankswitch to previous bank
	pop af
	rst Bankswitch

	; return retrieved value in a
	ld a, [hBuffer]
	ret

GetFarHalfword::
; retrieve a halfword from a:hl, and return it in hl.
	; bankswitch to new bank
	ld [hBuffer], a
	ld a, [hROMBank]
	push af
	ld a, [hBuffer]
	rst Bankswitch

	; get halfword from new bank, put it in hl
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; bankswitch to previous bank and return
	pop af
	rst Bankswitch
	ret

FarCopyWRAM::
	ld [hBuffer], a
	ld a, [rSVBK]
	push af
	ld a, [hBuffer]
	ld [rSVBK], a

	call CopyBytes

	pop af
	ld [rSVBK], a
	ret

GetFarWRAMByte::
	ld [hBuffer], a
	ld a, [rSVBK]
	push af
	ld a, [hBuffer]
	ld [rSVBK], a
	ld a, [hl]
	ld [hBuffer], a
	pop af
	ld [rSVBK], a
	ld a, [hBuffer]
	ret
