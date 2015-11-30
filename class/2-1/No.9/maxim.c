#include <stdio.h>

double maxim(double a,double b){
  if(a<b)return b;
  else return a;
}

double absol(double a){
  if(a<0)a*=-1.0;
  return a;
}

int main(void){
  double x,x_m,x_t,x_a,max;
  printf("Input X:");
  scanf("%lf",&x);
  x_m=-1.0*x;
  x_t=x*x*x;
  x_a=absol(x);
  max=maxim(x,x_m);
  max=maxim(max,x_t);
  max=maxim(max,x_a);
  printf("Maximum value is %.2f.\n",max);
  return 0;
}
