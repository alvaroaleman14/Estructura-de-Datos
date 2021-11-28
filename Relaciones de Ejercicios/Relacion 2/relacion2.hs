-------------------------------------------------------------------------------
-- Estructuras de Datos. 2º Curso. ETSI Informática. UMA
--
-- 
-- Titulación: Grado en Ingeniería del Software.
-- Alumno: Alemán Rando, Álvaro
-- Fecha de entrega: DIA | MES | AÑO
--
-- Relación de Ejercicios 2. Ejercicios resueltos: ..........
--
-------------------------------------------------------------------------------
import Test.QuickCheck
import Data.List

-- Ejercicio 1

data Direction = North | South | East | West deriving (Eq, Ord, Enum, Show)

    -- a)
(<<) :: Direction -> Direction -> Bool 
(<<) x y | fromEnum x < fromEnum y = True
         | otherwise = False 

p_menor x y = (x < y) == (x << y)
instance Arbitrary Direction where
    arbitrary = do
        n <- choose (0,3)
        return $ toEnum n

-- Ejercicio 2
    -- a)
máximoYresto :: Ord a => [a] -> (a,[a])
máximoYresto [ ] = error "Lista vacía"
máximoYresto [x] = (x,[ ])
máximoYresto (x:xs) | x > max   = (x, max:res)
                    | otherwise = (max, x:res)
    where
        (max,res) = máximoYresto xs


    -- b)
máximoYresto' :: Ord a => [a] -> (a,[a])
máximoYresto' [ ] = error "Lista vacía"
máximoYresto' [x] = (x,[ ])
máximoYresto' (x:xs) | x > max   = (x, (sort (max:res)))
                     | otherwise = (max, (sort (x:res)))
    where
        (max,res) = máximoYresto' xs

-- Ejercicio 3
reparte :: [a] -> ([a],[a])
reparte [ ] = ([ ],[ ])
reparte [x] = ([x], [ ])
reparte (x:y:res) = (x:xs,y:ys)
 where
     (xs,ys) = reparte res

-- Ejercicio 4
distintos :: Eq a => [a] -> Bool 
distintos [ ] = error "Lista vacía"
distintos [x] = True 
distintos (x:xs) = if elem x xs == True then False else distintos xs

-- Ejercicio 5
replicate' :: Int -> a -> [a]
replicate' 0 n = [ ]
replicate' 1 n = [n]
replicate' x n = n : replicate' (x-1) n

    -- b)
p_replicate' n x = n >= 0 && n <= 1000 ==> length (filter (==x) xs) == n
                                           && length (filter (/=x) xs) == 0
   where xs = replicate' n x

-- Ejercicio 6 
divisores :: Int -> [Int]
divisores x = [n | n <- [1..x], divideA n x]
 where
     divideA n x = if mod x n == 0 then True else False

divisores' :: Int -> [Int]
divisores' x | x < 0 =  ([n | n <- [x..(-1)], divideA n x] ++ divisores (-x))
             | otherwise = divisores x
 where
     divideA n x = if mod x n == 0 then True else False

-- Ejercicio 7 
    --a)
mcd :: Int -> Int -> Int 
mcd x y | x==0 || y==0 = error "No hay maximo comun divisor si uno es nulo"
        | otherwise =  maximum(intersect (divisores' x) (divisores' y))

    -- c)
mcm :: Int -> Int -> Int 
mcm x y | x==0 || y==0 = error "No hay mcm si uno es nulo"
        | otherwise =  div (x*y) (mcd x y)

-- Ejercicio 8 
 -- Partiendo de que 1 no es primo. Un num es primo si tiene como divisores 1 y p
    -- a)
esPrimo :: Int -> Bool 
esPrimo x | length (divisores x) == 2 = True
          | otherwise = False 
    -- b)
primosHasta :: Int -> [Int]
primosHasta x = [n | n <- [1..x], esPrimo n == True ]

    -- c)
primosHasta' :: Int -> [Int]
primosHasta' x = filter (esPrimo) [2..x]

-- Ejercicio 9 
 -- Conjetura de Goldbach: "Todo num par > 2 puede escribirse como la suma de dos primos"
pares :: Int -> [(Int,Int)]
pares x | mod x 2 /= 0 = [ ]
        | otherwise = [(n,y) | n <- primosHasta (div x 2), y <- primosHasta x, (n + y) == x]
 -- b)
goldbach :: Int -> Bool 
goldbach x = if length (pares x) >= 1 then True else False

-- Ejercicio 10
 -- a) 
-- Redefino la funciones divisores, pero quitandole el ultimo valor

esPerfecto :: Int -> Bool 
esPerfecto x = sum (divisores x) - x == x

 -- b)
perfectosMenoresQue :: Int -> [Int]
perfectosMenoresQue x = filter (esPerfecto) [1..x]

-- Ejercicio 11
 -- a) 
take' :: Int -> [a] -> [a]
take' n xs = [ x | (p,x) <- zip [0..(n-1)] xs]
 
 --b)
drop' :: Int -> [a] -> [a]
drop' n xs | n >= length xs = [ ]
           | otherwise = [ x | (p,x) <- zip [1..(length  xs)] xs, p>n]
