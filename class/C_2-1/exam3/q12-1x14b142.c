#include <stdio.h>
#include <stdlib.h>
#define STU 100

int main(void){
  int i,num[STU];
  double ave=0;
  FILE *file=fopen("input.txt","r");
  for(i=0;i<100;i++){
    fscanf(file,"%3d",&num[i]);
    ave+=num[i];
  }
  ave/=100.0;
  fclose(file);
  file=fopen("output.txt","w");
  fprintf(file,"Average value :%3.2f\n",ave);
  for(i=0;i<100;i++){
    fprintf(file,"%3d",num[i]);
    if(num[i]>ave)fprintf(file," Y");
    fprintf(file,"\n\r");
  }
  return 0;
}
