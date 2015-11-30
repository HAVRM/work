#include <stdio.h>
int main(void){
  double height,weight,bmi;
  printf("Input your height[cm]:");
  scanf("%lf",&height);
  printf("Input your weight[kg]:");
  scanf("%lf",&weight);
  bmi=10000*weight/(height*height);
  printf("Your BMI is %3.1f. ",bmi);
  if(bmi<18.5f)printf("Underweight");
  else if(bmi<25.0f)printf("Normal");
  else if(bmi<30.0f)printf("Pre-obese");
  else printf("Obese class");
  printf(".\n");
  return 0;
}
