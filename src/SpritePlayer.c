#include "Banks/SetAutoBank.h"
#include "Keys.h"
#include "SpriteManager.h"
#include "ZGBMain.h"
#include "Scroll.h"


UINT8 boneCount;
UINT8 bonePos[2];
UINT8 dirChange[2];
UINT8 currentDir;
uint8_t isPressed;

struct weapon boneWeapon;

UINT8 anim_idle[] = {1, 0};



typedef struct playerInfo{
	int vx;
	int  vy;
} playerInfo;

playerInfo* data;


void changeDir(UINT8 key, playerInfo* data){

	switch(key){
		case J_UP:
			dirChange[0] = 2;
			dirChange[1] = -15;
			data->vx = 0; data->vy = -1;
			break;
		case J_DOWN:
			dirChange[0] = 2;
			dirChange[1] = 6;
			data->vx = 0; data->vy = 1;
			break;
		case J_LEFT:
			dirChange[0] = -6;
			dirChange[1] = 0;
			data->vx = -1; data->vy = 0;
			break;
		case J_RIGHT:
			dirChange[0] = 12;
			dirChange[1] = 0;
			data->vx = 1; data->vy = 0;
			break;	
	};
}

void movePlayer(uint8_t keypress)
{
	if(isPressed == 0){
		TranslateSprite(THIS, data->vx, data->vy);
	}
	currentDir = keypress;
}

void START() {

	THIS->coll_h = 8;
	THIS->coll_w = 15;
	boneCount = 0;
	dirChange[0] = 0;
	dirChange[1] = 0;

	data = (playerInfo*)THIS->custom_data;
	data->vx =0;
	data->vy =0;
	 
}



void UPDATE() {

    if(KEY_PRESSED(J_UP)) {
		anim_idle[1] = 1;
		movePlayer(J_UP);
	} 
	else if(KEY_PRESSED(J_DOWN)) {
		anim_idle[1] = 0;
		movePlayer(J_DOWN);
	}
	else if(KEY_PRESSED(J_LEFT)) {
		anim_idle[1] = 3;
		movePlayer(J_LEFT);
	}
	else if(KEY_PRESSED(J_RIGHT)) {
		anim_idle[1] = 2;
		movePlayer(J_RIGHT);
	}
	SetSpriteAnim(THIS,anim_idle, 15);

	changeDir(currentDir, data);

	if(KEY_PRESSED(J_A)){
		if(boneCount < 1 && isPressed == 0){
			SpriteManagerAdd(SpriteWeapon, bonePos[0], bonePos[1]);
			boneCount++;
			isPressed = 1;
		}
	}

	

    
    if(boneWeapon.timer < boneWeapon.maxTime)
    {
        boneWeapon.timer++;
    }
    else if(boneWeapon.timer >= boneWeapon.maxTime){
       
        boneCount=0;
        boneWeapon.timer = 0;
        isPressed = 0;
        
    }
	
	bonePos[0] = THIS->x + dirChange[0];
	bonePos[1] = THIS->y + dirChange[1];
	
	
}

void DESTROY() {
}

