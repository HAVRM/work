#include <stdio.h>
#define ELE 4

int main(void){
  int a[ELE][ELE],b[ELE][ELE],ans[ELE][ELE];
  int i,j,k;
  for(i=0;i<ELE;i++){
    for(j=0;j<ELE;j++){
      a[i][j]=i*4+j+1;
      b[i][j]=i*4+j+17;
    }
  }
  for(i=0;i<ELE;i++){
    for(j=0;j<ELE;j++){
      ans[i][j]=0;
      for(k=0;k<ELE;k++){
	ans[i][j]+=a[i][k]*b[k][j];
      }
      printf("%4d ",ans[i][j]);
    }
    printf("\n\r");
  }
  return 0;
}
