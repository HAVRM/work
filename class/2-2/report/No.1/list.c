#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct node {
  char str[40];
  struct node *next;
} List;

List *list_create(char *ss){
  List *p;
  if((p=(List *)malloc(sizeof(List))) == NULL){
    printf("malloc error\n");
    exit(1);
  }
  strcpy(p->str, ss);
  p->next = NULL;
  return p;
}

List *addHead(List *head, char *ss){
  List *p;
  p=list_create(ss);
  p->next=head;
  return p;

}

List *addTail(List *head, char *ss){
  List *p, *p1;
  if(head == NULL)return addHead(head,ss);
  p=head;
  while(p->next != NULL)p=p->next;
  p1=list_create(ss); 
  p->next=p1;
  return head;
}

List *sortedaddNode(List *head, char *ss){
  char s=ss[0];
  List *p=head,*f=head;
  while(p->next != NULL && strcmp(p->str,ss)<0){
    f=p;
    p=p->next;
  }
  if(f==p)return addHead(p,ss);
  f->next=NULL;
  f=addTail(f,ss);
  f->next->next=p;
  return head;
}

List *delHead(List *head){
  List *p;
  if(head == NULL)return head;
  p=head->next;
  free(head);
  return p;
}

List *delTail(List *head){
  List *p=head;
  if(p == NULL)return p;
  if(p->next == NULL){
    free(p);
    return NULL;
  }
  while(p->next->next !=NULL)p=p->next;
  free(p->next);
  return head;
}

List *delNode(List *head, char *ss){
  char s=ss[0];
  List *p=head,*f=head;
  while(p->next != NULL && strcmp(p->str,ss) != 0){
    f=p;
    p=p->next;
  }
  if(strcmp(p->str,ss) == 0){
    f->next=p->next;
    free(p);
  }
  return head;
}

void disp(List *head){
  List *p=head;
  while(p != NULL){
    printf("%s\n",p->str);
    p=p->next;
  }
}

void dispReverse(List *head){
  List *p=head;
  if(p->next != NULL)dispReverse(p->next);
  printf("%s\n",p->str);
}

int main(void){
  List *p=NULL;
  p=addHead(p,"def");
  p=addHead(p,"abc");
  p=addTail(p,"xyz");
  p=sortedaddNode(p,"opq");
  p=sortedaddNode(p,"lmn");
  p=sortedaddNode(p,"uvm");
  disp(p);
  printf("\n");
  p=delNode(p,"opq");
  dispReverse(p);
  return 0;
}
