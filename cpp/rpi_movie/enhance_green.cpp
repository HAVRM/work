#include <stdio.h>
#include <opencv2/opencv.hpp>

void top_low(cv::Mat src_img, int tl[3][2]);
void enhancement(cv::Mat src_img,cv::Mat chg_img,float alpha[3],float beta[3]);

int main(int arg,char *argv[]){
  if(arg!=3)return -1;
  float alpha;
  cv::Mat src_img=cv::imread(argv[1],1);
  cv::Mat chg_img=cv::imread(argv[1],1);
  alpha=255/(float)149;
  if(!src_img.data)return -1;
  for(int y=0;y<src_img.rows;y++)for(int x=0;x<src_img.cols;x++){
    chg_img.at<cv::Vec3b>(y,x)[1]=cv::saturate_cast<uchar>(alpha*(src_img.at<cv::Vec3b>(y,x)[1]));
  }
  cv::imwrite(argv[2],chg_img);
  cv::waitKey(0);
}
