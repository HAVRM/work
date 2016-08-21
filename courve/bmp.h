#ifndef BMP_H_20160819
#define BMP_H_20160819

#include "havrm_use.h"


//left_down is 0,0
class Bmp{

public:
  typedef struct  bmp_fheader_st{
    unsigned short  bfType            __attribute__((packed));
    unsigned long   bfSize            __attribute__((packed));
    unsigned short  bfReserved1       __attribute__((packed));
    unsigned short  bfReserved2       __attribute__((packed));
    unsigned long   bfOffBits         __attribute__((packed));
  }
  bmp_fheader;

  typedef struct bmp_iheader_st{
    unsigned long   biSize            __attribute__((packed));
    long            biWidth           __attribute__((packed));
    long            biHeight          __attribute__((packed));
    unsigned short  biPlanes          __attribute__((packed));
    unsigned short  biBitCount        __attribute__((packed));
    unsigned long   biCompression     __attribute__((packed));
    unsigned long   biSizeImage       __attribute__((packed));
    long            biXPixPerMeter    __attribute__((packed));
    long            biYPixPerMeter    __attribute__((packed));
    unsigned long   biClrUsed         __attribute__((packed));
    unsigned long   biCirImportant    __attribute__((packed));
  }
  bmp_iheader;
 
  typedef struct  color_palette_st{
    unsigned char    red;
    unsigned char    green;
    unsigned char    blue;
    unsigned char    dummy;
  }
  color_palette;

private:

  bmp_fheader bf;
  bmp_iheader bi;
  color_palette *rgb;

  unsigned char **data;				//for 1-8 bit
  unsigned char ***ldata;			//for 24,32bit->[3],[4]

  FILE *fp
  bool gray=true;
  int color=8;
  int zero[2]={0,0};
  int width=160;				//fill color area
  int hight=128;
  double ratio=1.0;				//pixel=data*ratio

  bool set_palette=false;
  bool set_img_size_l=false;
  bool set_img_size_h=false;
  int now_color,now_width,now_hight;		//now palette size & full img area


  template <class T>
  unsigned char return_palette_num(T search_rgb[]);
  template <class T>
  void return_bitcolor_data(T search_rgb[], unsigned char ans_rgb[]);

  void release_size();
  void release_palette();

  template <class T>
  void write_pix_dot(int p[], T d_color[]=Bmp::dummy3, int d_width=1);

  int dummy[3]={0,0,0};
  int dummy2[2][3]={{0,0,0,0},{255,255,255,0}};
  unsigned char dummy3[4]={255,255,255,0};

public:

  Bmp(int color_bit=8, int img_width=160, int img_hight=128, char *name="image.bmp", bool gray_only=true);
  ~Bmp();
  void set_color(bool defo=true, int **palette=Bmp::dummy2);
  void set_size(int img_width=160, int img_hight=128);
  void set_zero(int p[]);
  void set_ratio(double d);
  template <class T>
  void set_area(T left_down[], T right_up[]);
  template <class T,T1>
  void write_dot(T p[], T1 d_color[]=Bmp::dummy3, int d_width=1);
  template <class T,T1>
  void write_line(T p1[], T p2[], T1 stroke_color[]=Bmp::dummy3, int stroke_width=1);
  template <class T,T1>
  void write_axes(int img_width=1, T1 stroke_color[]=Bmp::dummy3);
  template <class T,T1>
  void write_circle(T o[], T r, T1 stroke_color[]=Bmp::dummy3, int stroke_width=1, T1 fill_color[]=Bmp::dummy3);
  template <class T,1>
  void write_square(T left_down[], T right_up[], T1 stroke_color[]=Bmp::dummy3, int stroke_width=1, T1 fill_color[]=Bmp::dummy3);
};

void Bmp::release_size(){
  if(Bmp::set_img_size_l){
    for(int i=0;i<Bmp::now_hight;i++)free(Bmp::data[i]);
    free(Bmp::data);
    Bmp::set_img_size_l=false;
  }
  if(Bmp::set_img_size_h){
    for(int i=0;i<Bmp::now_hight;i++){
      for(int j=0;j<Bmp::width;j++)free(Bmp::ldata[i][j]);
      free(Bmp::ldata[i]);
    }
    free(Bmp::ldata);
    Bmp::set_img_size_h=false;
  }
}

void Bmp::release_palette(){
  if(Bmp::set_palette){
    free(Bmp::rgb);
    Bmp::set_palette=false;
  }
}

