#include <stdio.h>
#include <string.h>

int main(){
  char str[125],temp[125];
  int num,i;
  printf("Input?: ");
  fgets(str,125,stdin);
  num=(int)strlen(str)-1;
  for(i=0;i<num;i++)temp[i]=str[i];
  for(i=0;i<num;i++)str[i]=temp[num-i-1];
  str[num]='\0';
  FILE *fp;
  fp=fopen("data.txt", "w");
  if(fp==NULL){
    printf("fopen error\n");
    return 0;
  }
  printf("d");
  printf("%s",str);
  fprintf(fp,"%s",str);
  fclose(fp);
  return 0;
}
