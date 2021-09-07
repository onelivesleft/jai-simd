Instruction :: struct {
    id : enum {
        CUSTOM :: -1;
        ADD;
        SUBTRACT;
        MULTIPLY;
        DIVIDE;
        AND;
        OR;
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
    }

    type : Type;
    operands : [2] Operand;
    custom_code : string;
}


// This commented-out code generates the procs found below
/*
#scope_module

instruction_template_two_operands :: #string __jai
%1 :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.%2, type, vec128_a_id, vec128_b_id);
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
*/


add :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.ADD, type, vec128_a_id, vec128_b_id);
    }
}

subtract :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.SUBTRACT, type, vec128_a_id, vec128_b_id);
    }
}

multiply :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.MULTIPLY, type, vec128_a_id, vec128_b_id);
    }
}

divide :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.DIVIDE, type, vec128_a_id, vec128_b_id);
    }
}

and :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.AND, type, vec128_a_id, vec128_b_id);
    }
}

or :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.OR, type, vec128_a_id, vec128_b_id);
    }
}

and_not :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.AND_NOT, type, vec128_a_id, vec128_b_id);
    }
}

equal :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.EQUAL, type, vec128_a_id, vec128_b_id);
    }
}

less :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.LESS, type, vec128_a_id, vec128_b_id);
    }
}

less_or_equal :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.LESS_OR_EQUAL, type, vec128_a_id, vec128_b_id);
    }
}

nan :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.NAN, type, vec128_a_id, vec128_b_id);
    }
}

not_equal :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.NOT_EQUAL, type, vec128_a_id, vec128_b_id);
    }
}

greater_or_equal :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.GREATER_OR_EQUAL, type, vec128_a_id, vec128_b_id);
    }
}

greater :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.GREATER, type, vec128_a_id, vec128_b_id);
    }
}

valid :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.VALID, type, vec128_a_id, vec128_b_id);
    }
}

max :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.MAX, type, vec128_a_id, vec128_b_id);
    }
}

min :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.MIN, type, vec128_a_id, vec128_b_id);
    }
}

copy :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.MOVE, type, vec128_a_id, vec128_b_id);
    }
}

inverse :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.INVERSE, type, vec128_a_id, vec128_b_id);
    }
}

inverse_root :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.INVERSE_ROOT, type, vec128_a_id, vec128_b_id);
    }
}

root :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        is_vec128, type := check_node_is_vec128(vec128_a_root);
        assert(is_vec128, "First parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Second parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.ROOT, type, vec128_a_id, vec128_b_id);
    }
}
