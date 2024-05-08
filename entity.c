
typedef struct entity
{
    uint8_t x;
    uint8_t y;
    uint8_t width;
    uint8_t height;
    uint8_t speed;
   
    
    enum dir {DOWN, UP, LEFT, RIGHT};
    enum dir currentDir;
    

}entity;








