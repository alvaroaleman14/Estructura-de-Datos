
-- Relación 3 de ejercicios de la asignatura
-- Estructura de Datos
-- 2º de Ingenieria de Software, grupo A.

module WellBalanced where

import DataStructures.Stack.LinearStack

wellBalanced :: String -> Bool
wellBalanced xs  = wellBalanced' xs empty

wellBalanced' :: String -> Stack Char -> Bool
wellBalanced' [] s = isEmpty s
wellBalanced' (x:xs) s | isOpen x = wellBalanced' xs (push x s)
                       | isClosed x = if (match (top s) x) then wellBalanced' xs (pop s) else False
                       | otherwise = wellBalanced' xs s
    where
      isOpen x = elem x "([{"
      isClosed x = elem x ")]}"
      match '(' ')' = True
      match '[' ']' = True
      match '{' '}' = True
      match _ _ = False
