#include <opencv2/opencv.hpp>

int main(int arg,char *argv[]){
  cv::Mat src_img=cv::imread("image/avr3_averaging.png",1);
  cv::Mat chg_img;
  if(!src_img.data)return -1;
  float dataA[][3]={{0.0,-1.0,0.0},{-1.0,5.0,-1.0},{0.0,-1.0,0.0}};
  cv::Mat kernel(3,3,CV_32FC1,dataA);
  cv::filter2D(src_img,chg_img,-1,kernel);
  cv::namedWindow("img1");
  cv::namedWindow("img2");
  cv::imshow("img1",src_img);
  cv::imshow("img2",chg_img);
  cv::waitKey(0);
}
