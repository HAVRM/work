#include <stdio.h>

double a=2.0,b=2.0;

double linear(double x){
  return a*x;
}

double quadric(double x){
  return b*x*x*x;
}

int main(void){
  double x;
  int i;
  for(i=-100;i<101;i++){
    x=i*0.1;
    if(linear(x)==quadric(x))printf("x=%f\n",x);
  }
}
