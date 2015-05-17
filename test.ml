open Core.Std

let spec =
  let open Command.Spec in
  empty
  +> flag "-exec" (optional string) ~doc:"Command to execute to generate covereage" 
  +> anon ("filename" %: string)

let dump_lines lines =
  let _ = lines |> List.map ~f:(fun x -> printf "%s\n" x) in ()

let coverage js_file =
  let lines = 
    In_channel.with_file js_file ~f:(fun ic ->
      In_channel.fold_lines ic ~init:[] ~f:(fun lines line ->
        "console.log('yo');" :: line :: lines
      )
    ) in
  dump_lines (List.rev lines)

let command =
  Command.basic
    ~summary:"Show coverage for a JavaScript file"
    ~readme:(fun () -> "Details TODO")
    spec
    (fun exec_cmd js_file () -> coverage js_file)

let () =
  Command.run ~version:"1.0" ~build_info:"RWO" command