Bmp::Bmp(int color_bit=8, int img_width=160, int img_hight=128, char *name="image.bmp", bool gray_only=true){
  Bmp::color=color_bit;
  Bmp::set_color(true);
  Bmp::set_size(img_width,img_hight);
  Bmp::gray=gray_only;
  Bmp::fp=fopen(name,"w");
  Bmp::bf.bfType = 0x4D42;
  Bmp::bf.bfReserved1 = 0;
  Bmp::bf.bfReserved2 = 0;
  Bmp::bi.biSize = sizeof(bmp_iheader);
  Bmp::bi.biPlanes = 1;
  Bmp::bi.biCompression = 0;
  Bmp::bi.biSizeImage = 0;
  Bmp::bi.biXPixPerMeter = 0;
  Bmp::bi.biYPixPerMeter = 0;
  Bmp::bi.biClrUsed = 0;
  Bmp::bi.biCirImportant = 3;
  Bmp::set_zero();
}

Bmp::~Bmp(){
  int size=Bmp::now_width*Bmp::now_hight;
  Bmp::bf.bfSize = 54 + (size/8) + (4*2); // ファイルのサイズを指定
  if(Bmp::color<=8)Bmp::bf.bfOffBits = sizeof(bmp_fheader)+sizeof(bmp_iheader)+sizeof(color_palette)*(2<<Bmp::color);
  else Bmp::bf.bfOffBits = sizeof(bmp_fheader)+sizeof(bmp_iheader);
  Bmp::bi.biWidth = Bmp::now_width;
  Bmp::bi.biHeight = Bmp::now_height;
  Bmp::bi.biBitCount = Bmp::color;
  fwrite(&Bmp::bf,sizeof(bmp_fheader),1,Bmp::fp);
  fwrite(&Bmp::bi,sizeof(bmp_iheader),1,Bmp::fp);
  if(Bmp::color<=8)fwrite(&Bmp::rgb,sizeof(color_palette)*(2<<Bmp::color),1,Bmp::fp);
  if(Bmp::color<=8)fwrite(&Bmp::data,sizeof(data),1,Bmp::fp);
  else fwrite(&Bmp::ldata,sizeof(ldata),1,fp);
  fclose(Bmp::fp);
  Bmp::release_palette();
  Bmp::release_size();
}

void Bmp::set_size(int img_width=160, int img_hight=128){
//data[128][160]
  Bmp::width=img_width;
  Bmp::hight=img_hight;
  Bmp::release_size();
  if(Bmp::color<=8){
    if((img_width%4)!=0)img_width+=4-img_width%4;
    Bmp::data=(unsigned char **)malloc(sizeof(unsigned char *)*hight);
    for(int i=0;i<hight;i++)Bmp::data[i]=(unsigned char *)malloc(sizeof(unsigned char)*width);
    Bmp::now_width=img_width;
    Bmp::now_hight=img_hight;
    Bmp::set_img_size_l=true;
    for(int i=0;i<hight;i++)for(int j=0;j<width;j++)Bmp:data[i][j]=0;
  }else{
    if((img_width%4)!=0)img_width+=4-img_width%4;
    Bmp::ldata=(unsigned char ***)malloc(sizeof(unsigned char **)*hight);
    for(int i=0;i<hight;i++){
      Bmp::ldata[i]=(unsigned char **)malloc(sizeof(unsigned char *)*width);
      for(int j=0;j<width;j++)Bmp::ldata[i][j]=(unsigned char *)malloc(sizeof(unsigned char )*Bmp::color/8);
    }
    Bmp::now_width=img_width;
    Bmp::now_hight=img_hight;
    Bmp::set_img_size_h=true;
    for(int i=0;i<hight;i++)for(int j=0;j<width;j++)for(int k=0;k<Bmp::color/8;k++)Bmp::ldata[i][j][k]=0;
  }
}

