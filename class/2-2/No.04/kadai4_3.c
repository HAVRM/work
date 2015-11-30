#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void upper(char *a,char *b);
void lower(char *a,char *b);

int main(void){
  int num;
  char str[125],*ans;
  fgets(str,125,stdin);
  num=(int)strlen(str);
  ans=(char *)malloc(sizeof(char)*num);
  upper(str,ans);
  printf("%s",ans);
  lower(str,ans);
  printf("%s",ans);
  free(ans);
  return 0;
}

void upper(char *a,char *b){
  int i,temp1,temp2;
  for(i=0;a[i]!='\0';i++){
    temp1=a[i]/16;
    temp2=a[i]%16;
    if(temp1==6 && temp2!=0)b[i]=a[i]-2*16;
    else if(temp1==7 && temp2<=10)b[i]=a[i]-2*16;
    else b[i]=a[i];
  }
}

void lower(char *a,char *b){
  int i,temp1,temp2;
  for(i=0;a[i]!='\0';i++){
    temp1=a[i]/16;
    temp2=a[i]%16;
    if(temp1==4 && temp2!=0)b[i]=a[i]+2*16;
    else if(temp1==5 && temp2<=10)b[i]=a[i]+2*16;
    else b[i]=a[i];
  }
}
