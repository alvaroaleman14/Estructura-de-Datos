-------------------------------------------------------------------------------
-- Estructuras de Datos. 2º Curso. ETSI Informática. UMA
--
-- 
-- Titulación: Grado en Ingeniería del Software.
-- Alumno: Alemán Rando, Álvaro
-- Fecha de entrega: DIA | MES | AÑO
--
-- Relación de Ejercicios 3. Ejercicios resueltos: ..........
--
-------------------------------------------------------------------------------



-- Ejercicio 1. Haskell 

module WellBalanced where
   import DataStructures.Stack.LinearStack
   import Test.QuickCheck

   wellBalanced :: String -> Bool

   wellBalanced xs = wellBalanced' xs empty


   wellBalanced' :: String -> Stack Char -> Bool

   wellBalanced' [] s = isEmpty s

   wellBalanced' (x:xs) s
   
    | isOpen x   = wellBalanced' xs (push x s)

   
    | isClosed x = if (match (top s) x ) then wellBalanced' xs (pop s) else False
   
    | otherwise = wellBalanced' xs s



   isOpen x = elem x "([{"

   isClosed x = elem x ")]}"



   match '(' ')' = True

   match '[' ']' = True

   match '{' '}' = True

   match _ _ = False