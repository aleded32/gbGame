#include <./gb/gb.h>
#include <stdio.h>
#include "player.c"




void performantDelay(UINT8 nLoops)
{
    for(UINT8 i = 0; i < nLoops; i++)
    {
        wait_vbl_done();
    }
}

void main(int argc, char *argv[])
{
    uint8_t lastSprite = 0;
    lastSprite += setupPlayer();
    


    SHOW_SPRITES;
    DISPLAY_ON;

    while(1)
    {
        
        lastSprite += updatePlayer();

        //hide_sprites_range(lastSprite, MAX_HARDWARE_SPRITES);
        
        performantDelay(2);
    }

   
}
