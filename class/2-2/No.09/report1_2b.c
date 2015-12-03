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
