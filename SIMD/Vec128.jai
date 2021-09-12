Vec128_Pointer :: struct(operation_type: Type) {
    data : *void;
    type :: operation_type;
    is_pointer :: true;
}


vec128_pointer :: inline (data: *void, $type: Type = void) -> Vec128_Pointer(type) {
    result : Vec128_Pointer(type) = ---;
    result.data = data;
    return result;
}


Vec128 :: struct(operation_type: Type) {
    low : *void; // low+high exist out here so that printing the struct has decent output
    high : *void;
    #place low;
    union {
        u8s     : [16] u8;
        u16s    : [8] u16;
        u32s    : [4] u32;
        u64s    : [2] u64;
        s8s     : [16] s8;
        s16s    : [8] s16;
        s32s    : [4] s32;
        s64s    : [2] s64;
        float32s: [4] float32;
        float64s: [4] float64;
    }
    type :: operation_type;
    is_pointer :: false;
}


vec128 :: inline (vec128_pointer: Vec128_Pointer($T)) -> Vec128(T) {
    return vec128(vec128_pointer.data, T);
}


vec128 :: inline (data: *void, $type : Type = void) -> Vec128(type) {
    result : Vec128(type) = ---;
    memcpy(*result, data, 16);
    return result;
}


vec128 :: (str: string, offset: int) -> Vec128(u8), truncated: bool {
    assert(offset >= 0);

    if offset > str.count - 16 {
        v128 : Vec128(u8) = ---;
        zero_count := (offset - (str.count - 16));
        good_count := 16 - zero_count;
        memcpy(*v128, str.data + offset, good_count);
        memset(*v128.u8s[good_count], 0, zero_count);
        return v128, true;
    }
    else
        return vec128(str.data + offset, u8), false;
}


to_string :: (v128: *Vec128) -> string {
    result : string = ---;
    result.data = cast(*u8) v128;
    result.count = 16;
    for < i: 15 .. 0 {
        if v128.u8s[i] == 0  result.count -= 1;
        else  return result;
    }
    return "";
}


Vec128_Iterator :: struct(array_count: int, operation_type: Type) {
    #if array_count == 1 {
        data : *void;
    }
    else #if array_count == 2 {
        a : *void;
        b : *void;
    }
    else #if array_count == 3 {
        a : *void;
        b : *void;
        c : *void;
    }
    else #if array_count == 4 {
        a : *void;
        b : *void;
        c : *void;
        d : *void;
    }
    count : int;
    type :: operation_type;
}


by_vec128 :: (str: string) -> Vec128_Iterator(1, u8) {
    result : Vec128_Iterator(1, u8) = ---;
    result.data = str.data;
    result.count = str.count;
    return result;
}


by_vec128 :: (array: [] $T) -> Vec128_Iterator(1, T)
#modify {
    if T.type == .INTEGER  return;
    if T.type == .FLOAT    return;
    T = null;
} {
    result : Vec128_Iterator(1, T) = ---;
    result.data = array.data;
    result.count = array.count;
    return result;
}


by_vec128 :: (a: [] $T, b: [] $U) -> Vec128_Iterator(2, T)
#modify {
    if T.type == .INTEGER  return;
    if T.type == .FLOAT    return;
    T = null;
    if U.type == .INTEGER  return;
    if U.type == .FLOAT    return;
    U = null;
} {
    assert(b.count >= a.count, "The second array must be at least as long as the first.");
    result : Vec128_Iterator(2, T) = ---;
    result.a = a.data;
    result.b = b.data;
    result.count = a.count;
    return result;
}


by_vec128 :: (a: [] $T, b: [] $U, c: [] $V) -> Vec128_Iterator(3, T)
#modify {
    if T.type == .INTEGER  return;
    if T.type == .FLOAT    return;
    T = null;
    if U.type == .INTEGER  return;
    if U.type == .FLOAT    return;
    U = null;
    if V.type == .INTEGER  return;
    if V.type == .FLOAT    return;
    V = null;
} {
    assert(b.count >= a.count, "The second array must be at least as long as the first.");
    assert(c.count >= a.count, "The third array must be at least as long as the first.");
    result : Vec128_Iterator(3, T) = ---;
    result.a = a.data;
    result.b = b.data;
    result.c = c.data;
    result.count = a.count;
    return result;
}


