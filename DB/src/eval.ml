open SQLTypes
open TokenTypes

(* Reads the lines of a file that includes *) 
(* records of a database *)
let read_lines name : string list =
  let ic = open_in name in
  let try_read () =
    try Some (input_line ic) with End_of_file -> None in
  let rec loop acc = match try_read () with
    | Some s -> loop (s :: acc)
    | None -> close_in ic; List.rev acc in
  loop []

let print_lines list = 
  List.fold_left (fun a x -> String.concat "\n" [a; x]) "" list

let data_struct () =
  [("customerID", ["1";"2";"3"]); ("name", ["Test1";"Test2";"Test3"]);
   ("address", ["address test"; "address test"; "address test"]);
   ("balance", ["100";"200";"300"])]

(* let print_data_struct list =
  match list with
  | [] -> ""
  | (h1,h2)::t -> (let data = h1 ^ "\n" ^ List.fold_left (fun a x -> a ^ "\n" ^ x) "" h2 in
    let s = String.split_on_char "\n" data in
    let rec print_rest str l =
      (match l with
      | [] -> str
      | (h1,h2)::t -> (let str = (List.hd str) ^ h1 in
          (let rec iterate_both_lists str h2 res =
            (match str, h2 with
            | [], [] -> res
            | s::s1, d::d1 -> iterate_both_lists s1 d1 (res @ [s ^ d])
            | _, _ -> res))
          in print_rest (iterate_both_lists str h2 "") t))
    in print_rest s t) *)


(* Evaluates given expression *)
let eval_expr e =
  match e with
  | Select(Asterik, From(table), NoOp) -> print_lines (read_lines ("src/" ^ table))
  (* | Select(Columns(cols), _, NoOp) -> let table = data_struct () in
    List.fold_left (fun a (col,vals) -> if (List.mem col cols) then (col,vals)::a else a) [] table *)
  | _ -> (raise(InvalidInputException("not implemented")))