#include <stdio.h>
#include <stdlib.h>

int main(void){
  FILE *file=fopen("kuku","w");
  int i,j;
  for(i=1;i<=9;i++){
    for(j=1;j<=9;j++){
      fprintf(file,"%2d\t",i*j);
    }
    fprintf(file,"\n");
  }
  fclose(file);
  printf("finish.\n\r");
  return 0;
}
