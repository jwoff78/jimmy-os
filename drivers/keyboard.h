#include "stdint.h"
#include "COMPILE_FLAGS.h"

void init_keyboard(void (*callback)(unsigned char));
void print_letter(uint8_t scancode);
char* get_letter(uint8_t scancode);