#include <stdio.h>
#include <opencv2/opencv.hpp>

void top_low(cv::Mat src_img, int tl[3][2]);
void enhancement(cv::Mat src_img,cv::Mat chg_img,float alpha[3],float beta[3]);

int main(int arg,char *argv[]){
  int tl[3][2];
  float alpha[3],beta[3];
  cv::Mat src_img=cv::imread("avr10.JPG",1);
  cv::Mat chg_img=cv::imread("avr10.JPG",1);
  if(!src_img.data)return -1;

  top_low(src_img,tl);
  if(tl[0]==tl[1]){
    printf("error:high and row is same\n");
    return 0;
  }
  printf("min=%d|%d|%d,max=%d|%d|%d\n",tl[0][0],tl[1][0],tl[2][0],tl[0][1],tl[1][1],tl[2][1]);
  for(int i=0;i<3;i++){
    alpha[i]=255/(float)(tl[i][1]-tl[i][0]);
    beta[i]=-1*tl[i][0]*255/(float)(tl[i][1]-tl[i][0]);
  }
  enhancement(src_img,chg_img,alpha,beta);
  cv::namedWindow("img1");
  cv::namedWindow("img2");
  cv::imshow("img1",src_img);
  cv::imshow("img2",chg_img);
  cv::waitKey(0);
}

void top_low(cv::Mat src_img,int tl[3][2]){ //0:min,1:max
  for(int i=0;i<3;i++)for(int j=0;j<2;j++)tl[i][j]=src_img.at<cv::Vec3b>(0,0)[i];
  for(int y=0;y<src_img.rows;y++)for(int x=0;x<src_img.cols;x++)for(int c=0;c<3;c++){
    if(tl[c][0]>src_img.at<cv::Vec3b>(y,x)[c])tl[c][0]=src_img.at<cv::Vec3b>(y,x)[c];
    else if(tl[c][1]<src_img.at<cv::Vec3b>(y,x)[c])tl[c][1]=src_img.at<cv::Vec3b>(y,x)[c];
  }
}

void enhancement(cv::Mat src_img,cv::Mat chg_img,float alpha[3],float beta[3]){
  for(int y=0;y<src_img.rows;y++)for(int x=0;x<src_img.cols;x++)for(int c=0;c<3;c++){
    chg_img.at<cv::Vec3b>(y,x)[c]=cv::saturate_cast<uchar>(alpha[c]*(src_img.at<cv::Vec3b>(y,x)[c])+beta[c]);
  }
}
