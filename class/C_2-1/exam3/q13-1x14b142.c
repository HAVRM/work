#include <stdio.h>
#include <time.h>

int main(void){
  int t,ft,h,m,s;
  while(1){
    t=(unsigned)time(NULL);
    if(ft!=t){
      ft=t;
      s=t%60;
      t/=60;
      m=t%60;
      t/=60;
      h=t%24+9;
      if(h>23)h-=24;
      printf("%2d:%2d:%2d\n\r",h,m,s);
    }
  }
  return 0;
}
