#include <stdio.h>
#include <string.h>

typedef struct{
  char title[30];
  int pages;
  int price;
}BOOK;

BOOK item[8]={
  {"English Reading",110,980},{"C Prog.",218,3000},
  {"Perl Prog.",120,1800},{"C++ Prog.",360,4500},
  {"Pascal Prog.",190,2200},{"Lisp Prog.",150,1700},
  {"JAVA Prog.",200,2900},{"C# Prog.",240,3800}};
int item_num=8;

int main(void){
  int i=0;
  int max_pages,max_pages_id;
  int min_price,min_price_id;
  for(i=0;i<item_num;i++){
    if(max_pages<item[i].pages){
      max_pages=item[i].pages;
      max_pages_id=i;
    }
    if(min_price>item[i].price){
      min_price=item[i].price;
      min_price_id=i;
    }
  }
  printf("max pages book: %s\n",item[max_pages_id].title);
  printf("min price book: %s,pages: %d,price: %d\n",item[min_price_id].title,item[min_price_id].pages,item[min_price_id].price);
  return 0;
}
