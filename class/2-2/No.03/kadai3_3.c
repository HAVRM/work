#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 100

int main(void){
  int i,num,data[6];
  for(i=0;i<6;i++)data[i]=0;
  FILE *fp;
  fp=fopen("data.txt","r");
  if(fp==NULL){
    printf("error\n");
    exit(1);
  }
  while(fscanf(fp,"%d",&num)!=EOF)data[num-1]++;
  for(i=0;i<6;i++)printf("%3d ",data[i]);
  printf("\n");
  fclose(fp);
}
