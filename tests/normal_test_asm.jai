#import "Basic";
#import "SIMD";
math :: #import "Math";


errors_only :: false;


main :: () {
    u8_value  :: cast(u8)0x08;
    u16_value :: cast(u16)0x1010;
    u32_value :: cast(u32)0x20202020;
    u64_value :: cast(u64)0x4040404040404040;

    s8_value  :: cast(s8)(-8);
    s16_value :: cast(s16)(-4112);
    s32_value :: cast(s32)(-538976288);
    s64_value :: cast(s64)(0xF4F4F4F4F4F4F4F4);

    float32_value :: cast(float32)(math.PI * 32);
    float64_value :: cast(float64)(math.PI * 64);

    vec128_u8  := vec128(u8_value);   test(1, vec128_u8.type,  u8);
    vec128_u16 := vec128(u16_value);  test(2, vec128_u16.type, u16);
    vec128_u32 := vec128(u32_value);  test(3, vec128_u32.type, u32);
    vec128_u64 := vec128(u64_value);  test(4, vec128_u64.type, u64);

    vec128_s8  := vec128(s8_value);   test(5, vec128_s8.type,  s8);
    vec128_s16 := vec128(s16_value);  test(6, vec128_s16.type, s16);
    vec128_s32 := vec128(s32_value);  test(7, vec128_s32.type, s32);
    vec128_s64 := vec128(s64_value);  test(8, vec128_s64.type, s64);

    //@TODO when compiler fixed use repeating version
    vec128_float32 := vec128(float32.[float32_value, float32_value, float32_value, float32_value]);
    test(9,  vec128_float32.type, float32);

    vec128_float64 := vec128(float64.[float64_value, float64_value]);
    test(10, vec128_float64.type, float64);

    result_u8 :=  vec128_u8;
    result_u16 := vec128_u16;
    result_u32 := vec128_u32;
    result_u64 := vec128_u64;

    result_s8 :=  vec128_s8;
    result_s16 := vec128_s16;
    result_s32 := vec128_s32;
    result_s64 := vec128_s64;

    result_float32 := vec128_float32;
    result_float64 := vec128_float64;


() -> () #expand {
result_u8__simd_ptr : *void = *`result_u8;
vec128_u8__simd_ptr : *void = *`vec128_u8;
result_u16__simd_ptr : *void = *`result_u16;
vec128_u16__simd_ptr : *void = *`vec128_u16;
result_u32__simd_ptr : *void = *`result_u32;
vec128_u32__simd_ptr : *void = *`vec128_u32;
result_u64__simd_ptr : *void = *`result_u64;
vec128_u64__simd_ptr : *void = *`vec128_u64;

#asm{
movdqu.x result_u8__simd:, [result_u8__simd_ptr];
movdqu.x vec128_u8__simd:, [vec128_u8__simd_ptr];
paddb.x result_u8__simd, vec128_u8__simd;
movdqu.x result_u16__simd:, [result_u16__simd_ptr];
movdqu.x vec128_u16__simd:, [vec128_u16__simd_ptr];
paddw.x result_u16__simd, vec128_u16__simd;
movdqu.x result_u32__simd:, [result_u32__simd_ptr];
movdqu.x vec128_u32__simd:, [vec128_u32__simd_ptr];
paddd.x result_u32__simd, vec128_u32__simd;
movdqu.x result_u64__simd:, [result_u64__simd_ptr];
movdqu.x vec128_u64__simd:, [vec128_u64__simd_ptr];
paddq.x result_u64__simd, vec128_u64__simd;
movdqu.x [result_u8__simd_ptr], result_u8__simd;
movdqu.x [result_u16__simd_ptr], result_u16__simd;
movdqu.x [result_u32__simd_ptr], result_u32__simd;
movdqu.x [result_u64__simd_ptr], result_u64__simd;
}
}();

    test(11, same(result_u8) * result_u8.u8s[0],    u8_value * 2);
    test(12, same(result_u16) * result_u16.u16s[0], u16_value * 2);
    test(13, same(result_u32) * result_u32.u32s[0], u32_value * 2);
    test(14, same(result_u64) * result_u64.u64s[0], u64_value * 2);

() -> () #expand {
result_s8__simd_ptr : *void = *`result_s8;
vec128_s8__simd_ptr : *void = *`vec128_s8;
result_s16__simd_ptr : *void = *`result_s16;
vec128_s16__simd_ptr : *void = *`vec128_s16;
result_s64__simd_ptr : *void = *`result_s64;
vec128_s64__simd_ptr : *void = *`vec128_s64;
result_s32__simd_ptr : *void = *`result_s32;
vec128_s32__simd_ptr : *void = *`vec128_s32;

