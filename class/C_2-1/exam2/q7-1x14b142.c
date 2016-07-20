#include <stdio.h>

#define NUM 20
int i,j;

void farg(int a[],int num){
  for(i=0;i<num;i++)printf("%3d,",a[i]);
}

void scores(int a[],int num){
  for(i=0;i<num;i++)a[i]=(i*83+12)%101;
  farg(a,num);
}

void swap(int a[],int num){
  int t;
  for(i=0;i<num;i++){
    for(j=i+1;j<num;j++){
      if(a[j]>a[i]){
	t=a[j];
	a[j]=a[i];
	a[i]=t;
      }
    }
  }
}

int main(void){
  int points[NUM];
  printf("Original scores:");
  scores(points,NUM);
  swap(points,NUM);
  printf("\nSorted scores  :");
  farg(points,NUM);
  printf("\n");
  return 0;
}
