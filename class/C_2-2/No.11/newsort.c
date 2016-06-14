typedef struct {
  int id;
  char code[31];
  int age;
  int height;
} PEOPLE;

void selectsort(PEOPLE *a,int n)
{
  int i,j,temp,tn;
  PEOPLE tp;
  for(i=0;i<n-1;i++){
    temp=a[i+1].height;
    tn=i+1;
    for(j=i+1;j<n;j++){
      if(temp>a[j].height){
        temp=a[j].height;
        tn=j;
       }
     }
    if(temp<a[i].height){
       tp=a[tn];
       a[tn]=a[i];
       a[i]=tp;
     }
   }
}

void quick_sort(PEOPLE *a,int left,int right)
{
  int key;
  int i=left,j=right;
  key=a[(left+right)/2].code[0]*256+a[(left+right)/2].code[1];
  PEOPLE temp;
  while(1){
    while(a[i].code[0]*256+a[i].code[1]<key && i<right)i++;
    while(a[j].code[0]*256+a[j].code[1]>key && j>left)j--;
    if(i>=j)break;
    temp=a[i];
    a[i]=a[j];
    a[j]=temp;
    i++;
    j--;
  }
  if(left<i-1)quick_sort(a,left,i-1);
  if(right>j+1)quick_sort(a,j+1,right);
}
