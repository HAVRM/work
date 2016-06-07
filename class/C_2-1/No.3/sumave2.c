#include <stdio.h>
int main(void){
  int a[3];
  printf("Input three average\n");
  int i;
  for(i=0; i<3; i++){
    printf("a[%d]:",i);
    scanf("%d",a+i);
  }
  printf("Sum is %d,Average is %.1f.\n",a[0]+a[1]+a[2],(a[0]+a[1]+a[2])/3.0);
  return 0;
}
