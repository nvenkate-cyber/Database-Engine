open MicroCamlTypes
open TokenTypes
open Utils

(* Matches the next token in the list, throwing an error if it doesn't match the given token *)
let match_token (toks: token list) (tok: token) =
  match toks with
  | [] -> raise (InvalidInputException(string_of_token tok))
  | h::t when h = tok -> t
  | h::_ -> raise (InvalidInputException(
      Printf.sprintf "Expected %s from input %s, got %s"
        (string_of_token tok)
        (string_of_list string_of_token toks)
        (string_of_token h)))

(* Matches a sequence of tokens given as the second list in the order in which they appear, throwing an error if they don't match *)
let match_many (toks: token list) (to_match: token list) =
  List.fold_left match_token toks to_match

(* Return the next token in the token list as an option *)
let lookahead (toks: token list) = 
  match toks with
  | [] -> None
  | h::_ -> Some h

(* Return the token at the nth index in the token list as an option*)
let rec lookahead_many (toks: token list) (n: int) = 
  match toks, n with
  | h::_, 0 -> Some h
  | _::t, n when n > 0 -> lookahead_many t (n-1)
  | _ -> None

(* SELECT:
   S -> * FROM t | c's FROM t | c's FROM t WHERE cond
   c -> col | col, c
   v -> value
   cond -> c = v *)

let rec parse_expr toks =
  match lookahead toks with
  (* Parse Select expr *)
  | Some(Tok_Select) -> parse_select_expr toks
  | _ -> (raise (InvalidInputException("no_select")))

and parse_select_expr toks =
  let toks = match_token toks Tok_Select in
  match (lookahead toks) with
  | Some(Tok_Asterik) -> 
    (let toks = match_token toks Tok_Asterik in
    let toks = match_token toks Tok_From in
    match lookahead toks with
    | Some(Tok_ID(t)) -> 
      (let toks = (match_token toks (Tok_ID(t))) in
      (toks, Select(Asterik, From(t), NoOp)))
    | _ -> (raise (InvalidInputException("no_table"))))

  | _ ->
    (let (toks,expr_cols) = parse_cols_expr toks in
    let toks = match_token toks Tok_From in
    match lookahead toks with
    | Some(Tok_ID(t)) ->
      (let toks = (match_token toks (Tok_ID(t))) in
      match lookahead toks with
      | None -> (toks, Select(expr_cols, From(t), NoOp))
      | _ -> (raise(InvalidInputException("implement_condition"))))
    | _ -> (raise(InvalidInputException("no_table"))))


and parse_cols_expr toks =
  match (lookahead toks) with
  | Some(Tok_ID(c)) -> 
    (let toks = match_token toks (Tok_ID(c)) in
    match lookahead toks with
    | Some(Tok_Comma) -> (let toks = match_token toks Tok_Comma in
      match parse_cols_expr toks with
      | (toks, Columns(expr)) -> (toks, Columns(c :: expr))
      | _ -> (raise(InvalidInputException("no_column"))))
    | _ -> (toks, Columns([c])))
  | _ -> (raise(InvalidInputException("no_column")))