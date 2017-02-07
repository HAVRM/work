#include <opencv2/opencv.hpp>

int main(int arg,char *argv[]){
  cv::Mat src_img=cv::imread("avr3.JPG",1);
  cv::Mat chg_img;
  if(!src_img.data)return -1;

  cv::medianBlur(src_img,chg_img,3);
  for(int i=0;i<2;i++)cv::medianBlur(chg_img,chg_img,3);

  cv::namedWindow("img1");
  cv::namedWindow("img2");
  cv::imshow("img1",src_img);
  cv::imshow("img2",chg_img);
  cv::waitKey(0);
}
