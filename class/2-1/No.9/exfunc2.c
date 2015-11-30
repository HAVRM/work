#include <stdio.h>
#define SIZE 10

void setZero(int a[], int n){
  int i;
  for(i=0;i<n;i++)a[i]=0;
}

int main(void){
  int a[SIZE];
  setZero(a,SIZE);
  //...
}