by_vec128 :: (a: [] $T, b: [] $U, c: [] $V, d: [] $W) -> Vec128_Iterator(4, T)
#modify {
    if T.type == .INTEGER  return;
    if T.type == .FLOAT    return;
    T = null;
    if U.type == .INTEGER  return;
    if U.type == .FLOAT    return;
    U = null;
    if V.type == .INTEGER  return;
    if V.type == .FLOAT    return;
    V = null;
    if W.type == .INTEGER  return;
    if W.type == .FLOAT    return;
    W = null;
} {
    assert(b.count >= a.count, "The second array must be at least as long as the first.");
    assert(c.count >= a.count, "The third array must be at least as long as the first.");
    assert(d.count >= a.count, "The fourth array must be at least as long as the first.");
    result : Vec128_Iterator(4, T) = ---;
    result.a = a.data;
    result.b = b.data;
    result.c = c.data;
    result.d = d.data;
    result.count = a.count;
    return result;
}


for_expansion_template :: #string __jai
for_expansion :: (vec128_iterator: *Vec128_Iterator(1, %1), body: Code, flags: For_Flags) #expand {
    assert(flags & .REVERSE == 0);

    `it_index : struct { index: int; remainder: int; };

    #if flags & .POINTER != 0 {
        `it : Vec128_Pointer(%1) = ---;

        offset := 0;
        loop_end := vec128_iterator.count - 16;
        while offset < loop_end {
            `it = vec128_pointer(vec128_iterator.data + offset, %1);
            `it_index.index = offset / size_of(%1);
            offset += 16;
            `it_index.remainder = offset / size_of(%1);
            #insert body;
        }
    }
    else {
        `it : Vec128(%1) = ---;
        `it_index := 0;

        offset := 0;
        loop_end := vec128_iterator.count - 16;
        while offset < loop_end {
            `it = vec128(vec128_iterator.data + offset, %1);
            `it_index.index = offset / size_of(%1);
            offset += 16;
            `it_index.remainder = offset / size_of(%1);
            #insert body;
        }
    }
}

for_expansion :: (vec128_iterator: *Vec128_Iterator(2, %1), body: Code, flags: For_Flags) #expand {
    assert(flags & .REVERSE == 0);

    `it_index : struct { index: int; remainder: int; } = ---;

    #if flags & .POINTER != 0 {
        `it : struct { a : Vec128_Pointer(%1); b : Vec128_Pointer(%1); } = ---;

        offset := 0;
        loop_end := vec128_iterator.count - 16;
        while offset < loop_end {
            `it.a = vec128_pointer(vec128_iterator.a + offset, %1);
            `it.b = vec128_pointer(vec128_iterator.b + offset, %1);
            `it_index.index = offset / size_of(%1);
            offset += 16;
            `it_index.remainder = offset / size_of(%1);
            #insert body;
        }
    }
    else {
        `it : struct { a : Vec128(%1); b : Vec128(%1); } = ---;

        offset := 0;
        loop_end := vec128_iterator.count - 16;
        while offset < loop_end {
            `it.a = vec128(vec128_iterator.a + offset, %1);
            `it.b = vec128(vec128_iterator.b + offset, %1);
            `it_index.index = offset / size_of(%1);
            offset += 16;
            `it_index.remainder = offset / size_of(%1);
            #insert body;
        }
    }
}


for_expansion :: (vec128_iterator: *Vec128_Iterator(3, %1), body: Code, flags: For_Flags) #expand {
    assert(flags & .REVERSE == 0);

    `it_index : struct { index: int; remainder: int; } = ---;

    #if flags & .POINTER != 0 {
        `it : struct { a : Vec128_Pointer(%1); b : Vec128_Pointer(%1); c : Vec128_Pointer(%1); } = ---;

        offset := 0;
        loop_end := vec128_iterator.count - 16;
        while offset < loop_end {
            `it.a = vec128_pointer(vec128_iterator.a + offset, %1);
            `it.b = vec128_pointer(vec128_iterator.b + offset, %1);
            `it.c = vec128_pointer(vec128_iterator.c + offset, %1);
            `it_index.index = offset / size_of(%1);
            offset += 16;
            `it_index.remainder = offset / size_of(%1);
            #insert body;
        }
    }
    else {
        `it : struct { a : Vec128(%1); b : Vec128(%1); c : Vec128(%1); } = ---;

        offset := 0;
        loop_end := vec128_iterator.count - 16;
        while offset < loop_end {
            `it.a = vec128(vec128_iterator.a + offset, %1);
            `it.b = vec128(vec128_iterator.b + offset, %1);
            `it.c = vec128(vec128_iterator.c + offset, %1);
            `it_index.index = offset / size_of(%1);
            offset += 16;
            `it_index.remainder = offset / size_of(%1);
            #insert body;
        }
    }
}

