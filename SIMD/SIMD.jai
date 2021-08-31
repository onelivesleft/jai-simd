#import "Basic";
#import "Compiler";

#load "Vec128.jai";


simd_calculate :: () #expand {
    #insert -> string {
        if active_instructions.count {
            header_builder : String_Builder;
            asm_builder : String_Builder;
            init_string_builder(*asm_builder);
            init_string_builder(*header_builder);
            defer {
                reset(*asm_builder);
                reset(*header_builder);

                array_reset(*active_vec_ids);
                array_reset(*active_written_operands);

                for inst: active_instructions
                    for inst.operands
                        free(it.id);
                array_reset(*active_instructions);
            }

            append(*asm_builder, "\n#asm{\n");

            for inst: active_instructions {
                for inst.operands {
                    if !contains(active_vec_ids, it.id) {
                        print_to_builder(*header_builder, "%_ptr : *void = *`%;\n", it.id, it.name);
                        print_to_builder(*asm_builder, "movdqu.x %1:, [%1_ptr];\n", it.id);
                        array_add(*active_vec_ids, it.id);
                    }
                }
                found := false;
                for active_written_operands {
                    if it.id == inst.operands[0].id {
                        found = true;
                        break;
                    }
                }
                if !found  array_add(*active_written_operands, inst.operands[0]);

                code := operators[inst.id].code;
                print_to_builder(*asm_builder, code, inst.operands[0].id, inst.operands[1].id);
                if code && code[code.count -1] != #char "\n"
                    append(*asm_builder, "\n");
            }

            for active_written_operands
                print_to_builder(*asm_builder, "movdqu.x [%1_ptr], %1;\n", it.id);

            append(*asm_builder, "}\n\n");

            print_to_builder(*header_builder, builder_to_string(*asm_builder));
            return builder_to_string(*header_builder);
        }
        else {
            return "";
        }
     }
}


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


// @TODO
simd_instruction :: (instruction: string) {}


#scope_module


instruction_template_two_operands :: #string __jai
simd_%1 :: (vec128_a: Code, vec128_b: Code) #expand {
    #run {
        vec128_a_root, vec128_a_expressions := compiler_get_nodes(vec128_a);
        vec128_b_root, vec128_b_expressions := compiler_get_nodes(vec128_b);

        assert(check_node_is_vec128(vec128_a_root), "Parameter must be a Vec128");
        assert(check_node_is_vec128(vec128_b_root), "Parameter must be a Vec128");

        vec128_a_id := id_from_ident(vec128_a_root);
        vec128_b_id := id_from_ident(vec128_b_root);

        add_instruction(.%2, vec128_a_id, vec128_b_id);
    }
}
__jai




Instruction :: struct {
    id : enum {
        CUSTOM :: -1;
        ADD :: 0;
    }

    operands : [2] Operand;
    custom : string;
}

Operator :: struct {
    name : string;
    code : string;
}


operators :: Operator.[
    .{"add", "addps.x %1, %2;"},
];


Operand :: struct {
    id : string;
    name : string;
}


operand :: (id: string) -> Operand {
    result : Operand;
    result.id = id;
    result.name = name_from_id(id);
    return result;
}


instruction :: (id: type_of(Instruction.id), operand_a_id: string, operand_b_id: string) -> Instruction {
    result : Instruction = ---;
    result.id = id;
    result.operands[0] = operand(operand_a_id);
    result.operands[1] = operand(operand_b_id);
    return result;
}


add_instruction :: (id: type_of(Instruction.id), operand_a_id: string, operand_b_id: string) {
    array_add(*active_instructions, instruction(id, operand_a_id, operand_b_id));
}



active_vec_ids : [..] string;
active_written_operands : [..] Operand;
active_instructions : [..] Instruction;


id_from_ident :: (node: *Code_Node) -> id: string {
    ident := cast(*Code_Ident) node;
    return sprint("%_%", ident.name, formatInt(cast(u64)ident.resolved_declaration, 16, 8, 0, ""));
}

name_from_id :: (id: string) -> string {
    name : string = ---;
    name.data = id.data;
    name.count = id.count - 9;
    return name;
}


contains :: (haystack: [] $T, needle: T) -> bool {
    for haystack  if it == needle  return true;
    return false;
}




check_node_is_vec128 :: (node: *Code_Node) -> bool #expand {
    if node.kind != .IDENT  return false;

/*
    ident := cast(*Code_Ident) node;
    decl := ident.resolved_declaration;
    type_inst := decl.type_inst;

    print("%\n", ident.name);
*/
    return true;
}
