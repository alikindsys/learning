module CPF 
(
  Cpf
, isValidNoOO
, isValid
) where

data Cpf = Cpf { firstNine:: Int 
                , digitOne :: Int
                , digitTwo :: Int
                } deriving (Show)

-- Formula for calculating first digit
-- Take all non-verifying digits, reverse and multiply from 2 to 10.
-- then `mod` 11. if `mod` 11 < 2 = 0 else 11 - `mod` 11.
calculateDigitOne :: [Int] -> Int
calculateDigitOne x = 
        if formula < 2
            then 0
            else 11 - formula
    where nums = reverse . take 9 $ reverse x
          formula = sumVerifyDigit nums 2 `mod` 11

calculateDigitTwo :: [Int] -> Int -> Int
calculateDigitTwo x y = 
        if formula < 2
            then 0
            else 11 - formula
    where nums = y : (reverse . take 9 $ reverse x)
          formula = sumVerifyDigit nums 2 `mod` 11 

calculateCpfNums :: Int -> [Int]
calculateCpfNums x = [firstDig, secondDig]
        where firstDig = calculateDigitOne cpfDigits
              secondDig = calculateDigitTwo cpfDigits firstDig
              cpfDigits = fastToDigits x
-- CPF : [9,8,7,6,5,4,3,2,1]
-- Func = [(9*2), (8*3), (7*4)...]
-- sumVerifyDigit nums 2
sumVerifyDigit :: [Int] -> Int -> Int
sumVerifyDigit [] _ = 0
sumVerifyDigit (x:xs) n = x * n + sumVerifyDigit xs (n+1) 

fastToDigits :: Integral x => x -> [x]
fastToDigits 0 = []
fastToDigits x = x `mod` 10 : fastToDigits (x `div` 10)

isValid :: Cpf -> Bool
isValid cpf | isExemption cpfDigits = False
            | otherwise = digitOne cpf == firstDig && digitTwo cpf == secondDig
    where firstDig = calculateDigitOne cpfDigits
          secondDig = calculateDigitTwo cpfDigits firstDig
          cpfDigits = fastToDigits $ firstNine cpf

isValidNoOO :: Int -> (Int,Int) -> Bool
isValidNoOO cpf (digOne, digitTwo)
    | isExemption cpfDigits = False
    | otherwise = digOne == firstDig && digitTwo == secondDig
    where firstDig = calculateDigitOne cpfDigits
          secondDig = calculateDigitTwo cpfDigits firstDig
          cpfDigits = fastToDigits cpf

isExemption :: [Int] -> Bool
isExemption cpfDigits 
            | cpfDigits == replicate 9 1 = True
            | cpfDigits == replicate 9 2 = True
            | cpfDigits == replicate 9 3 = True
            | cpfDigits == replicate 9 4 = True
            | cpfDigits == replicate 9 5 = True
            | cpfDigits == replicate 9 6 = True
            | cpfDigits == replicate 9 7 = True
            | cpfDigits == replicate 9 8 = True
            | cpfDigits == replicate 9 9 = True
            | cpfDigits == replicate 9 0 = True
            | otherwise = False