#include <iostream>
#include <iomanip>
#include <random>
#include <chrono>
using namespace std;

template <typename Func>
auto time(Func func){
    auto start = std::chrono::steady_clock::now();
    func();
    auto end = std::chrono::steady_clock::now();
    return std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
}
template <typename Func>
void compare(Func cpp, Func assembly, Func simd){
    cout << "C++: " << time(cpp) << '\n';
    cout << "ASM: " << time(cpp) << '\n';
    cout << "SIMD: " << time(cpp) << '\n';
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

int main(){
    compare(add,Add_ASM_,Add_SIMD_);

    return 0;
}
