//
// Created by khhs on 2022-04-13.
//

#ifndef JIMMYS_OS_K_STDIO_H
#define JIMMYS_OS_K_STDIO_H

#include "COMPILE_FLAGS.h"

void print(char* s);
void putc(char c);
void clear();
void setcolor(char bg, char fg);

// Attribute byte for our default colour scheme
#define BLACK_BG 0x00
#define BLUE_BG  0x10
#define GREEN_BG 0x20
#define CYAN_BG  0x30
#define RED_BG   0x40
#define MAGENTA_BG 0x50
#define BROWN_BG 0x60
#define LIGHT_GREY_BG 0x70
#define DARK_GREY_BG 0x80
#define LIGHT_BLUE_BG 0x90
#define LIGHT_GREEN_BG 0xa0
#define LIGHT_CYAN_BG 0xb0
#define LIGHT_RED_BG 0xc0
#define LIGHT_MAGENTA_BG 0xd0
#define LIGHT_BROWN_BG 0xe0
#define WHITE_BG 0xf0


#define BLACK_FG 0x00
#define BLUE_FG  0x01
#define GREEN_FG 0x02
#define CYAN_FG  0x03
#define RED_FG   0x04
#define MAGENTA_FG 0x05
#define BROWN_FG 0x06
#define LIGHT_GREY_FG 0x07
#define DARK_GREY_FG 0x08
#define LIGHT_BLUE_FG 0x09
#define LIGHT_GREEN_FG 0x0a
#define LIGHT_CYAN_FG 0x0b
#define LIGHT_RED_FG 0x0c
#define LIGHT_MAGENTA_FG 0x0d
#define LIGHT_BROWN_FG 0x0e
#define WHITE_FG 0x0f

#endif //JIMMYS_OS_K_STDIO_H
