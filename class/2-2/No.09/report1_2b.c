#include <stdio.h>

long combination(long n,long r);

int main(void){
  long n,r,ans;
  printf("prease put the number n of nCr:");
  scanf("%ld",&n);
  printf("prease put the number r of nCr:");
  scanf("%ld",&r);
  ans=(long)combination(n,r);
  printf("answer is %ld\n",ans);
  int i;
  //for(i=40;i<=65;i++)printf("65 C %d=%ld\n",i,combination(65,i));
  return 0;
}

long combination(long n,long r){
  if(r==0 || n==r)return 1;
  int i=0;
  double c=1;
  if(n-r<r)r=n-r;
  for(i=0;i<r;i++)c=c*(double)(n-i)/(double)(r-i);
  //printf("%lf\n",c);
  return (long)c;
}