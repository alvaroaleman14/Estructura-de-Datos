-------------------------------------------------------------------------------
-- Estructuras de Datos. 2º Curso. ETSI Informática. UMA
--
-- (completa y sustituye los siguientes datos)
-- Titulación: Grado en Ingeniería del Software.
-- Alumno: Alemán Rando, Álvaro
-- Fecha de entrega: DIA | MES | AÑO
--
-- Relación de Ejercicios 1. Ejercicios resueltos: ..........
--
-------------------------------------------------------------------------------
import Test.QuickCheck
import Data.Bool (bool)
import Distribution.Simple.Utils (xargs)

-- Ejercicio 1
  -- a)
esTerna :: Integer -> Integer -> Integer -> Bool
esTerna x y z = if x^2+y^2 == z^2 then True else False

  -- b)
terna :: Integer -> Integer -> (Integer , Integer, Integer)
terna x y = if x>0 && y>0 && x>y then (x^2 - y^2 ,2*x*y , x^2 + y^2) else error "no se puede hacer terna"

  -- c)
p_ternas x y = x>0 && y>0 && x>y ==> esTerna l1 l2 h
  where
   (l1,l2,h) = terna x y

-- Ejercicio 2
intercambia :: (a,b) -> (b,a)
intercambia (x,y) = (y,x)

-- Ejercicio 3
  -- a)
ordena2 :: Ord a => (a,a) -> (a,a)
ordena2 (x,y) = if x>=y then (y,x) else (x,y)

p1_ordena2 x y = enOrden (ordena2 (x,y))
  where enOrden (x,y) = x<=y

{-
p1_ordena2 comprueba que los valores devueltos por la funcion
ordena2 estan ordenador de menor a mayor
-}

p2_ordena2 x y = mismosElementos (x,y) (ordena2 (x,y))
  where
    mismosElementos (x,y) (z,v) = (x==z && y==v) || (x==v && y==z)

{-
p2_ordena2 comprueba que los valores de dps tuplas son iguales entre
si
-}

  -- b)
ordena3 :: Ord a => (a,a,a) -> (a,a,a)
ordena3 (x,y,z) | x<=y = if y<=z then (x,y,z) else (x,z,y)
                | y<=x = if x<=z then (y,x,z) else (y,z,x)
                | otherwise = (z,x,y)


-- Ejercicio 4
  -- a)
max2 :: Ord a => a -> a -> a
max2 x y | x >= y = x
         | otherwise = y

 -- b)
p1_max2 x y = (x==max2 x y) || (y==max2 x y)
p2_max2 x y = ((max2 x y) >= x) && ((max2 x y) >= y)
p3_max2 x y = (x >= y) && (x == max2 x y)
p4_max2 x y = (y >= x) && (y == max2 x y)

-- Ejercicio 5
entre :: Ord a => a -> (a,a) -> Bool
entre x (y,z) | (x>=y) && (x<=z) = True 
              | otherwise = False

-- Ejercicio 6
iguales3 :: Eq a => (a,a,a) -> Bool 
iguales3 (x,y,z) | (x==y) && (y==z) = True
                 | otherwise = False

-- Ejercicio 7 
  -- a)
type TotalSegundos = Integer 
type Horas = Integer 
type Minutos = Integer 
type Segundos = Integer 

descomponer :: TotalSegundos -> (Horas,Minutos,Segundos)
descomponer x = (horas, minutos, segundos)
 where
  horas = div x 3600
  minutos = div (mod x 3600) 60
  segundos = mod x 60

  -- b)
p_descomponer x = x>=0 ==> h*3600 + m*60 + s == x
                  && entre m (0,59)
                  && entre s (0,59)
 where (h,m,s) = descomponer x


-- Ejercicio 8
unEuro :: Double 
unEuro = 166.386

 -- a)
pesetasAEuros :: Double -> Double 
pesetasAEuros x = x/unEuro

 -- b)
eurosAPesetas :: Double -> Double 
eurosAPesetas x = x * unEuro

 -- c)
-- p_inversas x = eurosAPesetas (pesetasAEuros x) == x

-- Ejercicio 9 
infix 4 ~=
(~=) :: Double -> Double -> Bool
x ~= y = abs (x-y) < epsilon
 where epsilon = 1/1000

p_inversas x = eurosAPesetas (pesetasAEuros x) ~= x

-- Ejercicio 10 
 -- a) 
raices :: Double -> Double -> Double -> (Double, Double)
raices x y z = if (y^2)-(4*x*z) == 0 then error "Raices no reales"
               else (sol1,sol2)
 where
   sol1 = (-y + sqrt ((y^2)-(4*x*z))) /2*x
   sol2 = (-y - sqrt ((y^2)-(4*x*z))) /2*x