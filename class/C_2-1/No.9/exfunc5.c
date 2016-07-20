#include <stdio.h>
#define SIZE 20
int score[SIZE];

void showHighestScore(void){
  int hi=0,i;
  for(i=0;i<SIZE;i++)if(hi<score[i])hi=score[i];
  printf("Highest : %d.\n",hi);
  return;
}

int main(void){
  int i;
  for(i=0;i<SIZE;i++)score[i]=i*2;
  showHighestScore();
  for(i=0;i<SIZE;i++)score[i]+=10;
  showHighestScore();
  return 0;
}
