#include <opencv2/opencv.hpp>
#include <stdio.h>
#include <sys/time.h>

int main(int arg,char *argv[]){
//  cv::Mat src_img=cv::imread("avr6.JPG",CV_8UC1);
//  cv::Mat src_img=cv::imread("avr3.JPG",CV_8UC1);
  cv::Mat src_img=cv::imread("avr10_spn.JPG",CV_8UC1);
  cv::Mat chg_img;
  std::vector<std::vector<cv::Point> > cont;
  std::vector<cv::Vec4i> hier;
  if(!src_img.data)return -1;
//  cv::threshold(src_img,chg_img,75,255,CV_THRESH_BINARY);
//  cv::threshold(src_img,chg_img,125,255,CV_THRESH_BINARY);
  cv::threshold(src_img,chg_img,130,255,CV_THRESH_BINARY);
  cv::namedWindow("img1");
  cv::imshow("img1",src_img);
  cv::namedWindow("img2");
  cv::imshow("img2",chg_img);
  clock_t s=clock();
  cv::findContours(chg_img,cont,hier,CV_RETR_TREE,CV_CHAIN_APPROX_NONE);
  clock_t e=clock();
  cv::namedWindow("img3");
  cv::imshow("img3",chg_img);
  int max=1;
  for(int i=0;max>=i;i++){
    printf("%d:(%d,%d,%d,%d)\n\r",i,hier[i][0],hier[i][1],hier[i][2],hier[i][3]);
    for(int j=0;j<4;j++)if(max<hier[i][j])max=hier[i][j];
  }
  long diff=e-s;
  printf("contour : find %d time : %d ms\n\r",max,diff);
  cv::waitKey(0);  
}
