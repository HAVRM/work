#include <stdio.h>
int main(void){
  int age;
  printf("Input your age: ");
  scanf("%d",&age);
  age=(age-18)*3+2;
  printf("Lucky number is %d.\n",age);
  return 0;
}
