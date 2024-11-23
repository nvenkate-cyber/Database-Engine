open TokenTypes

let whitespace : Str.regexp = Str.regexp " \\|\n\\|\t"

let tokenize input = 
  let rec tokenize pos acc =
    (* if pos out of bounds *)
    if pos >= String.length input then List.rev acc
    (* if pos is at whitespace *)
    else if Str.string_match whitespace input pos then tokenize (pos + 1) acc
    (* get value of pos until next whitespace *)
    else
      if Str.string_match (Str.regexp "SELECT") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length)  (Tok_Select :: acc)
      else acc
  in
  tokenize 0 []