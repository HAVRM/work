#include <stdio.h>

char *num2str(int i)
{
  static int num2str_num=0;
  static char str[100][30];
  if(num2str_num>=100)num2str_num=0;
  sprintf(str[num2str_num],"%d",i);
  num2str_num++;
  return str[num2str_num-1];
}

int main(void)
{
  int num1, num2;
  printf("Input number 1: ");
  scanf("%d", &num1);
  printf("Input number 2: ");
  scanf("%d", &num2);
  printf("%d,%d\n",num1,num2);
  printf("%s %s\n",num2str(num1),num2str(num2));
  return 0;
}
