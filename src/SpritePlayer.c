#include "Banks/SetAutoBank.h"
#include "Keys.h"
#include "SpriteManager.h"
#include "ZGBMain.h"
#include "Scroll.h"

//extern variables due to shared use with spriteWeapon
UINT8 boneCount;
UINT8 bonePos[2];
UINT8 dirChange[2];
uint8_t currentDir;

uint8_t isPressed;
uint8_t isShooting;

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

void moveSprite(Sprite* spr,uint8_t keypress)
{
	if(isPressed == FALSE){
		TranslateSprite(spr, data->vx << delta_time, data->vy << delta_time);
	}
	currentDir = keypress;
}

void meleeTimer(){

     if(boneWeapon.timer < boneWeapon.maxTime)
    {
        boneWeapon.timer++;
    }
    else if(boneWeapon.timer >= boneWeapon.maxTime){
       
        boneCount=0;
        boneWeapon.timer = 0;
        isPressed = FALSE;
        
    }
}

void PlayerAttack()
{
	if(KEY_PRESSED(J_A) && isShooting == FALSE){
		if(boneCount < 1 && isPressed == FALSE){
			SpriteManagerAdd(SpriteWeapon, bonePos[0], bonePos[1]);
			boneCount++;
			isPressed = TRUE;
		}
	}
	if(KEY_PRESSED(J_B) && isPressed == FALSE){
		isShooting = TRUE;
	}

	if(isShooting == FALSE)
	{
		meleeTimer();
		bonePos[0] = THIS->x + dirChange[0];
		bonePos[1] = THIS->y + dirChange[1];
	}
	else{
		if(boneCount < 1){
			SpriteManagerAdd(SpriteWeapon, bonePos[0], bonePos[1]);
			boneCount++;
		}
		
	}
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
		SetFrame(THIS, 1);
		moveSprite(THIS,J_UP);
		THIS->mirror = NO_MIRROR;
	} 
	else if(KEY_PRESSED(J_DOWN)) {
		SetFrame(THIS, 0);
		moveSprite(THIS,J_DOWN);
		THIS->mirror = NO_MIRROR;
	}
	else if(KEY_PRESSED(J_LEFT)) {
		SetFrame(THIS, 2);
		THIS->mirror = V_MIRROR;
		moveSprite(THIS,J_LEFT);
	}
	else if(KEY_PRESSED(J_RIGHT)) {
		SetFrame(THIS, 2);
		THIS->mirror = NO_MIRROR;
		moveSprite(THIS,J_RIGHT);
	}
	

	changeDir(currentDir, data);

	
	PlayerAttack();
    
   
	
	
	
	
}

void DESTROY() {
}

