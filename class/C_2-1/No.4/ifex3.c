#include <stdio.h>
int main(void){
  int score;
  printf("Write your point\n");
  scanf("%d",&score);
  if(score<70){
    if(score<60)printf("Your grade is F\n");
    else printf("Your grade is C\n");
  }else{
    if(score<80)printf("Your grade is B\n");
    else{
      if(score<90)printf("Your grade is A\n");
      else printf("Your grdae is A+\n");
    }
  }
  return 0;
}