void Bmp::set_color(bool defo=true, int **palette=Bmp::dummy2){
  if(Bmp::set_palette){
    if(math_set_E(Bmp::color,5,1,4,8,24,32)==false){
      if(1/Bmp::color>=1)Bmp::color=1;
      else if(4/Bmp::color>=1)Bmp::color=4;
      else if(8/Bmp::color>=1)Bmp::color=8;
      else if(24/Bmp::color>=1)Bmp::color=24;
      else Bmp::color=32;
    }
    if(Bmp::now_color!=Bmp::color){
      if(Bmp::color/Bmp::now_color>=3 || Bmp::now_color/Bmp::color>=3)Bmp::set_size(Bmp::width,Bmp::hight);
      Bmp::release_palette();
    }
  }
  if(Bmp::set_palette==false && Bmp::color<=8){
    Bmp::rgb=(color_palette *)malloc(sizeof(color_palette)*(2<<Bmp::color);
    for(int i=0;i<2<<Bmp::color;i++){
      Bmp::rgb[i].red=0;
      Bmp::rgb[i].green=0;
      Bmp::rgb[i].blue=0;
      Bmp::rgb[i].dummy=0;
    }
    Bmp::set_palette=true;
  }
  Bmp::now_color=Bmp::color;
  if(defo && Bmp::color<=8){
    if(Bmp::color<4)Bmp::gray=true;
    if(Bmp::gray){
      for(int i=0;i<2<<Bmp::color;i++){
        Bmp::rgb[i].red=i*255/(2<<Bmp::color-1);
        Bmp::rgb[i].green=i*255/(2<<Bmp::color-1);
        Bmp::rgb[i].blue=i*255/(2<<Bmp::color-1);
        Bmp::rgb[i].dummy=0;
      }
    }else{
      if(Bmp::color==4){
        for(int i=0;i<2;i++)for(int j=0;j<2;j++)for(int k=0;k<2;k++){
          Bmp::rgb[i*4+j*2+k].red=i*255;
          Bmp::rgb[i*4+j*2+k].green=j*255;
          Bmp::rgb[i*4+j*2+k].blue=k*255;
          Bmp::rgb[i*4+j*2+k].dummy=0;
        }
        for(int i=1;i<=7;i++){
          Bmp::rgb[i+7].red=i*32-1;
          Bmp::rgb[i+7].green=i*32-1;
          Bmp::rgb[i+7].blue=i*32-1;
          Bmp::rgb[i+7].dummy=0;
        }
      }else{
        for(int i=0;i<8;i++)for(int j=0;j<8;j++)for(int k=0;k<4;k++){
          Bmp::rgb[i*32+j*4+k].red=i*255/7;
          Bmp::rgb[i*32+j*4+k].green=j*255/7;
          Bmp::rgb[i*32+j*4+k].blue=k*255/3;
          Bmp::rgb[i*32+j*4+k].dummy=0;
        }
      }
    }
  }else{
    for(int i=0;i<2<<Bmp::color;i++){
      Bmp::rgb[i].red=palette[i][0];
      Bmp::rgb[i].green=palette[i][1];
      Bmp::rgb[i].blue=palette[i][2];
      Bmp::rgb[i].dummy=0;
    }
  }
}

void Bmp::set_zero(int p[]){
  for(int i=0;i<2;i++)Bmp::zero[i]=p[i];
}

void Bmp::set_ratio(double d){
  Bmp::ratio=d;
}

template <class T>
void Bmp::set_area(T left_down[], T right_up[]){
  int p[2]={0,0};
  double rat=Bmp::width/(right_up[0]-left_down[0]);
  for(int i=0;i<2;i++)p[i]=(int)((double)(right_up[i]-left_down[i])/rat/2.0);
  Bmp::set_zero(p);
  Bmp::set_ratio(rat);
}

template <class T>
void Bmp::write_pix_dot(int p[], T d_color[]=Bmp::dummy3, int d_width=1){
  unsigned char pal=Bmp::return_palette_num(d_color);
  unsigned char npal[4];
  Bmp::return_bitcolor_data(d_color,npal);
  if(d_width>1){
    if(d_width%2==1){
      for(int i=(1-d_width)/2;i<=(d_width-1)/2;i++)for(int j=(1-d_width)/2;j<=(d_width-1)/2;j++){
        if(Bmp::color<=8) Bmp::data[p[1]+i][p[0]+j]=pal;
        else for(int l=0;l<Bmp::color/8;l++)Bmp::ldata[p[1]+i][p[0]+j][l]=npal[l];
      }
    }else{
      for(int i=0-d_width/2;i<=d_width/2;i++)for(int j=abs(i)-d_width/2;j<=d_width/2-abs(i);j++){
        if(Bmp::color<=8) Bmp::data[p[1]+i][p[0]+j]=pal;
        else for(int l=0;l<Bmp::color/8;l++)Bmp::ldata[p[1]+i][p[0]+j][l]=npal[l];
      }
    }
  }else{
    if(Bmp::color<=8) Bmp::data[p[1]][p[0]]=pal;
    else for(int l=0;l<Bmp::color/8;l++)Bmp::ldata[p[1]][p[0]][l]=npal[l];
  }
}

template <class T,T1>
void Bmp::write_dot(T p[], T1 d_color[]=Bmp::dummy3, int d_width=1){
  int pp[2];
  for(int i=0;i<2;i++)pp[i]=p[i]*Bmp::ratio+Bmp::zero[i];
  Bmp::write_pix_dot(pp[],d_color[],d_width);
}

template <class T,T1>
void Bmp::write_line(T p1[], T p2[], T1 stroke_color[]=Bmp::dummy3, int stroke_width=1){
  int pp[2][2];
  int j[2]={0,1};
  if(p1[0]>p2[0]){
    j[0]=1;
    j[1]=0;
  }
  for(int i=0;i<2;i++){
    pp[j[0]][i]=p1[i]*Bmp::ratio+Bmp::zero[i];
    pp[j[1]][i]=p2[i]*Bmp::ratio+Bmp::zero[i];
  }
  double k[2];
  if(pp[1][0]!=pp[0][0]){
    k[0]=(pp[1][1]-pp[0][1])/(pp[1][0]-pp[0][0]);
    k[1]=pp[0][1]-k[0]*pp[0][0];
    for(int i=pp[0][0];i<=pp[1][0];i++){
      j[0]=i;
      j[1]=k[0]*i+k[1];
      Bmp::write_pix_dot(j,stroke_color,stroke_width);
    }
  }else{
    if(pp[0][1]>pp[1][1])swap(int,pp[0][1],pp[1][1]);
    for(int i=pp[0][1];i<=pp[1][1];i++){
      j[0]=pp[0][0];
      j[1]=i;
      Bmp::write_pix_dot(j,stroke_color,stroke_width);
    }
  }
}

template <class T,T1>
void Bmp::write_axes(int img_width=1, T1 stroke_color[]=Bmp::dummy3){
  int p[2]={0,0};
  for(int i=0;i<Bmp::width;i++){
    p[1]=Bmp::zero[1];
    p[0]=i;
    Bmp::write_pix_dot(p,stroke_color,img_width);
  }
  for(int i=0;i<Bmp::hight;i++){
    p[0]=Bmp::zero[0];
    p[1]=i;
    Bmp::write_pix_dot(p,stroke_color,stroke_width);
  }
}

template <class T,T1>
void Bmp::write_circle(T o[], T r, T1 stroke_color[]=Bmp::dummy3, int stroke_width=1, T1 fill_color[]=Bmp::dummy3){
  T p[2]={0,0};
  double tr;
  for(double i=0.0;i<3.15;i=i+0.001){
    p[0]=o[0]+r*cos(i);
    p[1]=o[1]+r*sin(i);
    Bmp::write_dot(p,stroke_color,stroke_width);
  }
  for(double i=0.0;i<r;i=i+0.01){
    tr=(double)r-i;
    Bmp::write_circle(o,tr,fill_color,stroke_width,fill_color);
  }
}

template <class T,T1>
void Bmp::write_square(T left_down[], T right_up[], T1 stroke_color[]=Bmp::dummy3, int stroke_width=1, T1 fill_color[]=Bmp::dummy3){
  T p1[2],p2[2];
  double ld[2],ru[2];
  p1[0]=left_down[0];
  p1[1]=left_down[1];
  p2[0]=left_down[0];
  p2[1]=right_up[1];
  Bmp::write_line(p1,p2,stroke_color,stroke_width);
  p1[0]=right_up[0];
  p1[1]=right_up[1];
  Bmp::write_line(p1,p2,stroke_color,stroke_width);
  p2[0]=right_up[0];
  p2[1]=left_down[1];
  Bmp::write_line(p1,p2,stroke_color,stroke_width);
  p1[0]=left_down[0];
  p1[1]=left_down[1];
  Bmp::write_line(p1,p2,stroke_color,stroke_width);
  for(double i=0.0;i<1.0;i=i+0.01){
    for(int j=0;j<2;j++){
      ld[j]=(double)left_down[j]+(double)(right_up[j]-left_down[j])*i/2.0;
      ru[j]=(double)right_up[j]-(double)(right_up[j]-left_down[j])*i/2.0;
    }
    Bmp::write_square(ld,ru,fill_color,1,fill_color);
  }
}

#endif
