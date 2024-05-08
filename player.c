#include <./gb/gb.h>
#include <./gb/metasprites.h>
#include "./sprites/playerDown.c"
#include "./sprites/playerLeft.c"
#include "./sprites/playerUp.c"
#include "entity.c"

entity player = {.x = 80, .y = 80, .speed = 0, .currentDir = 0};

const metasprite_t playerMetasprite[] =  {
        {.dy = -8, .dx = -8, .dtile = 0, .props = 0},
        {.dy = 8, .dx = 0, .dtile = 1, .props = 0},
        {.dy = -8, .dx = 8, .dtile = 2, .props = 0},
        {.dy = 8, .dx = 0, .dtile = 3, .props = 0},
   
        METASPR_TERM
    };

uint8_t setupPlayer()
{
   set_sprite_data(0,4,playerDown);
   return move_metasprite(playerMetasprite,0,0,player.x, player.y);

}

void changeDirection(uint8_t dir)
{
    switch (dir)
    {
    case 0:
        set_sprite_data(0,4,playerDown);
        break;
    case 1:
        set_sprite_data(0,4,playerUp);
        break;
    case 2:
        set_sprite_data(0,4,playerLeft);
        break;
    }
}

uint8_t updatePlayer()
{
    if(joypad() & J_LEFT)
    {
        player.currentDir = 2;
        player.x -= 3;
        
        
    }
    else if(joypad() & J_DOWN)
    {
        player.currentDir = 0;
        
        player.y += 3;
       
    }
    else if(joypad() & J_RIGHT)
    {
        player.currentDir = 3;
        player.x += 3;
       
    }
    else if(joypad() & J_UP)
    {
        player.currentDir = 1;
        player.y -= 3;
       
    }

    changeDirection(player.currentDir);

    //moveEntity(e);
    if(player.currentDir != 3){
        return move_metasprite(playerMetasprite,0,0, player.x, player.y);
    }
    else{
        set_sprite_data(0,4,playerLeft);
        return move_metasprite_vflip(playerMetasprite,0,0, player.x, player.y);
    }

}

