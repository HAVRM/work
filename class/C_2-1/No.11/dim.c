#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void){
  int a;
  srand((unsigned)time(NULL));
  a=(int)(rand()/(RAND_MAX+1.0)*6);
  printf("Result is %d.\n",a+1);
  return 0;
}
