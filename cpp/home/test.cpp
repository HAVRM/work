#include <stdio.h>
/*
#include "test2.h"
#include "test1.h"
#include "test3.h"

int main(void){
  t b(5);
  b.b[5].a=b.b[5].puls(5,b.b[5].a);
  b.b[5].print(b.b[5].a);
  printf("%d\n\r",test::a);
  return 0;
}
*/
#include "pepper_I.h"

int main(void){
  double pepper_i[3][3];
  double theta=0/180.0*M_PI;
  pepper_arm_I(theta, pepper_i);
  printf("%3.5lf\n\r",theta);
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++)printf("%+3.5lf  ",pepper_i[i][j]);
    printf("\n");
  }
}
