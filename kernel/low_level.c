#include "low_level.h"

unsigned char port_byte_in(unsigned short port){
    // A handy C wrapper func that reads a byte from the specified port
    // "=a" (result) means: put AL register in variable RESULT whehn finished
    // "d" (port) means: load EDX with port
    unsigned char result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void port_byte_out(unsigned short port, unsigned char data){
    // "a" (data) means: load EAX with data
    // "d" (port) means: load EDX with port
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

unsigned short port_word_in(unsigned short port){
    unsigned char result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void port_word_out(unsigned short port, unsigned short data){
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}
