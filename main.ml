open Core.Std
open Sys

let spec =
  let open Command.Spec in
  empty
  (* We want to make this usable for multiple languages, so we need to know how
   * to run the file. *)
  +> flag "-exec" (optional string) ~doc:"Command to execute to generate covereage" 
  +> anon ("filename" %: string)

let dump_lines lines : unit =
  let _ = lines |> List.map ~f:(fun x -> printf "%s\n" x) in ()

let coverage file : unit =
  let lines = 
    In_channel.with_file file ~f:(fun ic ->
      In_channel.fold_lines ic ~init:[] ~f:(fun lines line ->
        "console.log('yo');" :: line :: lines
      )
    ) in
  dump_lines (List.rev lines)

let execute_file (exec_cmd: string) (filename: string) : unit =
  (* TODO: Handle errors *)
  let _ = Sys.command (String.concat ~sep:" " [exec_cmd; filename]) in ()

let process_file (exec_cmd: string option) (filename: string) : unit =
  match exec_cmd with
    Some cmd -> execute_file cmd filename
  | None -> coverage filename

let command =
  Command.basic
    ~summary:"Show coverage for a JavaScript file"
    ~readme:(fun () -> "Details TODO")
    spec
    (fun exec_cmd filename () -> process_file exec_cmd filename)

let () =
  Command.run ~version:"1.0" ~build_info:"RWO" command

