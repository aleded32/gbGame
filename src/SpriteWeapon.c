#include "Banks/SetAutoBank.h"
#include "Keys.h"
#include "SpriteManager.h"
#include "ZGBMain.h"


UINT8 anim_weapon[] = {2, 0,1};





void START() {

	 boneWeapon.timer = 0;
     boneWeapon.maxTime = 50;
     isPressed = 0;
}

void UPDATE() {

    THIS->x = bonePos[0];
    THIS->y = bonePos[1];

    
    if(KEY_PRESSED(J_A) && isPressed == 1)
    {
        SetSpriteAnim(THIS,anim_weapon, 8);
        
    }
    
    if(boneWeapon.timer < boneWeapon.maxTime && boneWeapon.timer >= 30){
        SpriteManagerRemoveSprite(THIS);
    }
        
    
}

void DESTROY() {
   
}