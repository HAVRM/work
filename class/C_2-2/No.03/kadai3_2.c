#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 100

int main(void){
  int i,num[N];
  srand((unsigned) time(NULL));
  for(i=0;i<N;i++)num[i]=(int) (rand()/(RAND_MAX+1.0)*6)+1;
  FILE *fp;
  fp=fopen("data.txt","w");
  if(fp==NULL){
    printf("error\n");
    exit(1);
  }
  for(i=0;i<N;i++)fprintf(fp,"%3d",num[i]);
  fclose(fp);
}
