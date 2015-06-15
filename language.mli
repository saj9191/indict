module type Language_signature = sig
  val bitmap_name : string
  val create_bitmap : int -> string
  val set_line_bit : int -> string
  val print_bitmap : unit -> string
  val get_execute_command : string -> string
end
