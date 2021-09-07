#import "Basic";
#import "Hash_Table";
#import "Math";
#import "SIMD"(testing=true);
math :: #import "Math";


errors_only :: true;


main :: () {
    u8_value  :: cast(u8)0x08;
    u16_value :: cast(u16)0x1010;
    u32_value :: cast(u32)0x20202020;
    u64_value :: cast(u64)0x3030303030303030;
    s8_value  :: cast(s8)(0x0F);
    s16_value :: cast(s16)(0x0F0F);
    s32_value :: cast(s32)(0x0F0F0F0F);
    s64_value :: cast(s64)(0x0F0F0F0F0F0F0F0F);
    float32_value :: cast(float32)(math.PI * 32);
    float64_value :: cast(float64)(math.PI * 64);

    vec128_u8  := vec128(u8_value);   test("vecu8", vec128_u8.type,  u8);
    vec128_u16 := vec128(u16_value);  test("vecu16", vec128_u16.type, u16);
    vec128_u32 := vec128(u32_value);  test("vecu32", vec128_u32.type, u32);
    vec128_u64 := vec128(u64_value);  test("vecu64", vec128_u64.type, u64);
    vec128_s8  := vec128(s8_value);   test("vecs8", vec128_s8.type,  s8);
    vec128_s16 := vec128(s16_value);  test("vecs16", vec128_s16.type, s16);
    vec128_s32 := vec128(s32_value);  test("vecs32", vec128_s32.type, s32);
    vec128_s64 := vec128(s64_value);  test("vecs64", vec128_s64.type, s64);
    vec128_float32 := vec128(float32_value);   test("vecf32",  vec128_float32.type, float32);
    vec128_float64 := vec128(float64_value);   test("vecf64", vec128_float64.type, float64);

    one_u8  := vec128(cast(u8) 1); test("oneu8", one_u8.type,  u8);
    one_u16 := vec128(cast(u16) 1); test("oneu16", one_u16.type, u16);
    one_u32 := vec128(cast(u32) 1); test("oneu32", one_u32.type, u32);
    one_u64 := vec128(cast(u64) 1); test("oneu64", one_u64.type, u64);
    one_s8  := vec128(cast(s8) 1); test("ones8", one_s8.type,  s8);
    one_s16 := vec128(cast(s16) 1); test("ones16", one_s16.type, s16);
    one_s32 := vec128(cast(s32) 1); test("ones32", one_s32.type, s32);
    one_s64 := vec128(cast(s64) 1); test("ones64", one_s64.type, s64);
    one_float32 := vec128(cast(float32) 1); test("onef32",  one_float32.type, float32);
    one_float64 := vec128(cast(float64) 1); test("onef64", one_float64.type, float64);

    two_u8  := vec128(cast(u8) 2);
    two_u16 := vec128(cast(u16) 2);
    two_u32 := vec128(cast(u32) 2);
    two_u64 := vec128(cast(u64) 2);
    two_s8  := vec128(cast(s8) 2);
    two_s16 := vec128(cast(s16) 2);
    two_s32 := vec128(cast(s32) 2);
    two_s64 := vec128(cast(s64) 2);
    two_float32 := vec128(cast(float32) 2);
    two_float64 := vec128(cast(float64) 2);

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

    reset :: () #expand {
        result_u8  = vec128_u8;
        result_u16 = vec128_u16;
        result_u32 = vec128_u32;
        result_u64 = vec128_u64;
        result_s8  = vec128_s8;
        result_s16 = vec128_s16;
        result_s32 = vec128_s32;
        result_s64 = vec128_s64;
        result_float32 = vec128_float32;
        result_float64 = vec128_float64;
    }

    #insert #run test(1, "add", "2*");
    #insert #run test(2, "subtract", "");

    full := vec128(cast(u8)0xFF);
    #insert #run test(3, "and", "", "full");

    zero := vec128(cast(u8)0x00);
    #insert #run test(4, "and", "0*", "zero");

    #insert #run test(5, "or", "");
    #insert #run test(6, "and_not", "0*", "result", true);
    #insert #run test(7, "and_not", "");

    #insert #run test(8, "equal", "fill");
    #insert #run test(9, "equal", "0*");

    #insert #run test(10, "less", "fill");
    #insert #run test(11, "less", "0*");

    #insert #run test(12, "less_or_equal", "fill");
    reset();
    #insert #run test(13, "less_or_equal", "fill");
    reset();
    #insert #run test(14, "add", "2*");
    #insert #run test(15, "less_or_equal", "0*");

    #insert #run test(17, "not_equal", "fill");
    reset();
    #insert #run test(18, "not_equal", "0*");

    #insert #run test(19, "greater_or_equal", "0*");
    reset();
    #insert #run test(20, "greater_or_equal", "fill");
    reset();
    #insert #run test(21, "add", "2*");
    #insert #run test(22, "greater_or_equal", "fill");

    reset();
    #insert #run test(23, "greater", "0*");
    #insert #run test(24, "greater", "0*");
    reset();
    #insert #run test(25, "add", "2*");
    #insert #run test(26, "greater", "fill");

    #insert #run test(27, "valid", "0*");
    #insert #run test(28, "valid", "fill");

    reset();
    #insert #run test(29, "divide", "one");
    #insert #run test(30, "nan", "0*");
    #insert #run test(31, "divide", "fill", "result", true);

    reset();
    #insert #run test(32, "add", "2*");
    #insert #run test(33, "max", "2*");

    #insert #run test(34, "min", "1*");

    reset();
    #insert #run test(35, "greater", "0*");
    #insert #run test(36, "add", "two", "two", true);
    #insert #run test(37, "multiply", "2*");

    #insert #run test(38, "copy", "1*");
    #insert #run test(39, "copy", "one", "one", true);

    #insert #run test(40, "inverse", "one", "result", true);

    #insert #run test(41, "inverse_root", "one", "result", true);

    #insert #run test(42, "root", "one", "result", true);
    

    { // end of main
        if errors.count != 0
            print("\nErrors:\n%\n", errors);
        else
            print("\nAll OK!\n");
    }
}


