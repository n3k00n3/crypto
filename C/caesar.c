#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void usage(){
  puts("Usage: ./caesar <msg> <key>");
}

void caesar(ushort key, char* plaintext){
    for(int i = 0; i < strlen(plaintext); i++ ){
        plaintext[i] += key;
    }
    printf("%s\n", plaintext);
}

int main(int argc, char *argv[]){
    ushort key = atoi(argv[2]);
    char plaintext[100];

    if(argc > 3 || argc < 3)
        usage();
    if(key < 0)
        puts("You need to use a postive number!");
    
    sprintf(plaintext, argv[1]);
    caesar(key, plaintext); 
    return 0;
}
