#include <stdio.h>

int main(void){
  float num1,num2,num3,num4;
  float sum=0.0;
  num1=100002.0;
  num2=1.234567;
  num3=6.654321;
  num4=-100001.0;

  sum+=num2;
  sum+=num3;
  sum+=num1+num4;
  printf("%f\n",sum);
  return 0;
}
