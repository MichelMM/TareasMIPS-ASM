#include <stdio.h>

double PotenciaDeDos(int n);

int main(){
    int n=8;
    int res;
    res=PotenciaDeDos(n);
    printf("Potencia de 2 con n = %d: %d",n,res);
    return 0;
}

double PotenciaDeDos(int n){
    if(n<1){
        return 1;
    }else{
        return(2*PotenciaDeDos(n-1));
    }
}
