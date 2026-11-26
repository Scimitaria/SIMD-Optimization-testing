#include <iostream>
#include <iomanip>
#include <random>
#include <chrono>
using namespace std;

template <typename Func>
auto time(Func func){
    using clk = std::chrono::steady_clock;
    constexpr int N = 10'000'000;
    auto t0 = clk::now();
    for(int i=0;i<N;i++) func();
    auto t1 = clk::now();
    return std::chrono::duration<double, std::nano>(t1-t0).count() / N;
}
template <typename Func>
void compare(Func cpp, Func assembly, Func simd){
    std::printf(" %5.1f | %5.1f | %5.1f\n", time(cpp), time(assembly), time(simd));
    return;
}


void add(){
    double a[8] = {4,2,5,8,6,3,7,1};
    double b[8] = {9,5,2,3,7,8,4,6};
    double c[8];
    for(int i=0;i<8;i++) c[i]=a[i]+b[i];
}
extern "C" void Add_ASM_();
extern "C" void Add_SIMD_();

void shift(){
    int a[8] = {4,2,5,8,6,3,7,1};
    int b[8] = {3,6,2,4,2,3,1,5};
    int c[8];
    for(int i=0;i<8;i++) c[i]=a[i]<<b[i];
}
extern "C" void Shift_ASM_();
extern "C" void Shift_SIMD_();

void mult(){
    int a[8] = {4,2,5,8,6,3,7,1};
    int b[8] = {3,6,2,4,2,3,1,5};
    int c[8];
    for(int i=0;i<8;i++) c[i]=a[i]*b[i];
}
extern "C" void Mult_ASM_();
extern "C" void Mult_SIMD_();


int main(){
    cout << " Prog  |  C++  |  ASM  |  SIMD\n";
    cout << "------------------------------\n";
    cout << "Add:   |";
    compare(add,Add_ASM_,Add_SIMD_);
    cout << "Shift: |";
    compare(shift,Shift_ASM_,Shift_SIMD_);
    cout << "Mult:  |";//TODO
    compare(mult,Mult_ASM_,Mult_SIMD_);

    return 0;
}
