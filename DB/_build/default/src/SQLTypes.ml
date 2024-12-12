type statement = Select 

type column = string

type columns = 
| Columns of column list
| Asterik

type table = string

type value = 
| Int of int
| Bool of bool
| String of string

type condition = column * value

type op = 
| From of table 
| Where of condition
| NoOp

type mutop = 
| Select of columns * op * op
| NoOp