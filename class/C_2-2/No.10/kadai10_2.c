#include <stdio.h>

int bin_search(int ary[],int n,int key)
{
  int left,right,mid;

  left=0;
  right=n-1;
  while(left<=right){
    mid=(left+right)/2;
    printf("%d,%d,%d\n",left,right,mid);
    if(ary[mid]==key)return mid;
    else if(ary[mid]<key)left=mid+1;
    else if(ary[mid]>key)right=mid-1;
  }
  return -1;
}

int main(void)
{
  int key;
  int data[14]={5,10,15,20,25,30,35,40,45,50,55,60,65,70};
  for(key=10;key<=70;key+=10){
    printf("data=%d ret=%d\n",key,bin_search(data,14,key));
  }
  return 0;
}
