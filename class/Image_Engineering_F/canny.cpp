#include <opencv2/opencv.hpp>

int main(int arg,char *argv[]){
  cv::Mat src_img=cv::imread("image/avr6_threshold.png",CV_8UC1);
  cv::Mat chg_img;
  if(!src_img.data)return -1;
  cv::Canny(src_img,chg_img,100,200);
  cv::namedWindow("img1");
  cv::namedWindow("img2");
  cv::imshow("img1",src_img);
  cv::imshow("img2",chg_img);
  cv::waitKey(0);
}
