#include <opencv2/opencv.hpp>

int main(int arg,char *argv[]){
  cv::Mat src_img=cv::imread("avr10.JPG",1);
  cv::Mat chg_img;
  if(!src_img.data)return -1;
  cv::cvtColor(src_img,chg_img,CV_RGB2GRAY);
  cv::namedWindow("img1");
  cv::namedWindow("img2");
  cv::imshow("img1",src_img);
  cv::imwrite("img2.jpeg",chg_img);
  cv::waitKey(0);
}
