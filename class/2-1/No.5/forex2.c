#include <stdio.h>
int main(void){
  int sum=0,i;
  for(i=100;i>=1;i=i-1){
    sum=sum+i;
  }
  printf("Answer is %d.\n",sum);
  return 0;
}
