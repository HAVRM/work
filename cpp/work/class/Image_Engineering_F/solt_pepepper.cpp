#include <opencv2/opencv.hpp>

void solt_pepper_noise(cv::Mat src_img,cv::Mat chg_img);

int main(int arg,char *argv[]){
  cv::Mat src_img=cv::imread("avr10.JPG",1);
  cv::Mat chg_img=cv::imread("avr10.JPG",1);
  if(!src_img.data)return -1;
  solt_pepper_noise(src_img,chg_img);
  cv::namedWindow("img1");
  cv::namedWindow("img2");
  cv::imshow("img1",src_img);
  cv::imshow("img2",chg_img);
  cv::waitKey(0);
}

void solt_pepper_noise(cv::Mat src_img,cv::Mat chg_img){
  int x,y;
  for(int y=0;y<src_img.rows;y++)for(int x=0;x<src_img.cols;x++)for(int c=0;c<3;c++){
    chg_img.at<cv::Vec3b>(y,x)[c]=src_img.at<cv::Vec3b>(y,x)[c];
  }
  for(int i=0;i<4000;i++)for(int j=0;j<2;j++){
    x=rand()%src_img.cols;
    y=rand()%src_img.rows;
    for(int k=0;k<3;k++)chg_img.at<cv::Vec3b>(y,x)[k]=255*j;
  }
}
