#include <stdio.h>
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

int main(void){
  char str[27]="abcdefghijklmnopqrstuvwxyz";
  char src[4]="pqr";
  int num;
  num=linear(str,src);
  if(num==-1)printf("\"%s\" is not in the statement",src);
  else printf("\"%s\"'s position is %d from 1st\n",src,num);
  return 0;
}
