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
      else if Str.string_match (Str.regexp "INSERT") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length)  (Tok_Insert :: acc)
      else if Str.string_match (Str.regexp "UPDATE") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length)  (Tok_Update :: acc)
      else if Str.string_match (Str.regexp "DELETE") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length)  (Tok_Delete :: acc)
      
      else if Str.string_match (Str.regexp "INTO") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length) (Tok_Into :: acc)
      
      else if Str.string_match (Str.regexp "SET") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length) (Tok_Set :: acc)

      else if Str.string_match (Str.regexp "WHERE") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length) (Tok_Where :: acc)

      else if Str.string_match (Str.regexp "FROM") input pos then
          let matched = Str.matched_string input in
          let length = String.length matched in
          tokenize (pos + length) (Tok_From :: acc)
      
      else if Str.string_match (Str.regexp "VALUES") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length) (Tok_Values :: acc)

      else if Str.string_match (Str.regexp "=") input pos then
        tokenize (pos + 1) (Tok_Equals :: acc)
      
      else if Str.string_match (Str.regexp ",") input pos then
        tokenize (pos + 1) (Tok_Comma :: acc)

      else if Str.string_match (Str.regexp "(") input pos then
        tokenize (pos + 1) (Tok_LParen :: acc)

      else if Str.string_match (Str.regexp ")") input pos then
        tokenize (pos + 1) (Tok_RParen :: acc)

      else if Str.string_match (Str.regexp "\\*") input pos then
        tokenize (pos + 1) (Tok_Asterik :: acc)
      
      else if Str.string_match (Str.regexp ";") input pos then
        tokenize (pos + 1) (Tok_SemiColon :: acc)

      else if Str.string_match (Str.regexp "true\\|false") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length) (Tok_Bool(bool_of_string matched) :: acc)

      else if Str.string_match (Str.regexp "[0-9]+") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length) (Tok_Int(int_of_string matched) :: acc)

      else if Str.string_match (Str.regexp "[a-zA-Z0-9]*") input pos then
        let matched = Str.matched_string input in
        let length = String.length matched in
        tokenize (pos + length) (Tok_ID(matched) :: acc)

      else acc
  in
  tokenize 0 []