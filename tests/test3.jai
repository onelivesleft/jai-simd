#import "Basic";
#import "SIMD";

main :: () {
    foo := u16.[10, 20, 30, 40, 50, 60, 70, 80, 90,
                10, 20, 30, 40, 50, 60, 70, 80, 90,
                10, 20, 30, 40, 50, 60, 70, 80, 90,
                10, 20, 30, 40, 50, 60, 70, 80, 90];

    bar := u16.[1, 2, 3, 4, 5, 6, 7, 8, 9,
                1, 2, 3, 4, 5, 6, 7, 8, 9,
                1, 2, 3, 4, 5, 6, 7, 8, 9,
                1, 2, 3, 4, 5, 6, 7, 8, 9];

    baz := u16.[2, 1, 2, 1, 2, 1, 2, 1, 2,
                2, 1, 2, 1, 2, 1, 2, 1, 2,
                2, 1, 2, 1, 2, 1, 2, 1, 2,
                2, 1, 2, 1, 2, 1, 2, 1, 2];

    total : [foo.count] u16 = ---;

    remainder := 0;
    for * by_vec128(total, foo, bar, baz) {
        and_not(it.a, it.a); // zero the destination
        add(it.a, it.b);
        add(it.a, it.c);
        multiply(it.a, it.d);
        calculate();
        remainder = it_index.remainder;
    }

    for remainder .. total.count - 1
        total[it] = (foo[it] + bar[it]) * baz[it];

    print("%\n\n", total);
}
