-- ListMaker
-- Converts an arbitrary string into a formatted shopping list

import Data.Maybe
import Data.Either
import Data.Char

-- Made mainly for personal use since its a unique syntax and
-- depends a bit on portuguese syntax but could? be ported over to english

--
-- Definitions:
-- Itemstack (an single entry, nullable, can contain quantity and aditional data)
-- Category (An arbitrary list of itemstacks under a common name, can contain a quantity)
--

data ItemStack = ItemStack {item::String, quantity::Int} deriving (Show)
data Category = Category String [ItemStack] Int

--
-- About the input string and expected formatting
-- Comma-separated. External data are inserted with parens.
-- Ex : "item, item2 (3), category (item, item2, item), category (item, item2 4 of each)"
--


--
-- Tokenization 
--
data Token = Comma
           | LParen
           | RParen
           | Item String
           | Number Int
           deriving (Show)
           

toTokens :: String -> [Token]
toTokens x = tokenize x ""

tokenize :: String -> String -> [Token]

tokenize [] [] = []
tokenize [] a = Item a:[]

tokenize (i:j:rest) buffer
  | i == ',' = Comma: tokenize (j:rest) []
  | i == '(' = LParen: tokenize (j:rest) []
  | i == ')' = RParen: tokenize (j:rest) []
  | j == ')' || j == '(' && isNum (i:buffer) = Number (read . reverse $ i:buffer :: Int):tokenize (j:rest) []
  | j == ')' || j == '(' = Item (reverse $ i:buffer):tokenize (j:rest) []
  | j == ',' = Item (reverse $ i:buffer):tokenize (j:rest) []
  | otherwise = tokenize (j:rest) (i:buffer)
  
tokenize [i] []
  | i == ',' = Comma : []
  | i == ')' = RParen : []
  | i == '(' = LParen : []
  | isDigit i = Number (read [i] :: Int) : []
  | otherwise = Item [i] : []

tokenize [i] buffer
  | isNum buffer && i == ',' = Comma : Number (read buffer :: Int) : []
  | isNum buffer && i == ')' = RParen : Number (read buffer :: Int) : []
  | isNum buffer && i == '(' = LParen : Number (read buffer :: Int) : []
  | i == ',' = Comma : Item (reverse buffer) : []
  | i == ')' = RParen : Item (reverse buffer) : []
  | i == '(' = LParen : Item (reverse buffer) : []
  | otherwise = Item (reverse $ i:buffer) : []

---
--- Parsing
--- It is required for parsing to create an Abstract Syntax Tree
--- Said structure is still not implemented and more reserach is
--- required in order to implement it, including a lot of fights
--- with Haskell.
---

---
--- Grammar
---

--- itemstack     ::= item lparen number rparen | item
--- categoryInner ::= itemstack comma categoryInner | itemstack 
--- category      ::= item lparen category rparen | item lparen categoryInner rparen


-- parse :: [Token] -> AST


---
--- Helper Functions
---

isNum :: String -> Bool
isNum x = all isDigit x
