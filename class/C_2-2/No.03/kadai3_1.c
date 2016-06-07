#include <stdio.h>
#include <string.h>

#define N 4

void gauss(double a[][N],double b[]);

double mat1[N][N]={{1.0,2.0,1.0,1.0},
{4.0,5.0,-2.0,4.0},
{4.0,3.0,-3.0,1.0},
{2.0,1.0,1.0,3.0}};
double mat2[N]={-1.0,-7.0,-12.0,2.0};

int main(void){
  int i;
  gauss(mat1,mat2);
  printf("\nAnswer:\n");
  for(i=0;i<N;i++)printf("%3.3f\n",mat2[i]);
  printf("\n");
  return 0;
}

void gauss(double a[][N],double b[N]){
  int i,j,k;
  double temp;
  for(i=0;i<N;i++){
    for(j=i+1;j<N;j++){
      temp=-1*a[j][i]/a[i][i];
      for(k=i;k<N;k++)a[j][k]+=temp*a[i][k];
      b[j]+=temp*b[i];
    }
  }
  for(i=N-1;i>=0;i--){
    temp=0;
    for(j=i+1;j<N;j++)temp+=a[i][j]*b[j];
    b[i]-=temp;
    b[i]/=a[i][i];
  }
}
