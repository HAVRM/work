#include <stdio.h>
#include <math.h>

int accuracy=100;

void vector_product(float A[3],float B[3],float AB[3]);

int main(void){
  float x[3]={1,0,0},w[3]={0,0,2*M_PI},temp[3],tmp;
  FILE *f=fopen("pte1.csv","w");
  if(f==NULL){
    printf("can't open file");
    return 0;
  }
  fprintf(f,"%f,%f,%f\n",x[0],x[1],x[2]);
  for(int i=0;i<accuracy;i++){
    tmp=i/(float)accuracy;
    vector_product(w,x,temp);
    for(int j=0;j<3;j++)x[j]+=temp[j]*tmp;
    fprintf(f,"%f,%f,%f\n",x[0],x[1],x[2]);
  }
  fclose(f);
}


void vector_product(float A[3],float B[3],float AB[3]){
  AB[0]=A[1]*B[2]-A[2]*B[1];
  AB[1]=A[2]*B[0]-A[0]*B[2];
  AB[2]=A[0]*B[1]-A[1]*B[0];
}
