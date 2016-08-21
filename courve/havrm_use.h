#ifndef HAVRM_H_20160819
#define HAVRM_H_20160819

#include <stdarg.h>

#define ml(x,y,z) (x<y && y<z)
#define aml(x,y,z) (x<=y && y<z)
#define mal(x,y,z) (x<y && y<=z)
#define amal(x,y,z) (x<=y && y<=z)
#define swap(type,a,b) {type c=a;a=b;b=c;}	//use: ex. swap(int,a,b) <- x:if(...)swap(); => if(...){;;;};

template <class T>
bool math_set_E(T a, int ele,...){		//if a is in ...(<- * ele), return true ex. math_set_E(5,3,2,3,5)=true
  bool ans=false;
  va_list ap;
  T data;
  va_start(ap,ele);
  for(int i=0;i<ele;i++){
    data=va_arg(ap,T);
    if(a==data){
      ans=true;
      break;
    }
  }
  va_end(ap);
  return ans;
}

#endif
