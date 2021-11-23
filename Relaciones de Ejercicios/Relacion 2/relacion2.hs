-------------------------------------------------------------------------------
-- Estructuras de Datos. 2º Curso. ETSI Informática. UMA
--
-- (completa y sustituye los siguientes datos)
-- Titulación: Grado en Ingeniería del Software.
-- Alumno: Alemán Rando, Álvaro
-- Fecha de entrega: DIA | MES | AÑO
--
-- Relación de Ejercicios 2. Ejercicios resueltos: ..........
--
-------------------------------------------------------------------------------
import Test.QuickCheck
import Test.QuickCheck (Arbitrary)
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