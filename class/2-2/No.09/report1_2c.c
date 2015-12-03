#include <stdio.h>

long combination(long n,long r);

int main(void){
  long n,r,ans;
  int i;
  FILE *fp;
  fp=fopen("report1_2_kekka.txt","w");
  for(i=40;i<=50;i++)fprintf(fp,"65 C %d=%ld\n",i,combination(65,i));
  fclose(fp);
  return 0;
}

long combination(long n,long r){
  if(r==0 || n==r)return 1;
  int i=0;
  long double c=1;
  if(n-r<r)r=n-r;
  for(i=0;i<r;i++)c=c*(long double)(n-i)/(long double)(r-i);
  return (long)c;
}
