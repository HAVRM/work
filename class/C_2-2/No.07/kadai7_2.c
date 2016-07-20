#include <stdio.h>

void rk(double x,double y,double a,double b,int n);
double f(double x,double y);
FILE *fp;

int main(void){
  fp=fopen("kadai7_2.txt","w");
  if(fp==NULL)return 1;
  int n;
  double a=0.0,b=1.0,x=0.0,y=1.0;
  printf("please input n:");
  scanf("%d",&n);
  rk(x,y,a,b,n);
  fclose(fp);
  return 0;
}

void rk(double x,double y,double a,double b,int n){
  double k1,k2,k3,k4,h;
  int i;
  h=(b-a)/n;
  for(i=0;i<=n;i++){
    fprintf(fp,"%d:x=%lf,y=%lf\n",i,x,y);
    k1=f(x,y);
    k2=f(x+h/2.0,y+h*k1/2.0);
    k3=f(x+h/2.0,y+h*k2/2.0);
    k4=f(x+h,y+h*k3);
    y+=h*(k1+2.0*k2+2.0*k3+k4)/6.0;
    x+=h;
  }
  fprintf(fp,"Ans:%lf\n",y);
  printf("Ans:%lf\n",y);
}

double f(double x,double y){
  return (x+y);
}
