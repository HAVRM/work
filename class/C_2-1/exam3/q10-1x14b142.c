#include <stdio.h>
#include <tgmath.h>

int main(void){
  int x1,y1,x2,y2;
  double cpx,cpy,d;
  printf("Input two coordinates:\n\rx1:");
  scanf("%d",&x1);
  printf("y1:");
  scanf("%d",&y1);
  printf("x2:");
  scanf("%d",&x2);
  printf("y2:");
  scanf("%d",&y2);
  cpx=(x1+x2)/2.0;
  cpy=(y1+y2)/2.0;
  d=sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
  printf("Center point is ( %.1f, %.1f).\n\rDistance is %.2f.\n\r",cpx,cpy,d);
  return 0;
}
