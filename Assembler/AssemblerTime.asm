#include <stdio.h>
#include <time.h>       // clock_t, clock(), CLOCKS_PER_SEC
#include <stdlib.h>
 int comp(int a, int b)
 {
        if(a>b)
       return 1;
       else if(a<b)
       return 2;
       else
        return 0;
 }

 int Asm1()
 {
    int a = 5, b = 2, c = 6, cc =0, sum = 0, sub=0, mul=0, div = 0, sr = 0, sr1 = 0;
   __asm
    {
        push eax
        push ecx

        mov eax, a 
        mov ecx, b
        add eax, ecx 
        mov sum, eax

        pop ecx
        pop eax
    }

    __asm
    {
        push eax
        push ecx

        mov eax, a 
        mov ecx, b
        sub eax, ecx
        mov sub,eax
        
        pop ecx
        pop eax
    }
 
   __asm
    {
        push eax
        push ecx

        mov eax, a 
        mov ecx, b
        imul ecx
        mov mul, eax

        pop ecx
        pop eax
    }
   __asm
   {
        push eax
        push ecx
        push edx

        mov eax, a 
        mov ecx, b
        mov edx, 0
        idiv ecx
        mov div, eax

        pop edx
        pop ecx
        pop eax

    }
  __asm
    {
        push eax
        push ecx

        mov eax, a 
        mov ecx, b
        cmp eax, ecx
        je equal_2
        jg greater_2
        mov eax, 2
        mov sr, eax
        jmp finish22
    equal_2:
        mov eax, 0 
        mov sr, eax
        jmp finish22
    greater_2:
        mov eax, 1
        mov sr, eax
    finish22: 
        pop ecx
        pop eax
    
  }

    return 0;
 }

 void saveFile(double time_spent)
 {

 FILE *S;
  S = fopen("Test.csv", "w");
  fprintf(S, "%f,", time_spent);
  fclose(S);

 }
 void addFile (double time_spent, int h, int a)
 {
 FILE *S;
  S = fopen("Test.csv", "a");
  if(a)
  {
    if(h)
     fprintf(S, "%f,\n", time_spent);
  else
      fprintf(S, "%f\n", time_spent);
  }
  else 
  {
    if(h)
     fprintf(S, "%f,", time_spent);
  else
      fprintf(S, "%f", time_spent);
  }

  fclose(S);
 }



int main()
{
    system("chcp 1251>nul");


    int a = 5, b = 2, c = 6, cc =0, sum = 0, sub=0, mul=0, div = 0, sr = 0, sr1 = 0;
    int z;
    double time_spent = 0.0;
    clock_t begin = clock();
    for(int i = 0;i<100000;i++)
    {
       z = a+b;
       z = a-b;
       z = a*b;
       z = a/b;
       z = comp(a,b);
    }
    clock_t end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Замер времени c шагом 100000 на СИ %f сек\n", time_spent);
    saveFile(time_spent);

    time_spent = 0.0;
    begin = clock();
    for(int i = 0;i<1000000;i++)
    {
       z = a+b;
       z = a-b;
       z = a*b;
       z = a/b;
       z = comp(a,b);
    }
    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Замер времени с шагом 1000000 на СИ %f сек\n", time_spent);
    addFile(time_spent,1,0);

    time_spent = 0.0;
    begin = clock();
    for(int i = 0;i<10000000;i++)
    {
       z = a+b;
       z = a-b;
       z = a*b;
       z = a/b;
       z = comp(a,b);
    }

    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Замер времени с шагом 10000000 на СИ %f сек\n", time_spent);
    addFile(time_spent,0,1);

    time_spent = 0.0;
    begin = clock();
    for(int i = 0;i<100000;i++)
    {
     Asm1();
    }
    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("\nЗамер работы с шагом 100000 ассемберного кода %f сек", time_spent);
    addFile(time_spent,1,0);

    time_spent = 0.0;
    begin = clock();
    for(int i = 0;i<1000000;i++)
    {
     Asm1();
    }
    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("\nЗамер работы с шагом 1000000 ассемберного кода %f сек", time_spent);
    addFile(time_spent,1,0);

    time_spent = 0.0;
    begin = clock();
    for(int i = 0;i<10000000;i++)
    {
     Asm1();
    }
    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("\nЗамер работы с шагом 10000000 ассемберного кода %f сек", time_spent);
    addFile(time_spent,0,0);
}