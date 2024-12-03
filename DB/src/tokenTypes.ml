exception InvalidInputException of string

type token =
| Tok_Select
| Tok_Insert
| Tok_Update
| Tok_Delete
| Tok_Into
| Tok_ID of string
| Tok_Set (*[(col,val)]--update*)
| Tok_Where (*condition--select,update,delete*)
| Tok_From (*tablename--select,delete*)
| Tok_Equals (* prob dont need these- will be used in Tok_Set*)
| Tok_Comma 
| Tok_LParen
| Tok_RParen
| Tok_Values
| Tok_Asterik
| Tok_SemiColon