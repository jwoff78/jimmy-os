#include "screen.h"
#include "../kernel/low_level.h"
#include "../kernel/util.h"

int cursor_x = 0;
int cursor_y = 0;
char colorInfo = 0x0F;

int sd_get_buffer_offset(int row, int col){
    return (row * MAX_COLS + col) * 2;
}

void sd_set_color(char bg, char fg){
    colorInfo = bg | fg;
}

void sd_putchar_offset(char r){
    if(r == '\n'){
        cursor_x = 0;
        cursor_y++;
        return;
    }
    if(r == '\t'){
        cursor_x += 4;
        return;
    }

#ifdef SD_SCREEN_SWAP
    if(cursor_y >= MAX_ROWS){
        sd_clear_screen();
    }
#endif

    if(r == '\b'){
        cursor_x--;
        sd_putchar_offset('\0');
        cursor_x--;
        return;
    }

    unsigned char* VIDEO_BUFFER = (unsigned char *)VIDEO_ADRESS;
    int video_buffer_offset = sd_get_buffer_offset(cursor_y, cursor_x);
    VIDEO_BUFFER[video_buffer_offset] = r;
    VIDEO_BUFFER[video_buffer_offset + 1] = colorInfo;
    cursor_x++;
}

void sd_putchar_pos(char r, int row, int col){
    cursor_x = row;
    cursor_y = col;
    sd_putchar_offset(r);
}

void sd_putchar(char r){
    sd_putchar_pos(r, cursor_x, cursor_y);
}

void sd_set_cursor(int r, int c){
    cursor_y = r;
    cursor_x = c;
}

void sd_screen_init(){
    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, 0);
    port_byte_out(REG_SCREEN_CTRL, 15);
}

void sd_clear_screen(){
    for (int y = 0; y < MAX_ROWS; y++)
    {
        for (int i = 0; i < MAX_COLS; i++)
        {
            sd_set_cursor(y, i);
            sd_putchar(0);
        }
        
    }

    sd_set_cursor(0, 0);
}