errors : [..] string;

test :: (test_id: string, value: $T, expected: T) {
    equal := value == expected;
    #if T == float32 || T == float64 {
        if  isnan(value) && isnan(expected)
            equal = true;
        else if abs(value - expected) < 0.001
            equal = true;
    }
    if !equal {
        #if T == u8 || T == u16 || T == u32 || T == u64
         || T == s8 || T == s16 || T == s32 || T == s64
            print("(%)\nWanted: [%]\nResult: [%]\n\n", test_id, formatInt(expected, base=16), formatInt(value, base=16));
        else
            print("(%)\nWanted: [%]\nResult: [%]\n\n", test_id, expected, value);
        array_add(*errors, test_id);
    }
    else if !errors_only {
        padding_string :: "       ";
        padding := padding_string;
        padding.count = 6 - test_id.count;
        #if T == u8 || T == u16 || T == u32 || T == u64
         || T == s8 || T == s16 || T == s32 || T == s64
            print("(%)% [%] OK\n", test_id, padding, formatInt(value, base=16));
        else
            print("(%)% [%] OK\n", test_id, padding, value);
    }
}

test :: (test_id: string, value: [] string, expected: [] string) {
    if !array_equal(value, expected) {
        print("(%)\nWanted: [%]\nResult: [%]\n\n", test_id, expected, value);
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


used_indexes : Table(int, bool);

test :: (index: int, command: string, check_prefix: string, replace_src := "", keep_src_postfix := false) -> string {
    _, found := table_find(used_indexes, index);
    assert(!found, "Remember to increment test index! %", index);
    table_set(*used_indexes, index, true);

    src_prefix := "vec128";
    if keep_src_postfix && replace_src
        src_prefix = replace_src;

    if !keep_src_postfix && replace_src
        return sprint(#string __jai
            if type_supports_instruction("%1", u8) %1(result_u8,  %4);
            if type_supports_instruction("%1", u16) %1(result_u16, %4);
            if type_supports_instruction("%1", u32) %1(result_u32, %4);
            if type_supports_instruction("%1", u64) %1(result_u64, %4);
            calculate();

            if type_supports_instruction("%1", u8) test("%3u8", same(result_u8)  * result_u8.u8s[0],   %2(u8_value));
            if type_supports_instruction("%1", u16) test("%3u16", same(result_u16) * result_u16.u16s[0], %2(u16_value));
            if type_supports_instruction("%1", u32) test("%3u32", same(result_u32) * result_u32.u32s[0], %2(u32_value));
            if type_supports_instruction("%1", u64) test("%3u64", same(result_u64) * result_u64.u64s[0], %2(u64_value));

            if type_supports_instruction("%1", s8) %1(result_s8,  %4);
            if type_supports_instruction("%1", s16) %1(result_s16, %4);
            if type_supports_instruction("%1", s32) %1(result_s32, %4);
            if type_supports_instruction("%1", s64) %1(result_s64, %4);
            calculate();

            if type_supports_instruction("%1", s8)  test("%3s8", same(result_s8)  * result_s8.s8s[0],   %2(s8_value));
            if type_supports_instruction("%1", s16) test("%3s16", same(result_s16) * result_s16.s16s[0], %2(s16_value));
            if type_supports_instruction("%1", s32) test("%3s32", same(result_s32) * result_s32.s32s[0], %2(s32_value));
            if type_supports_instruction("%1", s64) test("%3s64", same(result_s64) * result_s64.s64s[0], %2(s64_value));

            if type_supports_instruction("%1", float32) %1(result_float32, %4);
            if type_supports_instruction("%1", float64) %1(result_float64, %4);
            calculate();

            if type_supports_instruction("%1", float32) test("%3f32", same(result_float32) * result_float32.float32s[0], %2(float32_value));
            if type_supports_instruction("%1", float64) test("%3f64", same(result_float64) * result_float64.float64s[0], %2(float64_value));
        __jai, command, check_prefix, index, replace_src);
    else
        return sprint(#string __jai
            if type_supports_instruction("%1", u8) %1(result_u8,  %4_u8);
            if type_supports_instruction("%1", u16) %1(result_u16, %4_u16);
            if type_supports_instruction("%1", u32) %1(result_u32, %4_u32);
            if type_supports_instruction("%1", u64) %1(result_u64, %4_u64);
            calculate();

            if type_supports_instruction("%1", u8)  test("%3u8", same(result_u8)  * result_u8.u8s[0],   %2(u8_value));
            if type_supports_instruction("%1", u16) test("%3u16", same(result_u16) * result_u16.u16s[0], %2(u16_value));
            if type_supports_instruction("%1", u32) test("%3u32", same(result_u32) * result_u32.u32s[0], %2(u32_value));
            if type_supports_instruction("%1", u64) test("%3u64", same(result_u64) * result_u64.u64s[0], %2(u64_value));

            if type_supports_instruction("%1", s8) %1(result_s8,  %4_s8);
            if type_supports_instruction("%1", s16) %1(result_s16, %4_s16);
            if type_supports_instruction("%1", s32) %1(result_s32, %4_s32);
            if type_supports_instruction("%1", s64) %1(result_s64, %4_s64);
            calculate();

            if type_supports_instruction("%1", s8)  test("%3s8", same(result_s8)  * result_s8.s8s[0],   %2(s8_value));
            if type_supports_instruction("%1", s16) test("%3s16", same(result_s16) * result_s16.s16s[0], %2(s16_value));
            if type_supports_instruction("%1", s32) test("%3s32", same(result_s32) * result_s32.s32s[0], %2(s32_value));
            if type_supports_instruction("%1", s64) test("%3s64", same(result_s64) * result_s64.s64s[0], %2(s64_value));

            if type_supports_instruction("%1", float32) %1(result_float32, %4_float32);
            if type_supports_instruction("%1", float64) %1(result_float64, %4_float64);
            calculate();

            if type_supports_instruction("%1", float32) test("%3f32", same(result_float32) * result_float32.float32s[0], %2(float32_value));
            if type_supports_instruction("%1", float64) test("%3f64", same(result_float64) * result_float64.float64s[0], %2(float64_value));
        __jai, command, check_prefix, index, src_prefix);
}


fill :: (v : $T) -> T {
    full : u64 = 0xFFFFFFFFFFFFFFFF;
    return <<cast(*T)*full;
}

one :: (v : $T) -> T {
    uno := 1;
    return cast(T) uno;
}

two :: (v : $T) -> T {
    dos := 2;
    return cast(T) dos;
}

type_supports_instruction :: inline (name: string, type: Type) -> bool {
    return type_supports_instruction(type, name);
}
