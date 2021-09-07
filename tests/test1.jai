#import "Basic";
#import "SIMD";


main :: () {
    //v128 := vec128(u8.[0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F]);
    v128 := vec128(cast(u8)0xFF);
    print("%\n", v128);
    print("%\n\n", v128.u8s);
    //print("%\n", to_string(v128));



    v128a := vec128(u8.[0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]);
    print("%\n", v128a.u8s);
    s := to_string(*v128a);
    print("%\n", s);

    v128_u16 := vec128(u16.[0x1111, 0x2222, 0x3333, 0x4444, 0x5555, 0x6666, 0x7777, 0x8888]);
    print("%\n", v128_u16.u16s);

    v128_a := vec128(u32.[0x99999999, 0xAAAAAAAA, 0xBBBBBBBB, 0xCCCCCCCC]);
    print("%\n", v128_a.u32s);

    v128_b := vec128(u64.[0xDDDDDDDDDDDDDDDD, 0xEEEEEEEEEEEEEEEE]);
    print("%\n", v128_b.u64s);

    foo :: "How long have I studied?  How many times have I read the same books, over and over?  Were I to free us, I would be the most knowledgeable man in England, at least about the contents of my own library, but it is a farce.  I have found nothing!";
    offset := 0;
    truncated: bool = false;
    while offset < foo.count {
        defer offset += 16;

        v128_s, truncated := vec128(foo, offset);
        print("% %\n", to_string(*v128_s), truncated);
    }

    for vec128(foo)
        print("% %\n", to_string(*it), it_index);

    print("THE END\n");
}
