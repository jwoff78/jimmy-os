//
// Created by khhs on 2022-04-14.
//

#include "panic.h"

void kpanic(char* err){
    clear();
    print("KERNEL PANIC\n");
    print("THE KERNEL THREW A CRITICAL ERROR: \"");
    print(err);
    print("\"\nTHE CPU WILL NOW HANG, INSTEAD OF SHUTTING DOWN\nHERE IS SOME USELESS MAKESHIFT ERROR INFO TO KEEP YOU BUSY:\n\n");
    setcolor(BLACK_BG, GREEN_FG);
    print("struct group_info init_groups = { .usage = ATOMIC_INIT(2) };\n"
          "\n"
          "struct group_info *groups_alloc(int gidsetsize){\n"
          "\n"
          "\tstruct group_info *group_info;\n"
          "\n"
          "\tint nblocks;\n"
          "\n"
          "\tint i;\n"
          "\n"
          "\n"
          "\n"
          "\tnblocks = (gidsetsize + NGROUPS_PER_BLOCK - 1) / NGROUPS_PER_BLOCK;\n"
          "\n"
          "\t/* Make sure we always allocate at least one indirect block pointer */\n"
          "\n"
          "\tnblocks = nblocks ? : 1;\n"
          "\n"
          "\tgroup_info = kmalloc(sizeof(*group_info) + nblocks*sizeof(gid_t *), GFP_USER);\n"
          "");
    int i = 0;
    while(i > -1){
        i++;
        continue;
    }
}

