# jai-simd

Perform SIMD calculations without learning x64 assembly.  To use download and copy the `SIMD` folder into your jai modules folder (or symlink it: `mklink /d c:\jai\modules\SIMD c:\repos\jai-simd\SIMD`).

To SIMD your code, create some `Vec128`s with your data, call the relevant SIMD procedures, then `calculate()`.  Any vecs which you have placed in the dest parameter (the first parameter) will be written to.

```jai
#import "SIMD";

main :: () {
    // 
}
