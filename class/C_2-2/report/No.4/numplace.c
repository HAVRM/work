#include <stdio.h>
#include <stdlib.h>

#define NUM 100

int ans[9][9],temp[9][9][10];
int char2int(char c);
void disp(void);
void disp_num(void);
void reset_var(void);
void read_num(void);//read from .txt
void del_num(void);//delete the number which can't put in
int fill_num(void);//fill the num which have only 1 number to put in,return is the number of filled space,-1 is error:no number to put in
int calc(int f);//return function

int main(void){
  reset_var();
  read_num();
  int n=calc(0);
  printf("\n");
  if(n!=-1)disp();
  else printf("can't solve\n");
  return 0;
}

void reset_var(void){
  int i,j,k;
  for(i=0;i<9;i++){
    for(j=0;j<9;j++){
      ans[i][j]=0;
      temp[i][j][0]=9;
      for(k=1;k<10;k++)temp[i][j][k]=1;
    }
  }
}

int char2int(char c){
  if(c == ' ')return 0;
  return (int)(c)-48;
}

void disp(void){
  int i,j;
  for(i=0;i<9;i++){
    for(j=0;j<9;j++){
      if(ans[i][j] == 0)printf(" _ ");
      else printf(" %d ",ans[i][j]);
    }
    printf("\n\n");
  }
}

void disp_num(void){
  int i,j,k;
  for(i=0;i<9;i++){
    for(j=0;j<9;j++)printf("%d",temp[i][j][0]);
    printf("\n");
  }
}

void read_num(void){
  char s[100],d[100];
  int i,j;
  printf("prease put teh name of numplace file:");
  scanf("%s",s);
  FILE *f = fopen(s,"r");
  if(f==NULL){
    printf("error in opening file\n");
    exit(1);
  }
  i=0;
  while(fgets(d,NUM,f) != NULL){
    if(d[0] != ';'){
      for(j=0;j<9;j++)ans[i][j]=char2int(d[j]);
      i++;
    }
  }
}

void del_num(void){
  int i,j,k,l,m,n,a;
  for(i=0;i<9;i++)for(j=0;j<9;j++)for(k=1;k<=9;k++)temp[i][j][k]=1;
  for(i=0;i<9;i++){
    for(j=0;j<9;j++){
      if(ans[i][j] != 0){
        a=ans[i][j];
        for(k=1;k<=9;k++)temp[i][j][k]=0;
        for(k=0;k<9;k++){
          temp[i][k][a]=0;
          temp[k][j][a]=0;
        }
        if(i==j)for(k=0;k<9;k++)temp[k][k][a]=0;
        if(i+j==8)for(k=0;k<9;k++)temp[k][8-k][a]=0;
        m=i/3;
        n=j/3;
        for(k=0;k<3;k++)for(l=0;l<3;l++)temp[k+m*3][l+n*3][a]=0;
        temp[i][j][a]=1;
        temp[i][j][0]=1;
      }
    }
  }
  for(i=0;i<9;i++){
    for(j=0;j<9;j++){
      l=0;
      for(k=1;k<=9;k++)l+=temp[i][j][k];
      temp[i][j][0]=l;
    }
  }
}

int fill_num(void){
  int i,j,k,l;
  for(i=0;i<9;i++)for(j=0;j<9;j++)if(temp[i][j][0] == 0)return -1;
  l=0;
  for(i=0;i<9;i++){
    for(j=0;j<9;j++){
      if(temp[i][j][0] == 1){
        k=1;
        while(1){
          if(temp[i][j][k]==1)break;
          k++;
        }
        ans[i][j]=k;
        l++;
      }
    }
  }
  return l;
}

int calc(int f){
  int fans[9][9];
  int n=f+1;
  while(f<n && n<81){
    f=n;
    del_num();
    n=fill_num();
    if(n!=-1)printf("filled %d/81\n",n);
  }
  if(n!=81)disp();
  else printf("\nfinish!\n");
  if(n==-1)printf("^ error, try again\n\n");
  if(n<81 && n>0){
    int i,j,k=11,x,y,s=9;
    for(i=0;i<9;i++)for(j=0;j<9;j++)if(temp[i][j][0]<s && temp[i][j][0]>1){
      s=temp[i][j][0];
      x=i;
      y=j;
    }
    f=-1;
    for(i=0;i<9;i++)for(j=0;j<9;j++)fans[i][j]=ans[i][j];
    s=10;
    while(f==-1 && s!=k){
      for(i=0;i<9;i++)for(j=0;j<9;j++)ans[i][j]=fans[i][j];
      del_num();
      k=s;
      for(i=1;i<k;i++)if(temp[x][y][i]==1)s=i;
      if(k!=s){
        ans[x][y]=s;
        printf("put number %d on [%d,%d] from (",s,x,y);
        for(i=1;i<=9;i++)if(temp[x][y][i]==1)printf(" %d ",i);
        printf(")\n");
        f=calc(n);
      }
    }
    n=f;
  }
  return n;
}
