#include <stdio.h>

int main(void){
  int a,b,c,max,t_ave;
  double ave;
  printf("Input three integers:\na: ");
  scanf("%d",&a);
  printf("b: ");
  scanf("%d",&b);
  printf("c: ");
  scanf("%d",&c);
  if(a>=b){
    if(a>=c)max=a;
    else max=c;
  }else if(b>=c)max=b;
  else max=c;
  ave=(a+b+c)/3.00;
  t_ave=ave*100;
  ave=t_ave/100.0;
  printf("Average is %4.2f.\nMaximum is %d.\n",ave,max);
  return 0;
}

