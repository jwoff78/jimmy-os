#include "../drivers/screen.h"

void main(){
    screen_init();
    clear_screen();
    print_hex(0xface);
}