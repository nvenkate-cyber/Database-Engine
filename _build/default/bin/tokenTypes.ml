exception InvalidInputException of string

type token =
| Tok_Select
| Tok_Insert
| Tok_Update
| Tok_Delete
| Tok_Into
| Tok_Values
| Tok_Set
| Tok_Where
| Tok_From
| Tok_Equals
| Tok_Comma
| Tok_Asterik
| Tok_SemiColon