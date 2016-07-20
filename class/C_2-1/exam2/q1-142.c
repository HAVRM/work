#include <stdio.h>

int main(void){
  int data[5]={2,5,2,3,8};
  data[0]=data[1]+4;
  data[1]=-2;
  data[2]=data[3]%data[2];
  data[3]=data[1]+data[3]*data[4];
  int i;
  for(i=0;i<5;i++)printf("data[%d]=%2d\n",i,data[i]);
  return 0;
}
