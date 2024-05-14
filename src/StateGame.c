#include "Banks/SetAutoBank.h"

#include "ZGBMain.h"
#include "Scroll.h"
#include "SpriteManager.h"

UINT8 collision_tiles[] = {3,4,5,6,7};

IMPORT_MAP(map);

void START() {
	scroll_target = SpriteManagerAdd(SpritePlayer, 50, 50);

	//scroll_target = SpriteManagerAdd(SpriteWeapon, 67,50);
	
	InitScroll(BANK(map), &map, collision_tiles, 0);
}

void UPDATE() {
}
