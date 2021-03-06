#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct{
  int id;
  char code[31];
  int age;
  int height;
} PEOPLE;

int item_num;

int main(int argc, char *argv[]){
  int i;
  int max_age=0,max_age_id=0;
  int min_height=300,min_height_id=0;
  PEOPLE *data;
  FILE *fp;
  if(argc!=2)exit(1);
  char *name;
  name=argv[1];
  fp=fopen(name,"r");
  if(fp==NULL){
    printf("Cannot open %s\n",argv[1]);
    exit(1);
  }
  fscanf(fp,"%d",&item_num);
  item_num=100;
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
    if(max_age<data[i].age){
      max_age=data[i].age;
      max_age_id=i;
    }
    if(min_height>data[i].height){
      min_height=data[i].height;
      min_height_id=i;
    }
  }
  printf("max age:\nid:%d\ncode:%s\nage:%d\nheigt:%d\n\n",data[max_age_id].id,data[max_age_id].code,data[max_age_id].age,data[max_age_id].height);
printf("min height:\nid:%d\ncode:%s\nage:%d\nheigt:%d\n",data[min_height_id].id,data[min_height_id].code,data[min_height_id].age,data[min_height_id].height);
 
  free(data);
  return 0;
}
