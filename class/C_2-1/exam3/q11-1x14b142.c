#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void){
  int i,r;
  int num[6]={0,0,0,0,0,0};
  printf("Dice simulation * 1000,\n\r");
  srand((unsigned)time(NULL));
  for(i=0;i<1000;i++){
    r=rand()/(RAND_MAX+1.0)*6;
    num[r]++;
  }
  for(i=0;i<6;i++)printf("%d is %d times. Probability is% .1f[%%].\n\r",i+1,num[i],num[i]/10.0);
  return 0;
}
