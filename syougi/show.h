#ifndef SHOUGI_SHOW_H
#define SHOUGI_SHOW_H

/*
 * 香桂銀金王金銀桂香
 *   飛         角
 * 歩歩歩歩歩歩歩歩歩
 *
 *
 *
 * 歩歩歩歩歩歩歩歩歩
 *   角         飛
 * 香桂銀金玉金銀桂香
 *
 * 王      1
 * 玉      2
 * 金      5
 * 飛->竜  3
 * 角->馬  4
 * 銀->全  6
 * 桂->圭  7
 * 香->杏  8
 * 歩->と  9
 * 成り上がり+10
 * my     () +0
 * enemy  <> +20
 * can go [] +40 (_:40=0)
 */

int map[9][9]={{28,27,26,25,21,25,26,27,28},
	       {0,23,0,0,0,0,0,24,0},
	       {29,29,29,29,29,29,29,29,29},
	       {0,0,0,0,0,0,0,0,0},
	       {0,0,0,0,0,0,0,0,0},
	       {0,0,0,0,0,0,0,0,0},
	       {9,9,9,9,9,9,9,9,9},
	       {0,4,0,0,0,0,0,3,0},
	       {8,7,6,5,1,5,6,7,8}};
int get[2][7]; //飛角金銀桂香歩:獲得個数格納
int space[20][2]; //移動可能場所

void int_shougi(){
  int i,j;
  for(i=0;i<2;i++)for(j=0;j<7;j++)get[i][j]=0;
  for(i=0;i<20;i++)for(j=0;j<2;j++)space[i][j]=0;
}

void select_koma(int num){
  if(num==1)printf("王");
  else if(num==2)printf("玉");
  else if(num==3)printf("飛");
  else if(num==4)printf("角");
  else if(num==5)printf("金");
  else if(num==6)printf("銀");
  else if(num==7)printf("桂");
  else if(num==8)printf("香");
  else if(num==9)printf("歩");
  else if(num==13)printf("竜");
  else if(num==14)printf("馬");
  else if(num==16)printf("全");
  else if(num==17)printf("圭");
  else if(num==18)printf("杏");
  else if(num==19)printf("と");
  else printf("＿");
}

void print_map(){
  printf("\n\r       一  二  三  四  五  六  七  八  九\n\n\r");
  int i,j,k;
  for(i=0;i<9;i++){
    printf(" %d    ",i+1);
    for(j=0;j<9;j++){
      k=map[i][j];
      if(k==0)printf(" 　 ");
      else if(k<20){
	printf("(");
	select_koma(k);
	printf(")");
      }else if(k<40){
	printf("<");
	select_koma(k-20);
	printf(">");
      }else{
	printf("[");
	select_koma(k-40);
	printf("]");
      }
    }
    printf("\n\n\r");
  }
  printf("\n\n");
}

#endif