#asm{
movdqu.x result_s8__simd:, [result_s8__simd_ptr];
movdqu.x vec128_s8__simd:, [vec128_s8__simd_ptr];
paddb.x result_s8__simd, vec128_s8__simd;
movdqu.x result_s16__simd:, [result_s16__simd_ptr];
movdqu.x vec128_s16__simd:, [vec128_s16__simd_ptr];
paddw.x result_s16__simd, vec128_s16__simd;
movdqu.x result_s64__simd:, [result_s64__simd_ptr];
movdqu.x vec128_s64__simd:, [vec128_s64__simd_ptr];
paddq.x result_s64__simd, vec128_s64__simd;
movdqu.x result_s32__simd:, [result_s32__simd_ptr];
movdqu.x vec128_s32__simd:, [vec128_s32__simd_ptr];
paddd.x result_s32__simd, vec128_s32__simd;
movdqu.x [result_s8__simd_ptr], result_s8__simd;
movdqu.x [result_s16__simd_ptr], result_s16__simd;
movdqu.x [result_s64__simd_ptr], result_s64__simd;
movdqu.x [result_s32__simd_ptr], result_s32__simd;
}
}();

    test(15, same(result_s8) * result_s8.s8s[0],    s8_value * 2);
    test(16, same(result_s16) * result_s16.s16s[0], s16_value * 2);
    test(17, same(result_s32) * result_s32.s32s[0], s32_value * 2);
    test(18, same(result_s64) * result_s64.s64s[0], s64_value * 2);

() -> () #expand {
result_float32__simd_ptr : *void = *`result_float32;
vec128_float32__simd_ptr : *void = *`vec128_float32;
result_float64__simd_ptr : *void = *`result_float64;
vec128_float64__simd_ptr : *void = *`vec128_float64;

#asm{
movdqu.x result_float32__simd:, [result_float32__simd_ptr];
movdqu.x vec128_float32__simd:, [vec128_float32__simd_ptr];
addps.x result_float32__simd, vec128_float32__simd;
movdqu.x result_float64__simd:, [result_float64__simd_ptr];
movdqu.x vec128_float64__simd:, [vec128_float64__simd_ptr];
addpd.x result_float64__simd, vec128_float64__simd;
movdqu.x [result_float32__simd_ptr], result_float32__simd;
movdqu.x [result_float64__simd_ptr], result_float64__simd;
}
}();

    test(19, same(result_float32) * result_float32.float32s[0], float32_value * 2);
    test(20, same(result_float64) * result_float64.float64s[0], float64_value * 2);


() -> () #expand {
result_u8__simd_ptr : *void = *`result_u8;
vec128_u8__simd_ptr : *void = *`vec128_u8;
result_u16__simd_ptr : *void = *`result_u16;
vec128_u16__simd_ptr : *void = *`vec128_u16;
result_u32__simd_ptr : *void = *`result_u32;
vec128_u32__simd_ptr : *void = *`vec128_u32;
result_u64__simd_ptr : *void = *`result_u64;
vec128_u64__simd_ptr : *void = *`vec128_u64;

#asm{
movdqu.x result_u8__simd:, [result_u8__simd_ptr];
movdqu.x vec128_u8__simd:, [vec128_u8__simd_ptr];
psubb.x result_u8__simd, vec128_u8__simd;
movdqu.x result_u16__simd:, [result_u16__simd_ptr];
movdqu.x vec128_u16__simd:, [vec128_u16__simd_ptr];
psubw.x result_u16__simd, vec128_u16__simd;
movdqu.x result_u32__simd:, [result_u32__simd_ptr];
movdqu.x vec128_u32__simd:, [vec128_u32__simd_ptr];
psubd.x result_u32__simd, vec128_u32__simd;
movdqu.x result_u64__simd:, [result_u64__simd_ptr];
movdqu.x vec128_u64__simd:, [vec128_u64__simd_ptr];
psubq.x result_u64__simd, vec128_u64__simd;
movdqu.x [result_u8__simd_ptr], result_u8__simd;
movdqu.x [result_u16__simd_ptr], result_u16__simd;
movdqu.x [result_u32__simd_ptr], result_u32__simd;
movdqu.x [result_u64__simd_ptr], result_u64__simd;
}
}();

    test(21, same(result_u8) * result_u8.u8s[0],    u8_value);
    test(22, same(result_u16) * result_u16.u16s[0], u16_value);
    test(23, same(result_u32) * result_u32.u32s[0], u32_value);
    test(24, same(result_u64) * result_u64.u64s[0], u64_value);

