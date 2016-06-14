#include <stdio.h>
#include <stdlib.h>
#include "newsort.h"

int main(void){
  PEOPLE *data;
  int i,item_num;
  FILE *fp;
  fp=fopen("data.txt","r");
  if(fp==NULL){
    printf("Cannot open data.txt\n");
    exit(1);
  }
  fscanf(fp,"%d",&item_num);
  data=(PEOPLE *)malloc(sizeof(PEOPLE)*item_num);
  if(data==NULL){
    printf("Cannot create memory size.");
    exit(1);
  }
  for(i=0;i<item_num;i++){
    fscanf(fp,"%d\n",&data[i].id);
    fgets(data[i].code,31,fp);
    fscanf(fp,"%d\n",&data[i].age);
    fscanf(fp,"%d\n",&data[i].height);
  }
  fclose(fp);
  selectsort(data,item_num);
  for(i=0;i<item_num;i++)printf("id=%d,height=%d\n",data[i].id,data[i].height);
  printf("\n");
  quick_sort(data,0,item_num-1);
  for(i=0;i<item_num;i++)printf("id=%d,code=%s\n",data[i].id,data[i].code);
  return 0;
}
