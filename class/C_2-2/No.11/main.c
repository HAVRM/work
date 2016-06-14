#include <stdio.h>
#include "sort.h"

int main(void)
{
  int num1[]={3,2,5,4,1};
  int num2[]={30,20,50,40,10};
  int i;

  selectsort(num1,5);
  for(i=0;i<5;i++)printf("%d ",num1[i]);
  printf("\n");

  quick_sort(num2,0,4);
  for(i=0;i<5;i++)printf("%d ",num2[i]);
  printf("\n");
  return 0;
}
