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
  int g;
  if(y==0)g=x;
  else g=gcd(y,x%y);
  return g;
}
