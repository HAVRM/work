#include <stdio.h>

int main(void){
  int h,y,C,Y,m,d,i,state=0;
  printf("Input year:");
  scanf("%d",&y);
  if(y<4)state=0;
  else if(y==4)state=1;
  else if(y<1586)state=2;
  else if(y==1586)state=3;
  else state=4;
  if(y<0)y+=100*((y*-1)/100+1);
 re_m:
  printf("Input month:");
  scanf("%d",&m);
  if(m<0 || m>12){
    printf("prease write collect month¥n");
    goto re_m;
  }else if(m==1 || m==2){
    m+=12;
    y--;
  }
  switch(m){
  case 3:
  case 5:
  case 7:
  case 8:
  case 10:
  case 12:
  case 13:
    d=31;
    break;

  case 14:
    if(((y+1)%4==0 && (y+1)%100!=0) || (y+1)%400==0)d=29;
    else d=28;
    break;

  default:
    d=30;
    break;
  }

  C=y/100;
  Y=y%100;
  switch(state){
  case 0:
  }
  h=((int)(26*(m+1)/10)+Y+(int)(Y/4)+(5*C)+(int)(C/4))%7;
  //printf("%d\n",h);
  printf("Sun Mon Tue Wed Thu Fri Sat\n");
  for(i=0;i<h;i++)printf("    ");
  for(i=1;i<=d;i++){
    printf("%3d ",i);
    if((i+h)%7==0)printf("\n");
  }
  printf("\n");
  return 0;
}
