;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _performantDelay
	.globl _updatePlayer
	.globl _changeDirection
	.globl _setupPlayer
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _player
	.globl _playerUp
	.globl _playerLeft
	.globl _playerDown
	.globl _playerMetasprite
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_playerDown::
	.ds 80
_playerLeft::
	.ds 80
_playerUp::
	.ds 320
_player::
	.ds 7
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;player.c:19: uint8_t setupPlayer()
;	---------------------------------
; Function setupPlayer
; ---------------------------------
_setupPlayer::
;player.c:21: set_sprite_data(0,4,playerDown);
	ld	de, #_playerDown
	push	de
	ld	a, #0x04
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;player.c:22: return move_metasprite(playerMetasprite,0,0,player.x, player.y);
	ld	hl, #(_player + 1)
	ld	b, (hl)
	ld	hl, #_player
	ld	c, (hl)
;d:\gbdk\include\gb\metasprites.h:160: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), #<(_playerMetasprite)
	inc	hl
	ld	(hl), #>(_playerMetasprite)
;d:\gbdk\include\gb\metasprites.h:161: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;d:\gbdk\include\gb\metasprites.h:162: __current_base_prop = 0;
	ld	hl, #___current_base_prop
	ld	(hl), #0x00
;d:\gbdk\include\gb\metasprites.h:163: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, b
	xor	a, a
	ld	b, a
	or	a, c
	ld	e, a
	xor	a, a
;player.c:22: return move_metasprite(playerMetasprite,0,0,player.x, player.y);
;player.c:24: }
	jp	___move_metasprite
_playerMetasprite:
	.db #0xf8	; -8
	.db #0xf8	; -8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	;  8
	.db #0x00	;  0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xf8	; -8
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x08	;  8
	.db #0x00	;  0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
;player.c:26: void changeDirection(uint8_t dir)
;	---------------------------------
; Function changeDirection
; ---------------------------------
_changeDirection::
;player.c:28: switch (dir)
	or	a, a
	jr	Z, 00101$
	cp	a, #0x01
	jr	Z, 00102$
	sub	a, #0x02
	jr	Z, 00103$
	ret
;player.c:30: case 0:
00101$:
;player.c:31: set_sprite_data(0,4,playerDown);
	ld	de, #_playerDown
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;player.c:32: break;
	ret
;player.c:33: case 1:
00102$:
;player.c:34: set_sprite_data(0,4,playerUp);
	ld	de, #_playerUp
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;player.c:35: break;
	ret
;player.c:36: case 2:
00103$:
;player.c:37: set_sprite_data(0,4,playerLeft);
	ld	de, #_playerLeft
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;player.c:39: }
;player.c:40: }
	ret
;player.c:42: uint8_t updatePlayer()
;	---------------------------------
; Function updatePlayer
; ---------------------------------
_updatePlayer::
;player.c:44: if(joypad() & J_LEFT)
	call	_joypad
	bit	1, a
	jr	Z, 00110$
;player.c:46: player.currentDir = 2;
	ld	bc, #_player+0
	ld	hl, #(_player + 6)
	ld	(hl), #0x02
;player.c:47: player.x -= 3;
	ld	a, (bc)
	add	a, #0xfd
	ld	(bc), a
	jr	00111$
00110$:
;player.c:51: else if(joypad() & J_DOWN)
	call	_joypad
	bit	3, a
	jr	Z, 00107$
;player.c:53: player.currentDir = 0;
	ld	hl, #(_player + 6)
	ld	(hl), #0x00
;player.c:55: player.y += 3;
	ld	bc, #_player + 1
	ld	a, (bc)
	add	a, #0x03
	ld	(bc), a
	jr	00111$
00107$:
;player.c:58: else if(joypad() & J_RIGHT)
	call	_joypad
	rrca
	jr	NC, 00104$
;player.c:60: player.currentDir = 3;
	ld	bc, #_player+0
	ld	hl, #(_player + 6)
	ld	(hl), #0x03
;player.c:61: player.x += 3;
	ld	a, (bc)
	add	a, #0x03
	ld	(bc), a
	jr	00111$
00104$:
;player.c:64: else if(joypad() & J_UP)
	call	_joypad
	bit	2, a
	jr	Z, 00111$
;player.c:66: player.currentDir = 1;
	ld	hl, #(_player + 6)
	ld	(hl), #0x01
;player.c:67: player.y -= 3;
	ld	bc, #_player + 1
	ld	a, (bc)
	add	a, #0xfd
	ld	(bc), a
00111$:
;player.c:71: changeDirection(player.currentDir);
	ld	bc, #_player+0
	ld	hl, #(_player + 6)
	ld	l, (hl)
;	spillPairReg hl
	push	bc
	ld	a, l
	call	_changeDirection
	pop	bc
