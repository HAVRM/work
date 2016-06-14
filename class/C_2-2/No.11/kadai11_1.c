#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define N 7

typedef struct {
  int id;
  char name[30];
} BOOK;

int comp_id(const void *a,const void *b)
{
  int num1=((*(BOOK *)a).id);
  int num2=((*(BOOK *)b).id);
  return num1-num2;
}

int comp_str(const void *a,const void *b)
{
  int num1=(int)((*(BOOK *)a).name[0]);
  int num2=(int)((*(BOOK *)b).name[0]);
  return num1-num2;
}

int main(void){
  int i;
  BOOK item[N]={{120,"book1"},{42,"C Prog."},
                {53,"Perl Prog."},{236,"C++ Prog."},
                {8,"Pascal Porg."},{189,"Lisp Prog."},
                {35,"JAVA Prog."}};
  qsort(item,N,sizeof(BOOK),comp_id);
  for(i=0;i<N;i++)printf("id=%d,name=%s\n",item[i].id,item[i].name);
  printf("\n");
  qsort(item,N,sizeof(BOOK),comp_str);
  for(i=0;i<N;i++)printf("id=%d,name=%s\n",item[i].id,item[i].name);
  return 0;
}
