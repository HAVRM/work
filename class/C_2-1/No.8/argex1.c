#include <stdio.h>

int main(void){
  int data[3];
  data[0]=10;
  data[1]=data[0]*2;
  data[2]=data[1]+3;
  printf("data=%d,%d.\n",data[0],data[2]);
  return 0;
}
