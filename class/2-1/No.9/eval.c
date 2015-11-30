#include <stdio.h>
#define NUM 20
#define RAN 5

int rank[RAN];

double eval(int a[],int size){
  int i;
  double ave=0;
  for(i=0;i<RAN;i++)rank[i]=0;
  for(i=0;i<size;i++){
    rank[(a[i]/20)+1]++;
    ave+=a[i];
  }
  ave/=(double)NUM;
  return ave;
}

int main(void){
  int i,points[NUM];
  printf("Score: ");
  for(i=0;i<NUM;i++){
    points[i]=(i*83+12)%101;
    if(i!=0)printf(",");
    printf("%3d",points[i]);
  }
  printf("\nAverage is %.2f\n",eval(points,NUM));
  int j=0;
  for(i=RAN;i>0;i--){
    printf("Rank%d:",i);
    for(j=0;j<rank[i];j++)printf("*");
    printf("\n");
  }
  return 0;
}
