module ListMaker
  (
    toTokens
  , parseMany
  , toStr
  ) where
  
-- ListMaker
-- Converts an arbitrary string into a formatted shopping list

import Data.Maybe
import Data.Either
import Data.Char

import Data.List

-- Made mainly for personal use since its a unique syntax and
-- depends a bit on portuguese syntax but could? be ported over to english

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
tokenize [] a = [Item a]

tokenize (i:j:rest) buffer
  | i == ',' = Comma: tokenize (j:rest) []
  | i == '(' = LParen: tokenize (j:rest) []
  | i == ')' = RParen: tokenize (j:rest) []
  | (j == ')' || j == '(') && isNum (i:buffer) = Number (read . reverse $ i:buffer :: Int):tokenize (j:rest) []
  | j == ')' || j == '(' = Item (reverse $ i:buffer):tokenize (j:rest) []
  | j == ','  = Item (reverse $ i:buffer):tokenize (j:rest) []
  | otherwise = tokenize (j:rest) (i:buffer)
  
tokenize [i] []
  | i == ','  = [Comma]
  | i == ')'  = [RParen]
  | i == '('  = [LParen]
  | isDigit i = [Number (read [i] :: Int)]
  | otherwise = [Item [i]]

tokenize [i] buffer
  | isNum buffer && i == ',' = [Comma, Number (read buffer :: Int)]
  | isNum buffer && i == ')' = [RParen, Number (read buffer :: Int)]
  | isNum buffer && i == '(' = [LParen, Number (read buffer :: Int)]
  | i == ',' = [Comma, Item (reverse buffer)]
  | i == ')' = [RParen, Item (reverse buffer)]
  | i == '(' = [LParen, Item (reverse buffer)]
  | otherwise = [Item (reverse $ i:buffer)]

-- AST
data AST = Single String
      | Multiple String Int
      | Category String [AST]
      deriving Show


-- Parsing
parseOne :: [Token] -> Maybe (AST,[Token])
parseOne [] = Nothing
parseOne (Comma : xs) = parseOne xs

parseOne (Item i : LParen : Number n: RParen: xs) = Just (Multiple i n, xs)

parseOne (Item name : LParen : xs) = Just (Category name contents, rest')
  where (contents, rest) = parseMany xs
        rest' = case rest of
                     [RParen] -> []
                     (RParen : nommed) -> nommed
                     _ -> error "Unmatched Parenthesis"

parseOne (Item x : xs) = Just (Single x, xs)
parseOne _ = Nothing

parseMany :: [Token] -> ([AST], [Token])
parseMany [] = ([],[])
parseMany tokens = case parseOne tokens of
                        Just (item, rest) -> let (items, rest') = parseMany rest in (item : items, rest')
                        Nothing -> ([], tokens)
---
--- Helper Functions
---

rest'' :: [Token] -> [Token]
rest'' x = case x of
               [RParen] -> []
               (RParen : nommed) -> nommed
               _ -> error "Unmatched Parenthesis"

isNum :: String -> Bool
isNum = all isDigit


toStr :: Int -> AST -> String
toStr y (Single name)  = duplicate "    " y ++ "- " ++ trim name ++ "\n"
toStr y (Multiple name count)  = duplicate "    " y ++ "- (" ++ show count ++ "x) " ++ trim name ++ "\n"
toStr y (Category name fakyu)  = duplicate "    " y ++ trim name ++ ":\n" ++ concatMap (toStr (y+1)) fakyu

---
--- Code Yoinked from Data.List.Extra (extra-1.7.3)
--- Since i can't figure out how cabal works. yay!
---

trim :: String -> String
trim = trimEnd . trimStart

trimEnd :: String -> String
trimEnd = dropWhileEnd isSpace

trimStart :: String -> String
trimStart = dropWhile isSpace

duplicate :: String -> Int -> String
duplicate string n = concat $ replicate n string
