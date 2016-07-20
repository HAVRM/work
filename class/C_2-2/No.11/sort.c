void selectsort(int *a,int n)
{
  int i,j,temp,tn;
  for(i=0;i<n-1;i++){
    temp=a[i+1];
    tn=i+1;
    for(j=i+1;j<n;j++){
      if(temp>a[j]){
        temp=a[j];
        tn=j;
       }
     }
    if(temp<a[i]){
       a[tn]=a[i];
       a[i]=temp;
     }
   }
}

void quick_sort(int *a,int left,int right)
{
  int key,i=left,j=right,temp;
  key=a[(left+right)/2];
  while(1){
    while(a[i]<key && i<right)i++;
    while(a[j]>key && j>left)j--;
    if(i>=j)break;
    temp=a[i];
    a[i]=a[j];
    a[j]=temp;
  }
  if(left<i-1)quick_sort(a,left,i-1);
  if(right>j+1)quick_sort(a,j+1,right);
}
