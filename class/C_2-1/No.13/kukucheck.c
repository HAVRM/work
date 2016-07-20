#include <stdio.h>
#include <stdlib.h>

int main(void){
  FILE *file=fopen("kuku","r");
  if(file==NULL){
    fprintf(stderr,"cannot open file 'kuku'\n\r");
    exit(1);
  }
  int i,j,n,e;
  for(i=1;i<=9;i++){
    for(j=1;j<=9;j++){
      e=fscanf(file,"%d",&n);
      if(e!=1){
	fprintf(stderr,"cannot read file %d %d\n\r",i,j);
	fclose(file);
	exit(1);
      }
      printf("%2d",n);
      if(n==i*j)printf("- ");
      else printf("X ");
    }
    printf("\n\r");
  }
  fclose(file);
  return 0;
}
