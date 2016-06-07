#include <stdio.h>
int main(void){
  int a,b=5,c=2;
  double d=4.0;
  a=b*c;
  c=b%c;
  d-=b/c;
  printf("a=%d,",a);
  printf("b=%d,",b);
  printf("c=%d,",c);
  printf("d=%4.1f\n",d);
  printf("a*5=%d\n",a*5);
  return 0;
}
