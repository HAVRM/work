#include <stdio.h>
int main(void){
  int score=85;
  if(score<80)printf("Your grade is B\n");
  else if(score<90)printf("Your grade is A\n");
  else printf("Your grade is A+\n");
  return 0;
}
