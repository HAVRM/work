#include <stdio.h>
#include <math.h>

double bisec(double a,double b,double eps);
double f(double x);

int main(void){
  double a,b,x,y,eps;

  eps=pow(2.0,-30.0);
  a=0.0;
  b=1.0;
  printf("answer = %f\n",bisec(a,b,eps));
  return 0;
}

double bisec(double a,double b,double eps){
  double temp=abs(a-b),x1=a,x2=b,tx=0;
  while(temp>eps){
    tx=(x1+x2)/2.0;
    if(f(x1)*f(tx)<0)x2=tx;
    else if(f(x1)*f(tx)>0)x1=tx;
    temp=x1-x2;
    if(temp<0)temp*=-1;
  }
  return (x1+x2)/2.0;
}

double f(double x){
  return (pow(x,3)-(3*x)+1);
}
