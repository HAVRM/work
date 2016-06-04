#include <opencv2/opencv.hpp>

int main(int arg,char *argv[]){
  cv::Mat src_img=cv::imread("avr10.JPG",CV_8UC1);
  cv::Mat chg_img;
  if(!src_img.data)return -1;
  cv::equalizeHist(src_img,chg_img);
  cv::namedWindow("img1");
  cv::namedWindow("img2");
  cv::imshow("img1",src_img);
  cv::imshow("img2",chg_img);
  cv::waitKey(0);
}
