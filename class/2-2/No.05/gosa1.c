#include <stdio.h>

int main(void){
  float sum=0.0;
  int i;

  for(i=0;i<100;i++)sum+=0.1;
  printf("sum=%f\n",sum);

  return 0;
}
