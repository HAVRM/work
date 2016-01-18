#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char form[100];
int state[100];//num:0~9,operator:101~,*01:-,*02:+,*11:/,*12:*,*21:^,*31:!
const char *ope="-+/*^ !";

int char2rank(char c, int o);
void swapdiv(void);
int power(int x, int y);
int factorial(int x);
void del_ele(int n);
int set_form(void);//-1:miss much (),-2:unknown operator
int calc(char *f, int *s,int n);

int main(void){
  int j;
  while(1){
    printf("please write formula which you want to calculation:\n\n");
    fgets(form,100,stdin);
    j=set_form();
    //swapdiv();
    int i;
    //for(i=0;i<20;i++)printf("%d,",state[i]);
    //printf("\n");
    printf("=%d\n\n",calc(form,state,j));
  }
  return 0;
}

int char2rank(char c,int o){
  int i;
  for(i=0;ope[i]!='\0';i++)if(c==ope[i])return i%2+(i/2)*10+o+101;
  return -1;
}

/*void swapdiv(void){
  int i,j,k,l,tn;
  char tc
  for(i=0;form[i]!='\n';i++)if(form[i]=='/'){
    for(j=i+1;form[j]!='\n';j++)if(state[i]/10==state[j]/10){
      for(k=j+1;form[k]!='\n';k++)if(state[j]/10==state[k]/10 && state[i]%10<){
    tn=state[i];
    for(l=1;l<)

}*/

int power(int x, int y){
  int i,a=1;
  if(y>0)for(i=0;i<y;i++)a*=x;
  else if(y<0)for(i=0;i<y;i++)a/=x;
  return a;
}

int factorial(int x){
  int i,a=1;
  for(i=1;i<=x;i++)a*=i;
  return a;
}

void del_ele(int n){
  int i;
  for(i=n;i<99;i++){
    form[i]=form[i+1];
    state[i]=state[i+1];
  }
}

int set_form(){
  int i,j,b,p,e,n;//b:(),p:^,e:error,n:\n
  j=0;b=0;
  for(i=0;form[i]!='\n';i++){
    if(form[i]>=48 && form[i]<=57)state[i]=form[i]-48;
    else if(form[i]=='('){
      b+=100;
      del_ele(i);
      i--;
    }else if(form[i]==')'){
      b-=100;
      if(b<0)return -1;
      del_ele(i);
      i--;
    }else{
      if(form[i]==j && j=='^'){
        p+=100;
        state[i]=char2rank(form[i],b+p);
      }else{
        p=0;
        state[i]=char2rank(form[i],b);
      }
      j=form[i];
      if(state[i]==-1)return -2;
    }
    n=i;
  }
  return n;
}

int calc(char *f, int *s,int n){
  int i,j=0,p,fn,sn,an;//j:smallest operator,p:place j is located, fn(operator)sn sn:answer
  for(i=0;i<=n;i++)if(j==0 || j>=(s[i]/10))if(s[i]>100){
    j=s[i]/10;
    p=i;
  }
  if(j==0){
    an=0;
    for(i=0;i<=n;i++)an=an*10+f[i]-48;
    return an;
  }
  //for(i=0;i<=n;i++)printf("%c",f[i]);
  //printf("\n");
  char *ff,*bf;
  int *fs,*bs;
  ff=&f[0];
  bf=&f[p+1];
  fs=&s[0];
  bs=&s[p+1];
  fn=calc(ff,fs,p-1);
  sn=calc(bf,bs,n-p-1);
  //-+/*^!
  //printf("%d(%d)%d",fn,s[p]%100,sn);
  switch(s[p]%100){
    case 1:
      an=fn-sn;
      break;

    case 2:
      an=fn+sn;
      break;

    case 11:
      an=fn/sn;
      break;

    case 12:
      an=fn*sn;
      break;

    case 21:
      an=power(fn,sn);
      break;

    case 31:
      an=factorial(fn);
      break;

    default:
      an=0;
      break;
  }
  //printf("=%d\n",an);
  return an;
}
