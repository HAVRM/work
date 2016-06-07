#include <stdio.h>

void heun(double x,double y,double a,double b,int n);
double f(double x,double y);
FILE *fp;

int main(void){
  fp=fopen("report1_1.txt","w");
  if(fp==NULL)return 1;
  int n=30;
  double a=0.0,b=0.3,x=0.0,y=1.0;
  heun(x,y,a,b,n);
  fclose(fp);
  return 0;
}

void heun(double x,double y,double a,double b,int n){
  double h,k1,k2;
  int i;
  h=(b-a)/n;
  for(i=0;i<=n;i++){
    fprintf(fp,"%d:x=%lf,y=%lf\n",i,x,y);
    k1=f(x,y);
    k2=f(x+h,y+h*k1);
    y+=h*(k1+k2)/(double)2;
    x+=h;
  }
  fprintf(fp,"Ans:%lf\n",y);
  printf("Ans:%lf\n",y);
}

double f(double x,double y){
  return (-1*x*y);
}
