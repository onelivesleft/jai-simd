#import "Basic";
#import "SIMD";

main :: () {
    a := vec128(u16.[0x1111, 0x1111, 0x1111, 0x1111, 0x1111, 0x1111, 0x1111, 0x1111]);
    //b := a;
    b := vec128(u16.[0x2222, 0x2222, 0x2222, 0x2222, 0x2222, 0x2222, 0x2222, 0x2222]);

    expected := vec128(u16.[0x1335, 0x1335, 0x1335, 0x1335, 0x1335, 0x1335, 0x1335, 0x1335]);


    print("%\n", a);
    print("%\n", b);

#if true {
    add(a, b);
    calculate();
}
else {
    a_ptr := *a;
    b_ptr := *b;

    #asm {
        movdqu.x a_gpr:, [a_ptr];
        movdqu.x b_gpr:, [b_ptr];
        andps.x a_gpr, b_gpr;
        movdqu.x [a_ptr], a_gpr;
    }
}

    print("%\n\n", a);
    print("% %\n", a == expected, b != expected);
}
