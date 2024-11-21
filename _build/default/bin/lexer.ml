open TokenTypes

let all_tokens : (Str.regexp * token) list =
  List.map (fun (s, f) -> ((Str.regexp s), f))
    [
      "SELECT", Tok_Select
    ]

let whitespace : Str.regexp = Str.regexp " \\|\n\\|\t"

let tokenize input = 
  let rec tokenize pos acc =
    (* if pos out of bounds *)
    if pos >= String.length input then List.rev acc
    (* if pos is at whitespace *)
    else if Str.string_match whitespace input pos then tokenize (pos + 1) acc
    (* get value of pos until next whitespace *)
    else
      List.fold_left (fun ((best_len, best_tok) as old) (rxp, tok_function) ->
        if Str.string_match rxp input pos then
          let matched = Str.matched_string input in
          let length = String.length matched in

          if length > best_len then
            (length, Some(tok_function matched))
          else old
        else old
      ) (0, None) all_tokens
  in
  tokenize 0 []