#include <stdio.h>

void swap(int *a,int *b){
  int c;
  c=*a;
  *a=*b;
  *b=c;
}

int main(void){
  int x=100,y=200;
  printf("x=%d, y=%d\n",x,y);
  swap(&x,&y);
  printf("Swap: x=%d, y=%d\n",x,y);
  return 0;
}
