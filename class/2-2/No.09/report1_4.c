#include <stdio.h>
#include <math.h>

int prime(signed int num);

int main(){
  signed int num;
  printf("Put the number:");
  scanf("%d",&num);
  if(prime(num))printf("%d is prime number\n",num);
  else printf("%d is not prime number\n",num);
  return 0;
}

int prime(signed int num){
  int thres,i;
  thres=(int)sqrt(num);
  if(num<=1)return 0;
  for(i=2;i<=thres;i++)if(num%i==0)return 0;
  return 1;
}
