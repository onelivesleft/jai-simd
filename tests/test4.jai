#import "Basic";
#import "SIMD";

main :: () {
    docs :: #string __txt
Perform SIMD calculations without learning x64 assembly.
To use download and copy the `SIMD` folder into your jai modules
folder.
__txt;

    text := copy_string(docs);
    to_erase := vec128(cast(u8) #char "e");
    scratch := to_erase;

    remainder := 0;
    for * by_vec128(text) {
        copy(scratch, it);
        equal(scratch, to_erase);
        and_not(scratch, it);
        copy(it, scratch);
        calculate();
        remainder = it_index.remainder;
    }

    for remainder .. text.count - 1
        if text[it] == #char "e"
            text[it] = 0;

    print("%\n", text);
}
