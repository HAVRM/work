#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int linear(char str[],char src[]){
  int str_num,src_num,i,j;
  str_num=strlen(str);
  src_num=strlen(src);
  for(i=0;i<str_num;i++){
    for(j=0;j<src_num;j++){
      if(str[i+j]!=src[j])goto res;
    }return i;
  res:;
  }
  return -1;
}

typedef struct{
  int id;
  char code[31];
  int age;
  int height;
} PEOPLE;

int main(int argc, char *argv[]){
  int i;
  int num;
  int item_num;
  PEOPLE *data;
  FILE *fp;
  if(argc!=3)exit(1);
  char *name;
  name=argv[1];
  fp=fopen(name,"r");
  if(fp==NULL){
    printf("Cannot open %s\n",argv[1]);
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
  for(i=0;i<item_num;i++){
    num=linear(data[i].code,argv[2]);
    if(num!=-1){
      printf("id:%d\ncode:%s\n",data[i].id,data[i].code);
      printf("\"%s\"'s position=%d\n\n",argv[2],num);
     }
   }
  free(data);
  return 0;
}
