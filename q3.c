#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    printf("Enter the number of lines");
    scanf("%d", &n);

if (n<=0) {
        printf("Invalid value of n\n");
        return 1;
    }
 char** lines = (char**)malloc(n*sizeof(char*));


       for(int i =0;i<n;i++) {
        lines[i]=(char*)malloc(256*sizeof(char));
        lines[i][0] = '\0';
    }

    int num = 0;

    
    char line[256];
    while(fgets(line, sizeof(line), stdin)) {
        snprintf(lines[num%n], sizeof(line), "%s", line);
        num++;
    }

    
      int start =(num>n)?(num%n):0;
    for(int i = 0;i<n;i++) {
        printf("%s", lines[(start+i)%n]);
    }
   
   
      for (int i = 0;i<n; i++) {
        free(lines[i]);
    }
    free(lines);

    return 0;
}
