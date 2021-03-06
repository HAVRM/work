#include <stdio.h>
#include <math.h>

double factorial(int n);

int main(void){
  int i;
  double eps=pow(2.0,-60.0);
  double e=1.0;
  for(i=1;1/factorial(i)>eps;i++)e+=1/factorial(i);
  printf("%2.15lf\n",e);
  return 0;
}

double factorial(int n){
  double f=1.0;
  int i;
  for(i=n;i>0;i--)f*=(double)i;
  return f;
}
