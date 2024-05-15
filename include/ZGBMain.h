#ifndef ZGBMAIN_H
#define ZGBMAIN_H

#define STATES \
_STATE(StateGame)\
STATE_DEF_END

#define SPRITES \
_SPRITE_DMG(SpritePlayer, playerDown)\
_SPRITE_DMG(SpriteWeapon, bone)\
SPRITE_DEF_END

#define TRUE 1
#define FALSE 0

#include "ZGBMain_Init.h"

extern UINT8 boneCount;
extern UINT8 bonePos[2];
extern struct weapon{
    uint8_t timer;
    uint8_t maxTime;
};


extern struct weapon boneWeapon;
extern uint8_t isPressed;
extern uint8_t isShooting;
extern uint8_t currentDir;

#endif