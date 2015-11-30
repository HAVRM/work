#include <stdio.h>
#define NUM 20

void scores(int a[],int num){
  int i;
  for(i=0;i<num;i++){
    a[i]=(i*83+12)%101;
    printf("%3d,",a[i]);
  }
}

double average(int a[],int num){
  int i;
  double ave=0;
  for(i=0;i<num;i++)ave+=a[i];
  ave/=num;
  return ave;
}

void pass(int a[],int num,double ave){
  int i;
  for(i=0;i<num;i++){
    if(a[i]>ave)printf("  Y,");
    else printf("   ,");
  }
}

int main(void){
  int points[NUM];
  double ave;
  printf("Scores:");
  scores(points,NUM);
  ave=average(points,NUM);
  printf("\nAverage value is %.2f.\nPASS??:",ave);
  pass(points,NUM,ave);
  printf("\n");
  return 0;
}
