#include <stdio.h>

long combination(long n,long r);

int main(void){
  long n,r,ans;
  printf("prease put the number n of nCr:");
  scanf("%ld",&n);
  printf("prease put the number r of nCr:");
  scanf("%ld",&r);
  ans=combination(n,r);
  printf("answer is %ld\n",ans);
  return 0;
}

long combination(long n,long r){
  if(r==0 || n==r)return 1;
  return combination(n-1,r)+combination(n-1,r-1);
}
