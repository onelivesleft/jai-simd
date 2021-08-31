#import "Basic";
#import "SIMD";

main :: () {
    a := vec128(cast(u16) (0x1234));
    b := vec128(cast(u8) 1);

    //a = vec128(u16.[0x1111, 0x1111, 0x1111, 0x1111, 0x1111, 0x1111, 0x1111, 0x1111]);
    //b = vec128(u16.[0x2222, 0x2222, 0x2222, 0x2222, 0x2222, 0x2222, 0x2222, 0x2222]);

    print("%\n", a);
    print("%\n", b);

    simd_add(a, b);
    simd_calculate();

    print("%\n", a);
}
