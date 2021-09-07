
    add(result_u8,  vec128_u8);
    add(result_u16, vec128_u16);
    add(result_u32, vec128_u32);
    add(result_u64, vec128_u64);
    calculate();

    test(11, same(result_u8)  * result_u8.u8s[0],    u8_value * 2);
    test(12, same(result_u16) * result_u16.u16s[0], u16_value * 2);
    test(13, same(result_u32) * result_u32.u32s[0], u32_value * 2);
    test(14, same(result_u64) * result_u64.u64s[0], u64_value * 2);

    add(result_s8,  vec128_s8);
    add(result_s16, vec128_s16);
    add(result_s64, vec128_s64);
    add(result_s32, vec128_s32);
    calculate();

    test(15, same(result_s8)  * result_s8.s8s[0],    s8_value * 2);
    test(16, same(result_s16) * result_s16.s16s[0], s16_value * 2);
    test(17, same(result_s32) * result_s32.s32s[0], s32_value * 2);
    test(18, same(result_s64) * result_s64.s64s[0], s64_value * 2);

    add(result_float32, vec128_float32);
    add(result_float64, vec128_float64);
    calculate();

    test(19, same(result_float32) * result_float32.float32s[0], float32_value * 2);
    test(20, same(result_float64) * result_float64.float64s[0], float64_value * 2);


    subtract(result_u8,  vec128_u8);
    subtract(result_u16, vec128_u16);
    subtract(result_u32, vec128_u32);
    subtract(result_u64, vec128_u64);
    calculate();

    test(21, same(result_u8)  * result_u8.u8s[0],    u8_value);
    test(22, same(result_u16) * result_u16.u16s[0], u16_value);
    test(23, same(result_u32) * result_u32.u32s[0], u32_value);
    test(24, same(result_u64) * result_u64.u64s[0], u64_value);

    subtract(result_s8,  vec128_s8);
    subtract(result_s16, vec128_s16);
    subtract(result_s32, vec128_s32);
    subtract(result_s64, vec128_s64);
    calculate();

    test(25, same(result_s8)  * result_s8.s8s[0],    s8_value);
    test(26, same(result_s16) * result_s16.s16s[0], s16_value);
    test(27, same(result_s32) * result_s32.s32s[0], s32_value);
    test(28, same(result_s64) * result_s64.s64s[0], s64_value);

    subtract(result_float32, vec128_float32);
    subtract(result_float64, vec128_float64);
    calculate();

    test(29, same(result_float32) * result_float32.float32s[0], float32_value);
    test(30, same(result_float64) * result_float64.float64s[0], float64_value);

    full := vec128(cast(u8)0xFF);

    and(result_u8,  full);
    and(result_u16, full);
    and(result_u32, full);
    and(result_u64, full);
    calculate();

    test(31, same(result_u8)  * result_u8.u8s[0],    u8_value);
    test(32, same(result_u16) * result_u16.u16s[0], u16_value);
    test(33, same(result_u32) * result_u32.u32s[0], u32_value);
    test(34, same(result_u64) * result_u64.u64s[0], u64_value);

    and(result_s8,  full);
    and(result_s16, full);
    and(result_s32, full);
    and(result_s64, full);
    calculate();

    test(35, same(result_s8)  * result_s8.s8s[0],    s8_value);
    test(36, same(result_s16) * result_s16.s16s[0], s16_value);
    test(37, same(result_s32) * result_s32.s32s[0], s32_value);
    test(38, same(result_s64) * result_s64.s64s[0], s64_value);

    and(result_float32, full);
    and(result_float64, full);
    calculate();

    test(39, same(result_float32) * result_float32.float32s[0], float32_value);
    test(40, same(result_float64) * result_float64.float64s[0], float64_value);

    zero := vec128(cast(u8)0x00);

    and(result_u8,  zero);
    and(result_u16, zero);
    and(result_u32, zero);
    and(result_u64, zero);
    calculate();

    test(41, same(result_u8)  * result_u8.u8s[0],   0);
    test(42, same(result_u16) * result_u16.u16s[0], 0);
    test(43, same(result_u32) * result_u32.u32s[0], 0);
    test(44, same(result_u64) * result_u64.u64s[0], 0);

    and(result_s8,  zero);
    and(result_s16, zero);
    and(result_s32, zero);
    and(result_s64, zero);
    calculate();

    test(45, same(result_s8)  * result_s8.s8s[0],   0);
    test(46, same(result_s16) * result_s16.s16s[0], 0);
    test(47, same(result_s32) * result_s32.s32s[0], 0);
    test(48, same(result_s64) * result_s64.s64s[0], 0);

    and(result_float32, zero);
    and(result_float64, zero);
    calculate();

    test(49, same(result_float32) * result_float32.float32s[0], 0);
    test(50, same(result_float64) * result_float64.float64s[0], 0);

    or(result_u8,  vec128_u8);
    or(result_u16, vec128_u16);
    or(result_u32, vec128_u32);
    or(result_u64, vec128_u64);
    calculate();

    test(51, same(result_u8)  * result_u8.u8s[0],    u8_value);
    test(52, same(result_u16) * result_u16.u16s[0], u16_value);
    test(53, same(result_u32) * result_u32.u32s[0], u32_value);
    test(54, same(result_u64) * result_u64.u64s[0], u64_value);

    or(result_s8,  vec128_s8);
    or(result_s16, vec128_s16);
    or(result_s32, vec128_s32);
    or(result_s64, vec128_s64);
    calculate();

    test(55, same(result_s8)  * result_s8.s8s[0],    s8_value);
    test(56, same(result_s16) * result_s16.s16s[0], s16_value);
    test(57, same(result_s32) * result_s32.s32s[0], s32_value);
    test(58, same(result_s64) * result_s64.s64s[0], s64_value);

    or(result_float32, vec128_float32);
    or(result_float64, vec128_float64);
    calculate();

    test(59, same(result_float32) * result_float32.float32s[0], float32_value);
    test(60, same(result_float64) * result_float64.float64s[0], float64_value);
