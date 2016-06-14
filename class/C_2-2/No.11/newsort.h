typedef struct {
  int id;
  char code[31];
  int age;
  int height;
} PEOPLE;

void selectsort(PEOPLE *,int);
void quick_sort(PEOPLE *,int,int);
