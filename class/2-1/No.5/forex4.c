#include <stdio.h>
int main(void){
  int sum=0,i;
  for(i=1;i<=100;i++){
    if(i==2)continue;
    if(i==5)break;
    printf("%d,",i);
  }
  printf("\n");
  return 0;
}