() -> () #expand {
result_s8__simd_ptr : *void = *`result_s8;
vec128_s8__simd_ptr : *void = *`vec128_s8;
result_s16__simd_ptr : *void = *`result_s16;
vec128_s16__simd_ptr : *void = *`vec128_s16;
result_s64__simd_ptr : *void = *`result_s64;
vec128_s64__simd_ptr : *void = *`vec128_s64;
result_s32__simd_ptr : *void = *`result_s32;
vec128_s32__simd_ptr : *void = *`vec128_s32;
#asm{
movdqu.x result_s8__simd:, [result_s8__simd_ptr];
movdqu.x vec128_s8__simd:, [vec128_s8__simd_ptr];
paddb.x result_s8__simd, vec128_s8__simd;
movdqu.x result_s16__simd:, [result_s16__simd_ptr];
movdqu.x vec128_s16__simd:, [vec128_s16__simd_ptr];
paddw.x result_s16__simd, vec128_s16__simd;
movdqu.x result_s64__simd:, [result_s64__simd_ptr];
movdqu.x vec128_s64__simd:, [vec128_s64__simd_ptr];
paddq.x result_s64__simd, vec128_s64__simd;
movdqu.x result_s32__simd:, [result_s32__simd_ptr];
movdqu.x vec128_s32__simd:, [vec128_s32__simd_ptr];
paddd.x result_s32__simd, vec128_s32__simd;
movdqu.x [result_s8__simd_ptr], result_s8__simd;
movdqu.x [result_s16__simd_ptr], result_s16__simd;
movdqu.x [result_s64__simd_ptr], result_s64__simd;
movdqu.x [result_s32__simd_ptr], result_s32__simd;
}
}();

    test(25, same(result_s8) * result_s8.s8s[0],    s8_value);
    test(26, same(result_s16) * result_s16.s16s[0], s16_value);
    test(27, same(result_s32) * result_s32.s32s[0], s32_value);
    test(28, same(result_s64) * result_s64.s64s[0], s64_value);

() -> () #expand {
result_float32__simd_ptr : *void = *`result_float32;
vec128_float32__simd_ptr : *void = *`vec128_float32;
result_float64__simd_ptr : *void = *`result_float64;
vec128_float64__simd_ptr : *void = *`vec128_float64;

#asm{
movdqu.x result_float32__simd:, [result_float32__simd_ptr];
movdqu.x vec128_float32__simd:, [vec128_float32__simd_ptr];
subps.x result_float32__simd, vec128_float32__simd;
movdqu.x result_float64__simd:, [result_float64__simd_ptr];
movdqu.x vec128_float64__simd:, [vec128_float64__simd_ptr];
subpd.x result_float64__simd, vec128_float64__simd;
movdqu.x [result_float32__simd_ptr], result_float32__simd;
movdqu.x [result_float64__simd_ptr], result_float64__simd;
}
}();


    //test(29, same(result_float32) * result_float32.float32s[0], float32_value);
    //test(30, same(result_float64) * result_float64.float64s[0], float64_value);


    zero := vec128(cast(u8)0x00);
    full := vec128(cast(u8)0xFF);

    { // end of main
        if errors.count != 0
            print("\nErrors:\n%\n", errors);
        else
            print("\nAll OK!\n");
    }
}


errors : [..] int;

test :: (test_id: int, value: $T, expected: T) {
    if value != expected {
        print("(%)\nWanted: [%]\nGot: [%]\n\n", test_id, expected, value);
        array_add(*errors, test_id);
    }
    else if !errors_only {
        print("(%) [%] OK\n", test_id, value);
    }
}

test :: (test_id: int, value: [] string, expected: [] string) {
    if !array_equal(value, expected) {
        print("(%)\nWanted: [%]\nGot: [%]\n\n", test_id, expected, value);
        array_add(*errors, test_id);
    }
    else if !errors_only {
        print("(%) OK\n", test_id);
    }
}

same :: (v128: Vec128($T)) -> T {
    #if size_of(T) == 1
        for i: 1 .. 15  if v128.u8s[i] != v128.u8s[i - 1]  return 0;
    else #if size_of(T) == 2
        for i: 1 .. 7  if v128.u16s[i] != v128.u16s[i - 1]  return 0;
    else #if size_of(T) == 4
        for i: 1 .. 3  if v128.u32s[i] != v128.u32s[i - 1]  return 0;
    else #if size_of(T) == 8
        for i: 1 .. 1  if v128.u64s[i] != v128.u64s[i - 1]  return 0;

    return 1;
}

array_equal :: (a: [] $T, b: [] T) -> bool {
    if a.count != b.count  return false;
    for i: 0..a.count-1  if a[i] != b[i]  return false;
    return true;
}
