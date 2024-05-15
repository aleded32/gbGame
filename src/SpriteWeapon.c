#include "Banks/SetAutoBank.h"
#include "Keys.h"
#include "SpriteManager.h"
#include "ZGBMain.h"


UINT8 anim_weapon[] = {2, 0,1};
uint8_t setDir = FALSE;

uint8_t weaponCurrentDir;


void weaponDir(uint8_t key)
{
    switch(key){
		case J_UP:
			bonePos[1]-=2;
			break;
		case J_DOWN:
			bonePos[1]+=2;
			break;
		case J_LEFT:
			bonePos[0]-=2;
			break;
		case J_RIGHT:
			bonePos[0]+=2;
			break;	
	};
}


void START() {

	 boneWeapon.timer = 0;
     boneWeapon.maxTime = 50;
     isPressed = 0;
     isShooting = 0;

     
}

void UPDATE() {

    THIS->x = bonePos[0];
    THIS->y = bonePos[1];

        
    if(KEY_PRESSED(J_A) && isPressed == TRUE)
    {
        SetSpriteAnim(THIS,anim_weapon, 12);
    }
    
    if(boneWeapon.timer < boneWeapon.maxTime && boneWeapon.timer >= 30){
        SpriteManagerRemoveSprite(THIS);
    }
    
    if(isShooting == TRUE){
        SetSpriteAnim(THIS,anim_weapon, 12);
        
        if(setDir == FALSE){ weaponCurrentDir = currentDir;  setDir = TRUE;} 
        weaponDir(weaponCurrentDir);
        isPressed = FALSE;
    }
    
    
}

void DESTROY() {
   boneCount = 0;
   isShooting = FALSE;
   setDir = FALSE;
}