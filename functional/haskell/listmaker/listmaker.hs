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
  | i == ',' = Comma:tokenize (j:rest) []
  | i == '(' = LParen:tokenize (j:rest) []
  | i == ')' = RParen:tokenize (j:rest) []
  | j == ')' && isNum (i:buffer) = Number (read (i:buffer) :: Int):tokenize (j:rest) []
  | j == ')' = Item (i:buffer):tokenize (j:rest) []
  | j == ',' = Item (i:buffer):tokenize (j:rest) []
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
  | i == ',' = Comma : Item buffer : []
  | i == ')' = RParen : Item buffer : []
  | i == '(' = LParen : Item buffer : []
  | otherwise = Item (i:buffer) : []


isNum :: String -> Bool
isNum x = all isDigit x

formalize :: String -> [String]
formalize [] = []
formalize s = splitStuff ',' s

isCategory :: String -> Bool
isCategory x =  '(' `elem` x

parse :: Int -> [String] -> [Maybe (Either Category ItemStack)]
parse _ _ = []

parseSimple :: String -> Maybe ItemStack
parseSimple x
  | checkStart && checkEnd = Just $ ItemStack (head $ splitStuff '(' x) (read (replace ')' ' ' . head $ getInnerData x) :: Int) 
  | checkStart || checkEnd = Nothing
  | otherwise = Just $ ItemStack x 0 
  where checkStart = '(' `elem` x
        checkEnd = ')' `elem` x

getInnerData :: String -> [String]
getInnerData x = filter (\s -> ')' `elem` s) $ splitStuff '(' x

splitStuff :: Eq a => a -> [a] -> [[a]]
splitStuff d [] = []
splitStuff d s = x : splitStuff d (drop  1 y) where (x,y) = span (/= d) s

replace :: Eq a => a -> a -> [a] -> [a]
replace a b = map $ \c -> if c == a then b else c
