#include <stdio.h>
double paramA,paramB;

double linear(double x){
  return paramA*x+paramB;
}

int main(void){
  paramA=5.0; paramB=3.2;
  printf("Result is %f.\n",linear(1.2));
  printf("Result is %f.\n",linear(2.0));
  return 0;
}
