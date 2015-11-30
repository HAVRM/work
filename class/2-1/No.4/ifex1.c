#include <stdio.h>
int main(void){
  int score=85;
  if(score<80)printf("Your grade is B\n");
  if(80<=score && score<90)printf("Your grade is A\n");
  if(90<=score)printf("Your grade is A+\n");
  return 0;
}
