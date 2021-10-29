suma :: [Integer] -> Integer
suma [] = 0
suma (x:xs) = x + suma xs  --es la forma de sumar recursivamente los elem


sorted :: (Ord a) => [a] -> Bool
sorted [] = True
sorted [_] = True
sorted (x:y:zs) = x<=y && sorted(y:zs)
