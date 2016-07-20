#include <stdio.h>
#include <math.h>

int str_len(char *str);
int str2int(char *str);
double str2double(char *str);

int main(void){
  char *a="123",*b="90586",*c="123.45",*d="0.6789";
  printf("%d,%d,%lf,%lf\n",str2int(a),str2int(b),str2double(c),str2double(d));
  return 0;
}

int str_len(char *str){
  int i;
  for(i=0;str[i]!='\0';i++);
  return i;
}

int str2int(char *str){
  int num=str_len(str),i,in=0;
  for(i=0;i<num;i++)in=in*10+(str[i]-48);
  return in;
}

double str2double(char *str){
  int num=str_len(str),i;
  double ln=0,state=0;
  for(i=0;i<num;i++){
    if(str[i]=='.')state=1;
    else{
      if(state!=0)state++;
      ln=ln*10+(str[i]-48);
    }
  }
  ln/=pow(10.0,state-1);
  return ln;
}
