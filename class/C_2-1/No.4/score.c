#include <stdio.h>
int main(void){
  int Math,English,Science,Sum;
  double Average;
  printf("Input your scores:\nMath: ");
  scanf("%d",&Math);
  printf("English: ");
  scanf("%d",&English);
  printf("Science: ");
  scanf("%d",&Science);
  Sum=Math+English+Science;
  Average=(double)Sum/3.0f;
  printf("Your grade is ");
  if(Sum<180)printf("F");
  else if(Sum<210)printf("C");
  else if(Sum<240)printf("B");
  else if(Sum<270)printf("A");
  else printf("A+");
  printf(" (Average is %.1f).\n",Average);
  return 0;
}
