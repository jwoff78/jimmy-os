void some_function(){

}

void main(){
    // Create a pointer to char, and point it to the first text cell
    // of video memory
    char* video_memory = (char*)0xb8000;
    // Store the char X at the pos
    *video_memory = 'X';

    some_function();
}