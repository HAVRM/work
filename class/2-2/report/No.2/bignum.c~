#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct node {
  short num;
  struct node *next;
  struct node *before;
} List;

List *list_create(int num);
List *addTail(List *head, int num);

List *list_create(int num){
  List *p;
  if((p=(List *)malloc(sizeof(List))) == NULL){
    printf("malloc error\n");
    exit(1);
  }
  p->num=num%1000;
  if(num/1000!=0)p=addTail(p,num/1000);
  return p;
}

List *addHead(List *head, int num){
  List *p;
  p=list_create(num);
  p->next=head;
  head->before=p;
  return p;

}

List *addTail(List *head, int num){
  List *p, *p1;
  if(head == NULL)return addHead(head,num);
  p=head;
  while(p->next != NULL)p=p->next;
  p1=list_create(num); 
  p->next=p1;
  p1->before=p;
  return head;
}

void disp(List *head){
  List *p=head;
  int m=1;
  if(p->next != NULL){
    disp(p->next);
    if(p->num<0)m=-1;
  }
  if(p->next == NULL)printf("%d",p->num*m);
  else printf("%03d",p->num*m);
  if(p->before==NULL)printf("\n");
}

List *list_multi_int_over(List *head, int num, int snum){
  List *p=head;
  int n=p->num;
  n*=num;
  n+=snum;
  p->num=n%1000;
  if(n/1000!=0 && p->next==NULL)p=addTail(p,0);
  if(p->next!=NULL)p=list_multi_int_over(p->next,num,n/1000);
  return head;
}

List *list_multi_int(List *head, int num){
  List *p=head;
  int n=p->num;
  n*=num;
  p->num=n%1000;
  if(n/1000!=0 && p->next==NULL)p=addTail(p,0);
  if(p->next!=NULL)p=list_multi_int_over(p->next,num,n/1000);
  return head;
}

List *list_add_over(List *h1,List *h2,List *p){
  int n=h1->num+h2->num+p->num;
  p->num=n%1000;
  if(h1->next != NULL || h2->next != NULL || n/1000!=0){
    p=addTail(p,n/1000);
    p=list_add_over(h1->next,h2->next,p->next);
  }
  return p->before;
}

List *list_add(List *h1,List *h2){
  List *p;
  int n=h1->num+h2->num;
  p=list_create(n%1000);
  if(h1->next != NULL || h2->next != NULL || n/1000!=0){
    p=addTail(p,n/1000);
    p=list_add_over(h1->next,h2->next,p->next);
  }
  return p;
}

int main(void){
  List *p=NULL,*p1=NULL;
  int i;
  p=list_create(1);
  p1=list_create(630);
  for(i=0;i<1000;i++)p=list_multi_int(p,31);
  for(i=629;i>0;i--)p1=list_multi_int(p1,i);
  p=list_add(p,p1);
  disp(p);
  free(p);
  free(p1);
}
}
