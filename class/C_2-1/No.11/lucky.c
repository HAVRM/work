#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void){
  double a;
  srand((unsigned)time(NULL));
  a=rand()/(RAND_MAX+1.0);
  if(a<0.3)printf("Very lucky");
  else if(a<0.3+0.6)printf("Lucky");
  else printf("Not lucky");
  printf("\n");
  return 0;
}
