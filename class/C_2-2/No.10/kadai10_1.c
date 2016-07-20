#include <stdio.h>

typedef struct {
  char title[30];
  int pages;
  int id;
} BOOK;

BOOK item[8]={
 {"Engish Reading",110,980},
 {"C Prog.",218,3000},
 {"Pre1 Prog.",120,1800},
 {"C++ Prog.",360,4500},
 {"Pascal Prog.",190,2900},
 {"Lisp Prog.",150,1700},
 {"JAVA Prog.",200,2900},
 {"C# Prog.",240,3800}};

int item_num=8;

int linear_search(BOOK ary[],int n,int key)
{
  int i,fid,gk;
  gk=10000;
  fid=ary[n-1].id;
  ary[n-1].id=gk;
  i=0;
  while(1){
    if (ary[i].id==key) return i;
    else if(ary[i].id==gk){
       if(fid==key) return i;
       else{
         ary[n-1].id=fid;
         return -1;
        }
     }
    i++;
  }
  return -1;
}

int main(void)
{
  int ret;
  ret=linear_search(item,item_num,1700);
  if(ret==-1)printf("not found\n");
  else printf("id=%d,name=%s\n",ret,item[ret].title);

  return 0;
}
