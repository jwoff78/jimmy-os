#include "COMPILE_FLAGS.h"

#define VIDEO_ADRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

// Screen device I/O ports
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

void sd_putchar_pos(char c, int row, int col);
void sd_putchar(char c);
void sd_clear_screen();
void sd_screen_init();
void sd_set_color(char bg, char fg);