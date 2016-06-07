#include <stdio.h>

int main(void){
  int a,b;
  printf("Please write 1st number:");
  scanf("%d",&a);
  printf("Please write 2nd number:");
  scanf("%d",&b);
  printf("%d+%d=%d\n\r%d-%d=%d\n\r%d*%d=%d\n\r%d/%d=%.3lf\n\r",a,b,a+b,a,b,a-b,a,b,a*b,a,b,(double)a/(double)b);
  return 0;
}
