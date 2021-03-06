#include <stdio.h>
#include <math.h>

#define MAX 10

void newton(double x,double eps);
double f(double x);
double df(double x);

int main(void){
  double x;
  double eps=pow(2.0,-30.0);
  printf("Please input x0:");
  scanf("%lf",&x);
  newton(x,eps);
  return 0;
}

void newton(double x,double eps){
  int num=0,i;
  double ax[MAX+1],dx;
  ax[0]=x;
  for(i=0;i<MAX;i++){
    dx=-1*f(ax[i])/df(ax[i]);
    ax[i+1]=ax[i]+dx;
    if(fabs(dx)<eps){
      num=i+1;
      break;
    }
  }
  if(num==0)printf("Over the limit of times\n");
  else printf("answer is:%lf at %d times\n",ax[num],num);
}

double f(double x){
  return (pow(x,3.0)-2*x-5);
}

double df(double x){
  return (3.0*pow(x,2.0)-2);
}
