#ifndef BEZIER3_H_20160819
#define BEZIER3_H_20160819

template <class T>
class Bezier3{

private:
  T point[4][2];		//start(x,y)->ctrl1,2(x,y)->end(x,y)
  
public:
  Bezier3(T **np){
    for(int i=0;i<4;i++)for(int j=0;j<2;j++)Bezier3::point[i][j]=np[i][j];
  }

  void f(double t,T *a){	//f is function of courve, return a[2]=(x,y)
    for(int i=0;i<2;i++)a[i]=t*t*t*Bezier3::point[3][i]+3*t*t*(1-t)*Bezier3::point[2][i]+3*t*(1-t)*(1-t)*Bezier3::point[1][i]+(1-t)*(1-t)*(1-t)*Bezier3::point[0][i];
  }

  void df(double t,T *a){
    for(int i=0;i<2;i++)a[i]=3*(t*t*(Bezier3::point[3][i]-Bezier3::point[2][i])+2*t*(1-t)*(Bezier3::point[2][i]-Bezier3::point[1][i])+(1-t)*(1-t)*(Bezier3::point[1][i]-Bezier3::point[0][i]));
  }

  void ddf(double t,T *a){
    for(int i=0;i<2;i++)a[i]=6*(t*(Bezier3::point[3][i]-2*Bezier3::point[2][i]+Bezier3::point[1][i])+(1-t)*(Bezier3::point[2][i]-2*Bezier3::point[1][i]+Bezier3::point[0][i]));
  }

  T g(double t,int axes){	//g is function of courve, return by axes (0,1)->(x,y)
    T a[2]
    Bezier3::f(t,a);
    return a[axes];
  }

  T dg(double t,int axes){
    T a[2]
    Bezier3::df(t,a);
    return a[axes];
  }

  T ddg(double t,int axes){
    T a[2]
    Bezier3::ddf(t,a);
    return a[axes];
  }

};

#endif
