Instruction :: struct {
    id : enum {
        CUSTOM :: -1;
        ADD;
        SUBTRACT;
        MULTIPLY;
        DIVIDE;
        SHIFT_LEFT;
        SHIFT_RIGHT;
        ROTATE_LEFT;
        ROTATE_RIGHT;
        CLEAR;
        AND;
        OR;
        XOR;
        AND_NOT;
        EQUAL;
        LESS;
        LESS_OR_EQUAL;
        NAN;
        NOT_EQUAL;
        GREATER_OR_EQUAL;
        GREATER;
        VALID;
        MAX;
        MIN;
        MOVE;
        INVERSE;
        INVERSE_ROOT;
        ROOT;
        AVERAGE;
    }

    type : Type;
    operands : [2] Operand;
    custom_code : string;
}


// This commented-out code generates the procs found below

#scope_module

instruction_template_two_operands :: #string __jai
%1 :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        operand_a := operand_from_node(vec128_a_root);
        operand_b := operand_from_node(vec128_b_root);

        add_instruction(.%2, type, operand_a, operand_b);
    }
}
__jai

#scope_export


#insert -> string {
    builder : String_Builder;
    init_string_builder(*builder);
    defer reset(*builder);

    for enum_values_as_enum(type_of(Instruction.id)) {
        if it == .CUSTOM  continue;
        print_to_builder(*builder, instruction_template_two_operands, operators[it].name, it);
        append(*builder, "\n");
    }

    //print("%\n", builder_to_string(*builder));
    return builder_to_string(*builder);
}
