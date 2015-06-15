open Language;;

module Javascript_language_implementation =
struct
  let bitmap_name = "javascript_bitmap"
  let create_bitmap (size: int) : string =
    Printf.sprintf "var %s = new Array(%d);" bitmap_name size
  let set_line_bit (line: int) : string =
    Printf.sprintf "%s[%d] = 1;" bitmap_name line
  (* TODO: Write *)
  let print_bitmap() : string =
    Printf.sprintf "console.log(%s);" bitmap_name
  let get_execute_command (filename: string) : string =
    Printf.sprintf "node %s" filename

end

module Javascript_language = (Javascript_language_implementation:Language_signature);;

