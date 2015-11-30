#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

void gauss2(int ele,double **a,double *b);

int main(int argc,char *argv[]){
  char *name;
  int i,j,ele;
  double **mat1,*mat2;
  name=(char *)malloc(sizeof(argv[1]));
  if(name==NULL){
    printf("errer:create field of name");
    exit(1);
  }
  name=argv[1];
  FILE *fp;
  fp=fopen(name,"r");
  if(fp==NULL){
    printf("error:open file\n");
    exit(1);
  }
  fscanf(fp,"%d",&ele);
  mat1=(double **)malloc(sizeof(double *)*ele);
  for(i=0;i<ele;i++)mat1[i]=(double *)malloc(sizeof(double)*ele);
  if(mat1==NULL){
    printf("errer:create field of mat1");
    exit(1);
  }
  mat2=(double *)malloc(sizeof(double)*ele);
  if(mat2==NULL){
    printf("errer:create field of mat2");
    exit(1);
  }
  for(i=0;i<ele;i++)for(j=0;j<ele;j++)fscanf(fp,"%lf",&mat1[i][j]);
  for(i=0;i<ele;i++)fscanf(fp,"%lf",&mat2[i]);
  gauss2(ele,mat1,mat2);
  printf("\nAnswer:\n");
  for(i=0;i<ele;i++)printf("%3.3f\n",mat2[i]);
  printf("\n");
  fclose(fp);
  free(mat1);
  free(mat2);
  return 0;
}

void gauss2(int ele,double **a,double *b){
  int i,j,k,l;
  double temp;
  for(i=0;i<ele;i++){
    for(j=i;j<ele;j++){
      for(k=j+1;k<ele;k++){
	if(fabs(a[j][i])<fabs(a[k][i])){
	  temp=b[j];
	  b[j]=b[k];
	  b[k]=temp;
	  for(l=0;l<ele;l++){
	    temp=a[j][l];
	    a[j][l]=a[k][l];
	    a[k][l]=temp;
	  }
	}
      }
    }
    for(j=i+1;j<ele;j++){
      temp=-1*a[j][i]/a[i][i];
      for(k=i;k<ele;k++)a[j][k]+=temp*a[i][k];
      b[j]+=temp*b[i];
    }
  }
  for(i=ele-1;i>=0;i--){
    temp=0;
    for(j=i+1;j<ele;j++)temp+=a[i][j]*b[j];
    b[i]-=temp;
    b[i]/=a[i][i];
  }
}
