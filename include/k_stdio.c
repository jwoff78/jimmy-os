//
// Created by khhs on 2022-04-13.
//

#include "k_stdio.h"
#include "../drivers/screen.h"

void print(char* message){
    int i = 0;
    while (message[i] != '\0')
    {
        sd_putchar(message[i]);
        i++;
    }
}

void putc(char c){
    sd_putchar(c);
}

void clear(){
    sd_clear_screen();
}

void setcolor(char bg, char fg){
    sd_set_color(bg, fg);
}
