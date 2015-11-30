#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void){
  int a=0,i,j,r[2];
  printf("dice1 dice2\n\r");
  srand((unsigned) time(NULL));
  for(i=0;i<1000;i++){
    for(j=0;j<2;j++)r[j]=(int)(rand()/(RAND_MAX+1.0)*6)+1;
    printf("%5d %5d",r[0],r[1]);
    if(r[0]==r[1]){
      printf("  same value");
      a++;
    }
    printf("\n\r");
  }
  printf("Percentage of same value = %.2f\n\r",a/10.0);
  return 0;
}
