#include <stdio.h>
int main(void){
  int a,b,c,sum;
  double ave;
  printf("Input three integers:\na:");
  scanf("%d",&a);
  printf("b:");
  scanf("%d",&b);
  printf("c:");
  scanf("%d",&c);
  sum=a+b+c;
  ave=sum/3.0;
  printf("Sum is %d,Average is %.1f.\n",sum,ave);
  return 0;
}
