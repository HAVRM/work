#ifndef SHOUGI_CHANGE_H
#define SHOUGI_CHANGE_H

int return_1(int num){return num-((int)(num/10))*10;} //1st number
int return_n(int num){return (num-return_1(num))%2;} //0:nomal,1:成
int return_e(int num){return num>20;} //0:my,1:enemy

void int_space(int x,int y){
  int i,j;
  for(i=0;i<20;i++){
    space[i][0]=x-1;
    space[i][1]=y-1;
  }
}

void set_space(int x,int y){
  int i,j,k;
  for(i=0;i<20;i++){
    for(j=0;j<2;j++){
      k=space[i*2+j];
      if(k<0 || k>8){
	space[i*2]=x-1;
	space[i*2+1]=y-1;
	j=1;
      }
    }
  }
}

void show_able(int x,int y){
  int k=map[y-1][x-1],i,temp[4];
  int s=retutn_1(k);
  int sn=return_n(k);
  if(s==0)printf("Select piece!");
  else{
    int_space(x,y);
    if(s==1 || s==2){
      space[0][0]=x;
      space[1][0]=x-1;
      space[2][0]=x-2;
      space[3][0]=x;
      space[4][0]=x-2;
      space[5][0]=x;
      space[6][0]=x-1;
      space[7][0]=x-2;
      space[0][1]=y-2;
      space[1][1]=y-2;
      space[2][1]=y-2;
      space[3][1]=y-1;
      space[4][1]=y-1;
      space[5][1]=y;
      space[6][1]=y;
      space[7][1]=y;
    }else if(s==3){
      for(i=0;i<9;i++){
	space[i][0]=x-1;
	space[i][1]=i;
	space[i+9][0]=i;
	space[i+9][1]=y-1;
      }
      if(sn==1){
	space[y-1][0]=x;
	space[y-1][1]=y;
	space[x+8][0]=x-2;
	space[x+8][1]=y-2;
	space[18][0]=x;
	space[18][1]=y-2;
	space[19][0]=x-2;
	space[19][0]=y;
      }
    }else if(s==4){
      for(i=0;i<8;i++){
	space[i][0]=i;
	space[i][1]=y-x+i;
	space[i+9][0]=i;
	space[i+9][1]=y+x-i;
	if(sn==1)
space[i][0]=

#endif
