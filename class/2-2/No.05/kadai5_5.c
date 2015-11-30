#include <stdio.h>

int str_len(char *str);
void str_cp(char *st1,char *st2);

int main(void){
  char a[]="abcdefgf",*b;
  int num=str_len(a);
  str_cp(b,a);
  printf("%d,%s\n",num,b);
}

int str_len(char *str){
  int i;
  for(i=0;str[i]!='\0';i++);
  return i;
}
void str_cp(char *st1,char *st2){
  int i,j=str_len(st2);
  for(i=0;i<j;i++)st1[i]=st2[i];
  st1[j]='\0';
}
