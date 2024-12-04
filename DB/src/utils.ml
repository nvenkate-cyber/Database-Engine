
open TokenTypes

let string_of_token (t : token) : string = match t with
  | Tok_Select -> "Tok_Select"
  | Tok_Insert -> "Tok_Insert"
  | Tok_Update -> "Tok_Update"
  | Tok_Delete -> "Tok_Delete"
  | Tok_Into -> "Tok_Into"
  | Tok_ID(id) -> "Tok_ID(\"" ^ id ^ "\")"
  | Tok_Bool(b) -> "Tok_Bool(\"" ^ (string_of_bool b) ^ "\")"
  | Tok_Int(i) -> "Tok_Int(\"" ^ (string_of_int i) ^ "\")"
  | Tok_Set -> "Tok_Set"
  | Tok_Where -> "Tok_Where"
  | Tok_From -> "Tok_From"
  | Tok_Equals -> "Tok_Equals"
  | Tok_Comma -> "Tok_Comma"
  | Tok_LParen -> "Tok_LParen"
  | Tok_RParen -> "Tok_RParen"
  | Tok_Values -> "Tok_Values"
  | Tok_Asterik -> "Tok_Asterik"
  | Tok_SemiColon -> "Tok_Semicolon"

let string_of_list ?newline:(newline=false) (f : 'a -> string) (l : 'a list) : string =
  "[" ^ (String.concat ", " @@ List.map f l) ^ "]" ^ (if newline then "\n" else "");;
