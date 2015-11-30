#include <stdio.h>
#include <time.h>

void wait_h(int timer){
  int n_t,t;
  n_t=(int)((unsigned)time(NULL))+timer;
  t=(int)((unsigned)time(NULL));
  while(n_t>t)t=(int)((unsigned)time(NULL));
}

int main(void){
  int t,i;
  printf("Input number of seconds:");
  scanf("%d",&t);
  printf("Let's start countdown!\n\r%2d\n\r",t);
  for(i=t-1;i>=0;i--){
    printf("%2d\n\r",i);
    wait_h(1);
  }
  printf("Time is up!\n\r");
  return 0;
}
