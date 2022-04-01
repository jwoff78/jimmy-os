#include "screen.h"
#include "../kernel/low_level.h"
#include "../kernel/util.h"

int cursor_x = 0;
int cursor_y = 0;

void putchar_offset(char r){
    if(r == '\n'){
        cursor_x = 0;
        cursor_y++;
        return;
    }
    unsigned char* VIDEO_BUFFER = (unsigned char *)VIDEO_ADRESS;
    int video_buffer_offset = get_buffer_offset(cursor_y, cursor_x);
    VIDEO_BUFFER[video_buffer_offset] = r;
    VIDEO_BUFFER[video_buffer_offset + 1] = WHITE_ON_BLACK;
    cursor_x++;
}

void purchar_pos(char r, int row, int col){
    cursor_x = row;
    cursor_y = col;
    putchar_offset(r);
}

void putchar(char r){
    purchar_pos(r, cursor_x, cursor_y);
}

void putc(char r){
    putchar_pos(r, cursor_x, cursor_y);
}

int get_buffer_offset(int row, int col){
    return (row * MAX_COLS + col) * 2;
}

void print(char* message){
    int i = 0;
    while (message[i] != 0)
    {
        putchar(message[i++]);
    }
    
}

void set_cursor(int r, int c){
    cursor_y = r;
    cursor_x = c;
}

void screen_init(){
    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, 0);
    port_byte_out(REG_SCREEN_CTRL, 15);
}

void clear_screen(){
    for (int y = 0; y < MAX_ROWS; y++)
    {
        for (int i = 0; i < MAX_COLS; i++)
        {
            set_cursor(y, i);
            putchar(0);
        }
        
    }

    set_cursor(0, 0);
    
}