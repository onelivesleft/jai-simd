#import "Basic";
#import "Compiler";

#load "Vec128.jai";
#load "operators.jai";
#load "instructions.jai";


calculate :: () #expand {
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
                // @TODO
                //if inst.id == .CUSTOM {
                //    print_to_builder(*asm_builder, inst.custom_code);
                //    continue;
                //}

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

                found = false;
                for operators[inst.id].types {
                    if it.type == void || it.type == inst.type {
                        found = true;
                        print_to_builder(*asm_builder, it.code, inst.operands[0].id, inst.operands[1].id);
                        if it.code[it.code.count - 1] != #char "\n"
                            append(*asm_builder, "\n");
                        break;
                    }
                }
                #if !testing {
                    assert(found, "This operation is not available with this type: %, %\n", inst.id, it.type);
                }
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


// @TODO
/*
asm :: (params: .. Code, code: string) #expand {
    #run {
        custom_instruction : Instruction = ---;
        custom_instruction.id = .CUSTOM;
        custom_instruction.custom_code = code;
        array_add(*active_instructions, custom_instruction);
    }
}
*/



type_supports_instruction :: (type: Type, instruction_name: string) -> bool {
    for operators {
        if it.name == instruction_name {
            for op: it.types {
                if (op.type == type || op.type == void) && op.code != ""
                    return true;
            }

            return false;
        }
    }

    return false;
}


#scope_module;



Operator_Code :: struct {
    type : Type;
    code : string;
}


Operator :: struct {
    name : string;
    info : string;
    types : [..] Operator_Code;
}


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


instruction :: (id: type_of(Instruction.id), type: Type, operand_a_id: string, operand_b_id: string) -> Instruction {
    result : Instruction = ---;
    result.id = id;
    result.type = type;
    result.operands[0] = operand(operand_a_id);
    result.operands[1] = operand(operand_b_id);
    return result;
}


add_instruction :: (id: type_of(Instruction.id), type: Type, operand_a_id: string, operand_b_id: string) {
    array_add(*active_instructions, instruction(id, type, operand_a_id, operand_b_id));
}



active_vec_ids : [..] string;
active_written_operands : [..] Operand;
active_instructions : [..] Instruction;


id_from_ident :: (node: *Code_Node) -> id: string {
    ident := cast(*Code_Ident) node;
    return sprint("%__simd", ident.name);
}

name_from_id :: (id: string) -> string {
    name : string = ---;
    name.data = id.data;
    name.count = id.count - 6;
    return name;
}


contains :: (haystack: [] $T, needle: T) -> bool {
    for haystack  if it == needle  return true;
    return false;
}




check_node_is_vec128 :: (node: *Code_Node) -> is_vec128: bool, type: Type {
    if node.kind != .IDENT  return false, void;

    ident := cast(*Code_Ident) node;
    decl := ident.resolved_declaration;
    type_inst := decl.type_inst;

    if !type_inst {
        decl_expression := decl.expression;
        if decl.expression {
            if decl_expression.kind == {
                case .IDENT;
                is_vec128, type := check_node_is_vec128(decl_expression);
                ident := cast(*Code_Ident)decl_expression;
                return is_vec128, type;

                case .PROCEDURE_CALL;
                call := cast(*Code_Procedure_Call)decl_expression;
                if call.overloads.count && call.overloads[0][0].expression {
                    header := cast(*Code_Procedure_Header)call.overloads[0][0].expression;
                    if header.returns.count && header.returns[0].kind == .DECLARATION {
                        called_decl := cast(*Code_Declaration)header.returns[0];
                        type_inst = called_decl.type_inst;
                    }
                }
            }
        }
    }

    if type_inst {
        expression := type_inst.type_valued_expression;
        if expression.kind == .PROCEDURE_CALL {
            call := cast(*Code_Procedure_Call)expression;
            type_ident := cast(*Code_Ident) call.procedure_expression;

            if type_ident && type_ident.name == "Vec128" {
                arg := call.arguments_unsorted[0];
                arg_ident := cast(*Code_Ident)arg.expression;
                return true, type_from_name(arg_ident.name);
            }
        }
    }

    return false, void;
}


type_from_name :: (name: string) -> Type {
    if name == {
        case "u8";       return u8;
        case "u16";      return u16;
        case "u32";      return u32;
        case "u64";      return u64;
        case "s8";       return s8;
        case "s16";      return s16;
        case "s32";      return s32;
        case "s64";      return s64;
        case "float32";  return float32;
        case "float64";  return float64;
    }
    return void;
}
