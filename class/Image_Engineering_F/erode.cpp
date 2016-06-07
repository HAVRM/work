#include <opencv2/opencv.hpp>

int main(int arg,char *argv[]){
  cv::Mat src_img=cv::imread("avr6.JPG",CV_8UC1);
  cv::Mat chg_img;
  if(!src_img.data)return -1;
  cv::threshold(src_img,chg_img,75,255,CV_THRESH_BINARY);
  cv::erode(chg_img,chg_img,cv::Mat(),cv::Point(-1,-1),1);
  cv::namedWindow("img1");
  cv::namedWindow("img2");
  cv::imshow("img1",src_img);
  cv::imshow("img2",chg_img);
  cv::waitKey(0);
}
