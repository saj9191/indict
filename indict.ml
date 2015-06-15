open Core.Std
open Language;;
open Javascript_language;;

module type Indict_signature =
  functor (L: Language_signature) ->
    sig
      val indict_file: string -> unit
    end;;

module Indict_implementation =
  functor (L: Language_signature) ->
  struct
    let read_file (filename: string) : string list =
      In_channel.with_file filename ~f:(fun ic ->
        In_channel.input_lines ic
      )

    let write_file (filename: string) (lines: string list) : unit =
      Out_channel.with_file filename ~f:(fun oc ->
        Out_channel.output_lines oc lines
      )

    let dump_lines lines : unit =
      let _ = lines |> List.map ~f:(fun x -> printf "%s\n" x) in ()

    let rec insert_set_line_bit_code (lines: string list) (line: int) : string list =
      match lines with
      [] -> [L.print_bitmap()]
      | hd :: tl -> hd :: (L.set_line_bit line) :: (insert_set_line_bit_code tl (line + 1))

    let insert_indict_code (lines: string list) : string list =
      let num_lines = List.length lines in
      (L.create_bitmap num_lines) :: (insert_set_line_bit_code lines 0)

    let execute_file (filename: string) : unit =
      (* TODO: handle errors *)
      let _ = Sys.command (L.get_execute_command filename) in ()

    let indict_file (filename: string) : unit =
      let tmp_filename = String.concat ~sep:"" ["temp_"; filename] and
          lines = read_file filename in
      let indicted_lines = insert_indict_code lines in
      write_file tmp_filename indicted_lines;
      execute_file tmp_filename;
      (* TODO: delete temp file *)
      dump_lines indicted_lines;

  end;;

module Indict = (Indict_implementation:Indict_signature);;
