#include <stdio.h>
int main(void){
  double Age;
  printf("Input your age: ");
  scanf("%lf",&Age);
  Age=(Age-18)*3+2.1;
  printf("Lucky number is %f.\n",Age);
  return 0;
}
