#include "COMPILE_FLAGS.h"
#include "isr.h"
#include "util.h"
#include "../drivers/keyboard.h"
#include "../drivers/keys.h"
#include "panic.h"

#include "k_stdio.h"

unsigned int c_tick = 0;

void timer_callback(uint32_t new_tick){
    c_tick = new_tick;
}

void keyboard_callback(unsigned char scancode){
    /*if(scancode == KEY_ENTER){
        print("ENTER!\n");
    }
    if(KEY_UP(scancode)){
        print("Key up: ");
        print_letter(GET_SCANCODE_UP(scancode));
        putc('\n');
    }*/
    if(!KEY_UP(scancode)) {
        putc(keyboard_char_map[scancode]);
    }
}


void main(){
    clear();
    print("BOOTING JIMMOS\n");

    isr_install();
    asm volatile("sti");

    init_keyboard(keyboard_callback);
}