#include <stdio.h>
#define MAN 20

int main(void){
  int points[MAN],i=0,high=0;
  for(i=0;i<MAN;i++){
    if(i!=0)printf(",");
    points[i]=(i*83+11)%101;
    printf("%3d",points[i]);
    if(points[i]>high)high=points[i];
  }
  printf("\n Highest score is %3d.\n",high);
  return 0;
}
