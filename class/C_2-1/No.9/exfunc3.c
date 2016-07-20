#include <stdio.h>

void func(int x){
  x=7;
}

int main(void){
  int x=3;
  func(x);
  printf("x is %d.\n",x);
  return 0;
}
