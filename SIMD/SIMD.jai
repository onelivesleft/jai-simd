Vec128 :: struct {
    union {
        bytes   : [16] u8;
        words   : [8] u16;
        doubles : [4] u32;
        quads   : [2] u64;
    }
}


vec128 :: inline (data : *void) -> Vec128 {
    result : Vec128;
    memcpy(*result, data, 16);
    return result;
}


vec128 :: (array : [16] u8) -> Vec128
{
    return vec128(array.data);
}

vec128 :: (array : [8] u16) -> Vec128
{
    return vec128(array.data);
}

vec128 :: (array : [4] u32) -> Vec128
{
    return vec128(array.data);
}

vec128 :: (array : [2] u64) -> Vec128
{
    return vec128(array.data);
}
