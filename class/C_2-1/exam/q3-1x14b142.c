#include <stdio.h>

int main(void){
  int i,sum1=0,sum2=0;
  for(i=1;i<=100;i++){
    if(i==10)break;
    if((i+1)%2==0)sum1+=i;
  }
  printf("i=%d,sum1=%d\n",i,sum1);
  for(i=1;i<=100;i++){
    if(i>5)continue;
    sum2+=i;
  }
  printf("i=%d,sum2=%d\n",i,sum2);
  return 0;
}