for_expansion :: (vec128_iterator: *Vec128_Iterator(4, %1), body: Code, flags: For_Flags) #expand {
    assert(flags & .REVERSE == 0);

    `it_index : struct { index: int; remainder: int; } = ---;

    #if flags & .POINTER != 0 {
        `it : struct { a : Vec128_Pointer(%1); b : Vec128_Pointer(%1);
                       c : Vec128_Pointer(%1); d : Vec128_Pointer(%1); } = ---;

        offset := 0;
        loop_end := vec128_iterator.count - 16;
        while offset < loop_end {
            `it.a = vec128_pointer(vec128_iterator.a + offset, %1);
            `it.b = vec128_pointer(vec128_iterator.b + offset, %1);
            `it.c = vec128_pointer(vec128_iterator.c + offset, %1);
            `it.d = vec128_pointer(vec128_iterator.d + offset, %1);
            `it_index.index = offset / size_of(%1);
            offset += 16;
            `it_index.remainder = offset / size_of(%1);
            #insert body;
        }
    }
    else {
        `it : struct { a : Vec128(%1); b : Vec128(%1);
                       c : Vec128(%1); d : Vec128(%1); } = ---;

        offset := 0;
        loop_end := vec128_iterator.count - 16;
        while offset < loop_end {
            `it.a = vec128(vec128_iterator.a + offset, %1);
            `it.b = vec128(vec128_iterator.b + offset, %1);
            `it.c = vec128(vec128_iterator.c + offset, %1);
            `it.d = vec128(vec128_iterator.d + offset, %1);
            `it_index.index = offset / size_of(%1);
            offset += 16;
            `it_index.remainder = offset / size_of(%1);
            #insert body;
        }
    }
}
__jai;

#insert #run sprint(for_expansion_template, "u8");
#insert #run sprint(for_expansion_template, "u16");
#insert #run sprint(for_expansion_template, "u32");
#insert #run sprint(for_expansion_template, "u64");
#insert #run sprint(for_expansion_template, "s8");
#insert #run sprint(for_expansion_template, "s16");
#insert #run sprint(for_expansion_template, "s32");
#insert #run sprint(for_expansion_template, "s64");
#insert #run sprint(for_expansion_template, "float32");
#insert #run sprint(for_expansion_template, "float64");

operator== :: (a: Vec128, b: Vec128) -> bool {
    return a.low == b.low && a.high == b.high;
}


// This commented-out code generates the remaining constructors found below
/*

#scope_module

constructor :: #string __jai
vec128 :: (array: [%2] %1) -> Vec128(%1)
{
    return vec128(array.data, %1);
}

vec128 :: (value: %1) -> Vec128(%1)
{
    result : Vec128(%1) = ---;
    #if %2 == 16 {
        memset(*result, cast(u8)value, 16);
    }
    else #if %2 == 8 {
        for * result.u16s { <<cast(*%1)it = value; }
    }
    else #if %2 == 4 {
        for * result.u32s { <<cast(*%1)it = value; }
    }
    else #if %2 == 2 {
        for * result.u64s { <<cast(*%1)it = value; }
    }
    return result;
}
__jai

#scope_export


#insert -> string {
    builder : String_Builder;
    init_string_builder(*builder);
    defer reset(*builder);
    types :: string.["u8", "u16", "u32", "u64", "s8", "s16", "s32", "s64", "float32", "float64"];
    counts ::   int.[ 16,     8,     4,     2,   16,     8,     4,     2,         4,         2];
    for i: 0 .. types.count - 1 {
        print_to_builder(*builder, constructor, types[i], counts[i]);
        append(*builder, "\n\n");
    }
    return builder_to_string(*builder);
}

*/


// Generated:

vec128 :: (array: [16] u8) -> Vec128(u8) {
    return vec128(array.data, u8);
}

vec128 :: (value: u8) -> Vec128(u8)
{
    result : Vec128(u8) = ---;
    #if 16 == 16 {
        memset(*result, cast(u8)value, 16);
    }
    else #if 16 == 8 {
        for * result.u16s { <<cast(*u8)it = value; }
    }
    else #if 16 == 4 {
        for * result.u32s { <<cast(*u8)it = value; }
    }
    else #if 16 == 2 {
        for * result.u64s { <<cast(*u8)it = value; }
    }
    return result;
}


vec128 :: (array: [8] u16) -> Vec128(u16)
{
    return vec128(array.data, u16);
}

vec128 :: (value: u16) -> Vec128(u16)
{
    result : Vec128(u16) = ---;
    #if 8 == 16 {
        memset(*result, cast(u8)value, 16);
    }
    else #if 8 == 8 {
        for * result.u16s { <<cast(*u16)it = value; }
    }
    else #if 8 == 4 {
        for * result.u32s { <<cast(*u16)it = value; }
    }
    else #if 8 == 2 {
        for * result.u64s { <<cast(*u16)it = value; }
    }
    return result;
}


vec128 :: (array: [4] u32) -> Vec128(u32)
{
    return vec128(array.data, u32);
}

vec128 :: (value: u32) -> Vec128(u32)
{
    result : Vec128(u32) = ---;
    #if 4 == 16 {
        memset(*result, cast(u8)value, 16);
    }
    else #if 4 == 8 {
        for * result.u16s { <<cast(*u32)it = value; }
    }
    else #if 4 == 4 {
        for * result.u32s { <<cast(*u32)it = value; }
    }
    else #if 4 == 2 {
        for * result.u64s { <<cast(*u32)it = value; }
    }
    return result;
}


vec128 :: (array: [2] u64) -> Vec128(u64)
{
    return vec128(array.data, u64);
}

vec128 :: (value: u64) -> Vec128(u64)
{
    result : Vec128(u64) = ---;
    #if 2 == 16 {
        memset(*result, cast(u8)value, 16);
    }
    else #if 2 == 8 {
        for * result.u16s { <<cast(*u64)it = value; }
    }
    else #if 2 == 4 {
        for * result.u32s { <<cast(*u64)it = value; }
    }
    else #if 2 == 2 {
        for * result.u64s { <<cast(*u64)it = value; }
    }
    return result;
}


vec128 :: (array: [16] s8) -> Vec128(s8)
{
    return vec128(array.data, s8);
}

vec128 :: (value: s8) -> Vec128(s8)
{
    result : Vec128(s8) = ---;
    #if 16 == 16 {
        memset(*result, cast,no_check(u8)value, 16);
    }
    else #if 16 == 8 {
        for * result.u16s { <<cast(*s8)it = value; }
    }
    else #if 16 == 4 {
        for * result.u32s { <<cast(*s8)it = value; }
    }
    else #if 16 == 2 {
        for * result.u64s { <<cast(*s8)it = value; }
    }
    return result;
}


vec128 :: (array: [8] s16) -> Vec128(s16)
{
    return vec128(array.data, s16);
}

vec128 :: (value: s16) -> Vec128(s16)
{
    result : Vec128(s16) = ---;
    #if 8 == 16 {
        memset(*result, cast(u8)value, 16);
    }
    else #if 8 == 8 {
        for * result.u16s { <<cast(*s16)it = value; }
    }
    else #if 8 == 4 {
        for * result.u32s { <<cast(*s16)it = value; }
    }
    else #if 8 == 2 {
        for * result.u64s { <<cast(*s16)it = value; }
    }
    return result;
}


vec128 :: (array: [4] s32) -> Vec128(s32)
{
    return vec128(array.data, s32);
}

vec128 :: (value: s32) -> Vec128(s32)
{
    result : Vec128(s32) = ---;
    #if 4 == 16 {
        memset(*result, cast(u8)value, 16);
    }
    else #if 4 == 8 {
        for * result.u16s { <<cast(*s32)it = value; }
    }
    else #if 4 == 4 {
        for * result.u32s { <<cast(*s32)it = value; }
    }
    else #if 4 == 2 {
        for * result.u64s { <<cast(*s32)it = value; }
    }
    return result;
}


vec128 :: (array: [2] s64) -> Vec128(s64)
{
    return vec128(array.data, s64);
}

vec128 :: (value: s64) -> Vec128(s64)
{
    result : Vec128(s64) = ---;
    #if 2 == 16 {
        memset(*result, cast(u8)value, 16);
    }
    else #if 2 == 8 {
        for * result.u16s { <<cast(*s64)it = value; }
    }
    else #if 2 == 4 {
        for * result.u32s { <<cast(*s64)it = value; }
    }
    else #if 2 == 2 {
        for * result.u64s { <<cast(*s64)it = value; }
    }
    return result;
}


vec128 :: (array: [4] float32) -> Vec128(float32)
{
    return vec128(array.data, float32);
}

vec128 :: (value: float32) -> Vec128(float32)
{
    result : Vec128(float32) = ---;
    #if 4 == 16 {
        memset(*result, cast(u8)value, 16);
    }
    else #if 4 == 8 {
        for * result.u16s { <<cast(*float32)it = value; }
    }
    else #if 4 == 4 {
        for * result.u32s { <<cast(*float32)it = value; }
    }
    else #if 4 == 2 {
        for * result.u64s { <<cast(*float32)it = value; }
    }
    return result;
}


vec128 :: (array: [2] float64) -> Vec128(float64)
{
    return vec128(array.data, float64);
}

vec128 :: (value: float64) -> Vec128(float64)
{
    result : Vec128(float64) = ---;
    #if 2 == 16 {
        memset(*result, cast(u8)value, 16);
    }
    else #if 2 == 8 {
        for * result.u16s { <<cast(*float64)it = value; }
    }
    else #if 2 == 4 {
        for * result.u32s { <<cast(*float64)it = value; }
    }
    else #if 2 == 2 {
        for * result.u64s { <<cast(*float64)it = value; }
    }
    return result;
}