;player.c:74: if(player.currentDir != 3){
	ld	a, (#(_player + 6) + 0)
;player.c:75: return move_metasprite(playerMetasprite,0,0, player.x, player.y);
	ld	e, c
	ld	d, b
	inc	de
;player.c:74: if(player.currentDir != 3){
	sub	a, #0x03
	jr	Z, 00113$
;player.c:75: return move_metasprite(playerMetasprite,0,0, player.x, player.y);
	ld	a, (de)
	ld	e, a
	ld	a, (bc)
	ld	c, a
;d:\gbdk\include\gb\metasprites.h:160: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), #<(_playerMetasprite)
	inc	hl
	ld	(hl), #>(_playerMetasprite)
;d:\gbdk\include\gb\metasprites.h:161: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;d:\gbdk\include\gb\metasprites.h:162: __current_base_prop = 0;
	ld	hl, #___current_base_prop
	ld	(hl), #0x00
;d:\gbdk\include\gb\metasprites.h:163: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, e
	xor	a, a
	ld	b, a
	or	a, c
	ld	e, a
	xor	a, a
;player.c:75: return move_metasprite(playerMetasprite,0,0, player.x, player.y);
	jp	___move_metasprite
00113$:
;player.c:78: set_sprite_data(0,4,playerLeft);
	push	de
	ld	hl, #_playerLeft
	push	hl
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
	pop	de
;player.c:79: return move_metasprite_vflip(playerMetasprite,0,0, player.x, player.y);
	ld	a, (de)
	ld	e, a
	ld	a, (bc)
	ld	c, a
;d:\gbdk\include\gb\metasprites.h:200: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), #<(_playerMetasprite)
	inc	hl
	ld	(hl), #>(_playerMetasprite)
;d:\gbdk\include\gb\metasprites.h:201: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;d:\gbdk\include\gb\metasprites.h:202: __current_base_prop = 0;
	ld	hl, #___current_base_prop
	ld	(hl), #0x00
;d:\gbdk\include\gb\metasprites.h:203: return __move_metasprite_vflip(base_sprite, (y << 8) | (uint8_t)(x - 8u));
	ld	d, e
	ld	e, #0x00
	ld	a, c
	add	a, #0xf8
	ld	c, #0x00
	or	a, e
	ld	e, a
	xor	a, a
;player.c:79: return move_metasprite_vflip(playerMetasprite,0,0, player.x, player.y);
;player.c:82: }
	jp	___move_metasprite_vflip
;main.c:8: void performantDelay(UINT8 nLoops)
;	---------------------------------
; Function performantDelay
; ---------------------------------
_performantDelay::
	ld	c, a
;main.c:10: for(UINT8 i = 0; i < nLoops; i++)
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, c
	ret	NC
;main.c:12: wait_vbl_done();
	call	_wait_vbl_done
;main.c:10: for(UINT8 i = 0; i < nLoops; i++)
	inc	b
;main.c:14: }
	jr	00103$
;main.c:16: void main(int argc, char *argv[])
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:19: lastSprite += setupPlayer();
	call	_setupPlayer
;main.c:23: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:24: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:26: while(1)
00102$:
;main.c:29: lastSprite += updatePlayer();
	call	_updatePlayer
;main.c:33: performantDelay(2);
	ld	a, #0x02
	call	_performantDelay
;main.c:37: }
	jr	00102$
	.area _CODE
	.area _INITIALIZER
__xinit__playerDown:
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0c	; 12
	.db #0x16	; 22
	.db #0x18	; 24
	.db #0x2e	; 46
	.db #0x34	; 52	'4'
	.db #0x2e	; 46
	.db #0x3e	; 62
	.db #0x2c	; 44
	.db #0x34	; 52	'4'
	.db #0x1d	; 29
	.db #0x11	; 17
	.db #0x16	; 22
	.db #0x18	; 24
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x19	; 25
	.db #0x1d	; 29
	.db #0x2e	; 46
	.db #0x3c	; 60
	.db #0x2b	; 43
	.db #0x3d	; 61
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x2c	; 44
	.db #0x74	; 116	't'
	.db #0x7c	; 124
	.db #0x34	; 52	'4'
	.db #0x2c	; 44
	.db #0x98	; 152
	.db #0x88	; 136
	.db #0x28	; 40
	.db #0x18	; 24
	.db #0x72	; 114	'r'
	.db #0x52	; 82	'R'
	.db #0xe7	; 231
	.db #0xe5	; 229
	.db #0x9a	; 154
	.db #0xba	; 186
	.db #0x36	; 54	'6'
	.db #0x3e	; 62
	.db #0xb6	; 182
	.db #0x9e	; 158
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__playerLeft:
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0c	; 12
	.db #0x16	; 22
	.db #0x18	; 24
	.db #0x2c	; 44
	.db #0x34	; 52	'4'
	.db #0x2e	; 46
	.db #0x3e	; 62
	.db #0x2c	; 44
	.db #0x34	; 52	'4'
	.db #0x14	; 20
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x09	; 9
	.db #0x0e	; 14
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0b	; 11
	.db #0x0f	; 15
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x2f	; 47
	.db #0x2d	; 45
	.db #0x5d	; 93
	.db #0x7f	; 127
	.db #0x2f	; 47
	.db #0x2f	; 47
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x0c	; 12
	.db #0x34	; 52	'4'
	.db #0x0c	; 12
	.db #0x14	; 20
	.db #0x0c	; 12
	.db #0x28	; 40
	.db #0x18	; 24
	.db #0x28	; 40
	.db #0x18	; 24
	.db #0x50	; 80	'P'
	.db #0x30	; 48	'0'
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xd0	; 208
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0x50	; 80	'P'
	.db #0x30	; 48	'0'
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__playerUp:
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0c	; 12
	.db #0x16	; 22
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x38	; 56	'8'
	.db #0x24	; 36
	.db #0x38	; 56	'8'
	.db #0x24	; 36
	.db #0x38	; 56	'8'
	.db #0x12	; 18
	.db #0x1c	; 28
	.db #0x10	; 16
	.db #0x1e	; 30
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0xe7	; 231
	.db #0xa7	; 167
	.db #0x59	; 89	'Y'
	.db #0x5d	; 93
	.db #0x6e	; 110	'n'
	.db #0x7c	; 124
	.db #0x6b	; 107	'k'
	.db #0x7d	; 125
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x14	; 20
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x28	; 40
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x98	; 152
	.db #0xb8	; 184
	.db #0x34	; 52	'4'
	.db #0x3c	; 60
	.db #0xb4	; 180
	.db #0x9c	; 156
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__player:
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _CABS (ABS)
