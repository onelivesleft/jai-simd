#scope_module

operators :: Operator.[
    .{"add", "Store (dest + src) in dest.", .[
        .{u8,       "paddb.x %1, %2;" },
        .{s8,       "paddb.x %1, %2;"},
        .{u16,      "paddw.x %1, %2;"},
        .{s16,      "paddw.x %1, %2;"},
        .{u32,      "paddd.x %1, %2;"},
        .{s32,      "paddd.x %1, %2;"},
        .{u64,      "paddq.x %1, %2;"},
        .{s64,      "paddq.x %1, %2;"},
        .{float32,  "addps.x %1, %2;"},
        .{float64,  "addpd.x %1, %2;"}]},

    .{"subtract", "Store (dest - src) in dest.", .[
        .{u8,       "psubb.x %1, %2;" },
        .{s8,       "psubb.x %1, %2;"},
        .{u16,      "psubw.x %1, %2;"},
        .{s16,      "psubw.x %1, %2;"},
        .{u32,      "psubd.x %1, %2;"},
        .{s32,      "psubd.x %1, %2;"},
        .{u64,      "psubq.x %1, %2;"},
        .{s64,      "psubq.x %1, %2;"},
        .{float32,  "subps.x %1, %2;"},
        .{float64,  "subpd.x %1, %2;"}]},

    .{"multiply", "Store (dest * src) in dest.", .[
        .{u16,      "pmullw.x %1, %2;"},
        .{s16,      "pmullw.x %1, %2;"},
        .{u32,      "pmulld.x %1, %2;"},
        .{s32,      "pmulld.x %1, %2;"},
        .{float32,  "mulps.x %1, %2;"},
        .{float64,  "mulpd.x %1, %2;"}]},


    .{"divide", "Store (dest / src) in dest.", .[
        .{float32,  "divps.x %1, %2;"},
        .{float64,  "divpd.x %1, %2;"}]},

    .{"shift_left", "Set dest to (dest << src).", .[
        .{u16,      "psllw.x %1, %2;"},
        .{s16,      "psllw.x %1, %2;"},
        .{u32,      "pslld.x %1, %2;"},
        .{s32,      "pslld.x %1, %2;"},
        .{u64,      "psllq.x %1, %2;"},
        .{s64,      "psllq.x %1, %2;"},
        .{float32,  "pslld.x %1, %2;"},
        .{float64,  "psllq.x %1, %2;"}]},

    .{"shift_right", "Set dest to (dest >> src).", .[
        .{u16,      "psrlw.x %1, %2;"},
        .{s16,      "psrlw.x %1, %2;"},
        .{u32,      "psrld.x %1, %2;"},
        .{s32,      "psrld.x %1, %2;"},
        .{u64,      "psrlq.x %1, %2;"},
        .{s64,      "psrlq.x %1, %2;"},
        .{float32,  "psrld.x %1, %2;"},
        .{float64,  "psrlq.x %1, %2;"}]},

    .{"rotate_left", "Set dest to (dest <<< src).", .[
        .{u16,      "pslaw.x %1, %2;"},
        .{s16,      "pslaw.x %1, %2;"},
        .{u32,      "pslad.x %1, %2;"},
        .{s32,      "pslad.x %1, %2;"},
        .{u64,      "pslaq.x %1, %2;"},
        .{s64,      "pslaq.x %1, %2;"},
        .{float32,  "pslad.x %1, %2;"},
        .{float64,  "pslaq.x %1, %2;"}]},

    .{"rotate_right", "Set dest to (dest >>> src).", .[
        .{u16,      "psraw.x %1, %2;"},
        .{s16,      "psraw.x %1, %2;"},
        .{u32,      "psrad.x %1, %2;"},
        .{s32,      "psrad.x %1, %2;"},
        .{u64,      "psraq.x %1, %2;"},
        .{s64,      "psraq.x %1, %2;"},
        .{float32,  "psrad.x %1, %2;"},
        .{float64,  "psraq.x %1, %2;"}]},

    .{"clear", "Set dest to 0.", .[
        .{void,     "xorps.x %1, %1;"}]},

    .{"and", "Set dest to (dest & src).", .[
        .{void,     "andps.x %1, %2;"}]},

    .{"or", "Set dest to (dest | src).", .[
        .{void,     "orps.x %1, %2;" }]},

    .{"xor", "Set dest to (dest ^ src).", .[
        .{void,     "xorps.x %1, %2;" }]},

    .{"and_not", "Set dest to ((~dest) & src).", .[
        .{void,     "andnps.x %1, %2;"}]},

    .{"equal", "Set dest to ON if (dest == src), otherwise OFF.", .[
        .{u8,       "pcmpeqb.x %1, %2;"},
        .{s8,       "pcmpeqb.x %1, %2;"},
        .{u16,      "pcmpeqw.x %1, %2;"},
        .{s16,      "pcmpeqw.x %1, %2;"},
        .{u32,      "pcmpeqd.x %1, %2;"},
        .{s32,      "pcmpeqd.x %1, %2;"},
        .{u64,      "pcmpeqq.x %1, %2;"},
        .{s64,      "pcmpeqq.x %1, %2;"},
        .{float32,  "cmpps.x %1, %2, 0;"},
        .{float64,  "cmppd.x %1, %2, 0;"}]},

    .{"less", "Set dest to ON if (dest < src), otherwise OFF.", .[
        .{float32,  "cmpps.x %1, %2, 1;"},
        .{float64,  "cmppd.x %1, %2, 1;"}]},

    .{"less_or_equal", "Set dest to ON if (dest <= src), otherwise OFF.", .[
        .{float32,  "cmpps.x %1, %2, 2;"},
        .{float64,  "cmppd.x %1, %2, 2;"}]},

    .{"nan", "Set dest to ON if dest or src is NaN, otherwise OFF", .[
        .{float32,  "cmpps.x %1, %2, 3;"},
        .{float64,  "cmppd.x %1, %2, 3;"}]},

    .{"not_equal", "Set dest to ON if (dest != src), otherwise OFF.", .[
        .{float32,  "cmpps.x %1, %2, 4;"},
        .{float64,  "cmppd.x %1, %2, 4;"}]},

    .{"greater_or_equal", "Set dest to ON if (dest >= src), otherwise OFF.", .[
        .{float32,  "cmpps.x %1, %2, 5;"},
        .{float64,  "cmppd.x %1, %2, 5;"}]},

    .{"greater", "Set dest to ON if (dest > src), otherwise OFF.", .[
        .{u8,       "pcmpgtb.x %1, %2;"},
        .{s8,       "pcmpgtb.x %1, %2;"},
        .{u16,      "pcmpgtw.x %1, %2;"},
        .{s16,      "pcmpgtw.x %1, %2;"},
        .{u32,      "pcmpgtd.x %1, %2;"},
        .{s32,      "pcmpgtd.x %1, %2;"},
        .{u64,      "pcmpgtq.x %1, %2;"},
        .{s64,      "pcmpgtq.x %1, %2;"},
        .{float32,  "cmpps.x %1, %2, 6;"},
        .{float64,  "cmppd.x %1, %2, 6;"}]},

    .{"valid", "Set dest to ON if neither src nor dest is NaN, otherwise OFF.", .[
        .{float32,  "cmpps.x %1, %2, 7;"},
        .{float64,  "cmppd.x %1, %2, 7;"}]},

    .{"max", "Store max of src and dest in dest.", .[
        .{u8,       "pmaxub.x %1, %2;"},
        .{s8,       "pmaxsb.x %1, %2;"},
        .{u16,      "pmaxuw.x %1, %2;"},
        .{s16,      "pmaxsw.x %1, %2;"},
        .{u32,      "pmaxud.x %1, %2;"},
        .{s32,      "pmaxsd.x %1, %2;"},
        .{float32,  "maxps.x %1, %2;"},
        .{float64,  "maxpd.x %1, %2;"}]},

    .{"min", "Store min of src and dest in dest.", .[
        .{u8,       "pminub.x %1, %2;"},
        .{s8,       "pminsb.x %1, %2;"},
        .{u16,      "pminuw.x %1, %2;"},
        .{s16,      "pminsw.x %1, %2;"},
        .{u32,      "pminud.x %1, %2;"},
        .{s32,      "pminsd.x %1, %2;"},
        .{float32,  "minps.x %1, %2;"},
        .{float64,  "minpd.x %1, %2;"}]},

    .{"copy", "Copy src into dest.", .[
        .{void,     "movups.x %1, %2;"}]},

    .{"inverse", "Set dest to (1 / src).", .[
        .{float32,  "rcpps.x %1, %2;"}]},

    .{"inverse_root", "Set dest to (1 / sqrt(src)).", .[
        .{float32,  "rsqrtps.x %1, %2;"}]},

    .{"root", "Set dest to (sqrt(src)).", .[
        .{float32,  "sqrtps.x %1, %2;"}]},

    .{"average", "Set dest to ((dest + src) / 2).", .[
        .{u8,   "pavgb.x %1, %2;"},
        .{u16,  "pavgw.x %1, %2;"}]},


];

/* commands with irregular types:

movmskpd, pmovmskb : mask -> u16
pmaddwd : multiply and add words -> doubles
*/
