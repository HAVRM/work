#ifndef BEZIER2_H_20160819
#define BEZIER2_H_20160819

template <class T>
class Bezier2{

private:
  T point[3][2];		//start(x,y)->ctrl(x,y)->end(x,y)
  
public:
  Bezier2(T **np){
    for(int i=0;i<3;i++)for(int j=0;j<2;j++)Bezier2::point[i][j]=np[i][j];
  }

  void f(double t,T *a){	//f is function of courve, return a[2]=(x,y)
    for(int i=0;i<2;i++)a[i]=t*t*Bezier2::point[2][i]+2*t*(1-t)*Bezier2::point[1][i]+(1-t)*(1-t)*Bezier2::point[0][i];
  }

  void df(double t,T *a){
    for(int i=0;i<2;i++)a[i]=2*(Bezier2::point[2][i]-2*Bezier2::point[1][i]+Bezier2::point[0][i])*t+2*(Bezier2::point[1][i]-Bezier2::point[0][i]);
  }

  void ddf(double t,T *a){
    for(int i=0;i<2;i++)a[i]=2*(Bezier2::point[2][i]-2*Bezier2::point[1][i]+Bezier2::point[0][i]);
  }

  T g(double t,int axes){	//g is function of courve, return by axes (0,1)->(x,y)
    T a[2]
    Bezier2::f(t,a);
    return a[axes];
  }

  T dg(double t,int axes){
    T a[2]
    Bezier2::df(t,a);
    return a[axes];
  }

  T ddg(double t,int axes){
    T a[2]
    Bezier2::ddf(t,a);
    return a[axes];
  }

};

#endif
