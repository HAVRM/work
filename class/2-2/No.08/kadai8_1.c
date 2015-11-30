#include <stdio.h>

int fib(int i);

int main(void){
  int i,j;
 startpoint:
  printf("prease put the number from -40 to 40:");
  scanf("%d",&i);
  if(abs(i)>40){
    printf("prease put the number -40 to 40\n");
    goto startpoint;
  }
  j=fib(i);
  printf("No.%d's Fibonacci number is %d\n",i,j);
  return 0;
}

int fib(int i){
  int j,k;
  if(i!=0)j=i/abs(i);
  else j=0;
  int f[41];
  i=abs(i);
  f[0]=0;
  f[1]=1;
  if(i>=2)for(k=2;k<=i;k++)f[k]=f[k-1]+f[k-2];
  if(j<0 & i%2==0)f[i]*=-1;
  return f[i];
}
