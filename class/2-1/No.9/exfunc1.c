#include <stdio.h>

double linear(int x){
  double y;
  y=2.5*x+1.0;
  return y;
}

int main(void){
  double a[3];
  a[0]=linear(0);
  a[1]=linear(1);
  a[2]=linear(2);
  return 0;
}
