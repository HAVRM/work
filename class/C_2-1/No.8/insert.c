#include <stdio.h>
#define MAN 21

int main(void){
  int points[MAN],id,score,i;
  printf("Original scores:\n");
  for(i=0;i<MAN-1;i++){
    points[i]=(i*83+11)%101;
    if(i!=0)printf(",");
    printf("%3d",points[i]);
  }
  printf("\nInput insert ID and score:");
  scanf("%d,%d",&id,&score);
  for(i=MAN-1;i>id;i--)points[i]=points[i-1];
  points[id]=score;
  printf("Ineserted scores:\n");
  for(i=0;i<MAN;i++){
    if(i!=0)printf(",");
    printf("%3d",points[i]);
  }
  printf("\n");
  return 0;
}
