#include <stdio.h>

void euler(double x,double y,double a,double b,int n);
double f(double x,double y);
FILE *fp;

int main(void){
  fp=fopen("kadai7_1.txt","w");
  if(fp==NULL)return 1;
  int n;
  double a=0.0,b=1.0,x=0.0,y=1.0;
  printf("please input n:");
  scanf("%d",&n);
  euler(x,y,a,b,n);
  fclose(fp);
  return 0;
}

void euler(double x,double y,double a,double b,int n){
  double h;
  int i;
  h=(b-a)/n;
  for(i=0;i<=n;i++){
    fprintf(fp,"%d:x=%lf,y=%lf\n",i,x,y);
    y+=h*f(x,y);
    x+=h;
  }
  fprintf(fp,"Ans:%lf\n",y);
  printf("Ans:%lf\n",y);
}

double f(double x,double y){
  return (x+y);
}
