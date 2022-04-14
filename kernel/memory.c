//
// Created by khhs on 2022-04-13.
//

#include "memory.h"

typedef struct{
    char memory[512];
    long padding;
}page;

#define PAGE_SIZE 514

page pages[512];
char freePages[512];

void* allocate(int size){

}

void free(void* p){
    int page = ((int)p - (int)pages) / PAGE_SIZE;
    freePages[page] = 1;
}