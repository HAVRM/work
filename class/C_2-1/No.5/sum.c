#include <stdio.h>
int main(void){
  int i,N,sum=0;
  printf("Input number N=: ");
  scanf("%d",&N);
  for(i=1;i<=N;i++)sum+=2*i-1;
  printf("Answer is %d.\n",sum);
  return 0;
}
