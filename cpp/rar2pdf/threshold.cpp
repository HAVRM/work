#include <stdio.h>
#include <opencv2/opencv.hpp>

// ./a.out [original] [out]

int main(int arg,char *argv[]){
  //printf("%d:\n\r%s\n\r%s\n\r",arg,argv[1],argv[2]);
  if(arg!=3)return -1;
  cv::Mat src_img=cv::imread(argv[1],CV_8UC1);
  cv::Mat chg_img;
  if(!src_img.data)return -1;
  cv::threshold(src_img,chg_img,75,255,CV_THRESH_BINARY_INV);
  cv::imwrite(argv[2],chg_img);
  cv::waitKey(0);
}
