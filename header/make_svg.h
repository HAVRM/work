#include <string.h>

class SVG{
private:
  FILE *f;
  int height=128;
  int width=160;
  bool use_background_color=true;
  std::string background="white";
  int 
  

  SVG(int new_height=128,int new_width=160,std::string bgr="white",int marker_num=10,int use_num=10);
  bool open(std::string filename, std::string mode);
  int close();
  int marker(std::string name,int );//return marker id
  void path(const char type,double *data[2]);
