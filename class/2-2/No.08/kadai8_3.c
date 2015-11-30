#include <stdio.h>

int gcd(int x,int y);

int main(void){
  int x,y,g;
  printf("prease put x:");
  scanf("%d",&x);
  printf("prease put y:");
  scanf("%d",&y);
  g=gcd(x,y);
  printf("the greatest common divisor is %d\n",g);
  return 0;
}

int gcd(int x,int y){
  int g,t;
  while(1){
    if(y==0)break;
    t=y;
    y=x%y;
    x=t;
  }
  return x;
}
