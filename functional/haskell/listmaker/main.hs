import ListMaker (toTokens, parseMany, toStr)

main :: IO()
main = do
    ahFFS <- getLine
    let tokens = toTokens ahFFS
    let parsed = parseMany tokens
    let output = map (toStr 0) $ fst parsed
    putStrLn $ concat output
