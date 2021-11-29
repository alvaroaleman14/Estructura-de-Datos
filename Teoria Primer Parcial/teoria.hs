----------------------------------------------------------------------------------------------------------
------------------------------------------------- TEMA 1 -------------------------------------------------
----------------------------------------------------------------------------------------------------------


-- | 1. Características de Haskell
------------------------------------------------------------

{-
   Haskell = Puro + Tipado estático fuerte + Perezoso

   * Puro: los datos son inmutables (como las String de Java)

   * Tipado estático fuerte:
      - el tipo se establece en tiempo de compilación y no varía
      - no se pueden mezclar tipos incompatibles
      - no hay conversión implícita entre tipos (ni siquiera entre números)

   * Perezoso: sólo se evalúa lo necesario para obtener el resultado

     Ejemplos de pereza:

     La función `undefined` provoca un error, pero en los siguientes ejemplos
     no siempre es necesario evaluarla:

         [1,2,3,4]
         [1,2,undefined,4] -- error

         sum [1,2,3,4]
         sum [1,2,undefined,4] -- error

         length [1,2,3,4]
         length [1,2,undefined,4] -- funciona a pesar de undefined
-}

-- | 2. Notación currificada
------------------------------------------------------------

{-
   Notación currificada:

   En Matemáticas, los argumentos de una función se encierran entre
   paréntesis y se separan por comas. Es habitual que la multipicación se
   denote simplemente yuxtaponiendo los factores, sin que aparezca ningún operador.

       f(a,b) + c d

   En Haskell usamos notación currificada. La multiplicación se denota siempre por *,
   como es habitual. La aplicación de una función a sus argumentos se denota yuxtaponiendo
   la función y los argumentos, sin que aparezcan comas y paréntesis.

       f a b + c*d

   Sin embargo, si un argumento es compuesto, debe encerrarse entre paréntesis.

      f (a+1) b

   * Ejercicios de currificación

   Escribe las siguientes expresiones en notación currificada:

    f(x+y)     ----- >  f (x+y)

    f(x+1,y)   ----- >  f (x+1) y

    f(2*x,y+1) ----- >  f (2*x) (y+1)

    f(g(x))    ----- >  f (g x)

    f(x,g(y))  ----- >  f x (g y)

    g(f(x,y))  ----- >  g (f x y)

    g(x)+y     ----- >  g x + y

    f(x)*g(x)  ----- >  f x * g x

    f(x,y) + u*v   ----- >    f x y + u * v

    max(max(x,y+1), max(z,-z))  ----- >   max (max x (y+1)  max z (-z))

   * Ejercicios de descurrificación

   Escribe las siguientes expresiones currificadas en la notación habitual:

    f 2 + 3 - g x y + 7   --->   f(2)+3 - g(x,y)+7

    g (2+x) y * 6         --->   g(2+x,y)*6

    f g x                 --->   f(g,x)

    f (g x)               --->   f(g(x))

    f f f x               --->   f(f,f,x)

    max (abs (-7)) 6*x    --->   max(abs(-7),6)*x

    x f                   --->   
-}

-- | 3. Definición de funciones
------------------------------------------------------------

-- Partimos de ejemplos de funciones simples en C/C++/Java y las
-- definimos en Haskell.

-- | 4. Condicionales
------------------------------------------------------------

{-
   El condicional if then else en Haskell:

      - es una expresión, no una sentencia
      - el else es obligatorio!!
      - los tipos de then y else deben coincidir
-}

-- |
-- >>> máximoDeTres 7 9 2
-- 9
-- >>> máximoDeTres 17 6 12
-- 17

maximoDeTres :: Int -> Int -> Int -> Int 
maximoDeTres x y z = if x >= y && x >= z then x 
                     else if y >= z then y 
                     else z


-- | 5. Dualidad función/operador
------------------------------------------------------------

{-
   Una función binaria (div, max, ...) puede usarse como operador (infijo)
   si escribimos su nombre entre comillas simples invertidas (a la derecha de la
   tecla p)

     div x y == x `div` y
     max x y == x `max` y
-}

-- | 6. Evaluación de expresiones (ver transparencias)
------------------------------------------------------------

-- | 7. Tuplas
------------------------------------------------------------

{-
   El tipo tupla en Haskell:

   - las tuplas son como vectores
   - un valor de tipo tupla se escribe encerrando entre paréntesis sus componentes,
     separados entre sí por comas:

                  (exp_1, exp_2, ..., exp_n)

   - el número de componentes es fijo, n
   - cada componente exp_i puede ser de un tipo distinto
   - es un producto cartesiano
   - existe la tupla vacía: ()
   - no existe la tupla unitaria: (x)
-}

-- | 8. Funciones monomórficas
------------------------------------------------------------

{-
   Una función es monomórfica si los tipos de todos sus argumentos y
   el tipo de su resultado son concretos (empiezan por mayúscula).

   Todas las funciones que hemos visto hasta el momento son monomórficas.

   Tienen el tipo predefinido: Integer, Int, Bool, Char, String, ...
-}

-- | 9. Funciones polimórficas
------------------------------------------------------------

{-
   En Java podemos introducir un tipo genérico mediante <T>:

        public static <T> T identidad(T x) {
               return x;
        }

   donde T puede ser cualquier tipo Java. Es decir, son de tipo generico.

   Lo que Java llama genericidad en Haskell se llama polimorfismo.

   Una función es polimórfica si el tipo de al menos uno de sus argumentos
   o el tipo de su resultado no son concretos, sino que puede ser
   cualquier tipo Haskell.

   En Haskell si un tipo empieza por minúscula es una variable de tipo.
   Suelen utilizarse las primeras letras del alfabeto: a, b, c, ...

        identidad :: a -> a
        identidad x = x
-}

identidad :: a -> a   -- predefinida como id
identidad x = x

-- | 10. Funciones sobrecargadas
------------------------------------------------------------

{-
   En Java puedo restringir un tipo genérico:

         T extends Comparable<T>

   En Haskell puedo restringir una variable de tipo:

         Ord a => a

   Ord es una clase Haskell semejante a la interfaz Comparable de Java.
-}

-- | 11. Funciones parciales
------------------------------------------------------------

{-
   Una función se dice parcial si no está definida para algún valor
   de sus argumentos.

   Una función se dice total si está definida para todos los posibles
   valores de sus argumentos.

   Si una función es parcial, podemos elevar una excepción cuando no
   esté definida.
-}

-- | 13. La regla de sangrado
------------------------------------------------------------

{-
   En muchos lenguajes de programación se usan llaves {} para delimitar
   bloques (cuerpos de función, bucles, etc.).

   En Haskell no se usan llaves: el sangrado es significativo y
   determina la estructura del código.

   Una definición termina cuando se encuentra código que tiene el mismo
   o menos sangrado (o cuando se acabe el fichero).
-}




-- -->> PATRONES

{-
   Paso de parámetros y patrones:

   En lenguajes como Java/C/C++ el parámetro real (el que aparece en la llamada)
   es una expresión, mientras que el parámetro formal (el que aparece en la
   definición de la función) es una variable:


               Definición                                Invocación

             parámetro formal                            parámetro real
            (es una variable)                          (es una expresión)
                    |                                          |
                    |                                          |
          int f(int x) {                                   f(3 * 5)
              .....
          }


   En estos lenguajes el paso de parámetros consiste en inicializar el parámetro
   formal con el valor del parámetro real (x = 15). Es una operación incondicional
   que no puede fallar.

   En Haskell el parámetro real es una expresión y el parámetro formal es un
   patrón (no necesariamente una variable):

               Definición                                Invocación

             parámetro formal                            parámetro real
             (es un patrón)                            (es una expresión)
                  |                                            |
                  |                                            |
                f x = ...                                 f (3 * 5)


   En Haskell el paso de parámeros se realiza por correspondencia de patrones:
   el patrón (parámetro formal) puede imponer una restricción sobre el valor
   que puede tomar el parámetro real. Esto significa que el paso de parámetros
   está condicionado y puede fallar:

      1. Si el parámetro real no encaja con el patrón, el paso de parámetros
         falla y no se puede realizar

      2. Si el parámetro real encaja con el patrón, el paso de parámetros
         tiene éxito y las variables del patrón se inicializan al valor
         correspondiente del parámetro formal

   Los patrones disponibles para restringir los valores del parámetro real dependen
   del tipo del parámetro formal.
-}

esOrigen :: (Int, Int) -> Bool

{-
   En la función 'esOrigen' el parámetro formal es de tipo tupla. Veremos varios
   patrones para restringir el valor de la tupla de entrada.
-}

-- | Opción 1: PATRON VARIABLE

{-
   El patrón es simplemente una variable y, como en Java/C/C++, no impone ninguna
   restricción sobre el valor de la entrada: acepta cualquier valor del tipo (Int, Int).
-}

esOrigen x = fst x == 0 && snd x == 0

{-
   El inconveniente de esta solución es que dado que 'x' es una tupla, tenemos que
   utilizar las funciones 'fst' y 'snd' para acceder a sus componentes. La mayoría
   de las funciones que hemos definido hasta ahora usan solo patrones variable.
-}

-- | Opción 2: PATRON TUPLA

{-
   El patrón es una tupla y, a su vez, cada componente de la tupla se describe mediante
   un patrón: (patrón_1, patrón_2)
-}

esOrigen (x,y) = x == 0 && y == 0

{-
   En esta ocasión tenemos un patrón tupla '(x,y)' y cada componente
   es un patrón variable, 'x' e 'y'. Esto significa que la función
   acepta como entrada cualquier valor del tipo (Int,Int).  La ventaja
   respecto a la opción 1 es que podemos acceder a las componentes de la tupla
   sin necesidad de usar las funciones 'fst' y 'snd'.
-}

-- | Opción 3: PATRON CONSTANTE

{-
   El patrón es un valor concreto descrito mediante una constante. Es el patrón
   más restrictivo de todos: el parámetro real debe tomar exactamente el valor
   de esa constante; de lo contrario no encaja y el paso de parámetros fracasa.

   Cuando utlizamos patrones constantes es frecuente que las funciones se
   definan por casos: cada caso se describe en una ecuación independiente.
   Haskell trata de aplicar estas ecuaciones en el orden de aparición: si una
   ecuación no se puede aplicar (porque el patrón no encaja), se prueba con la
   siguiente. Solo se aplica la primera ecuación cuyo patrón encaja. Si ninguna
   ecuación es aplicable, el programa eleva una excepción.
-}

esOrigen (0, 0) = True   -- primero se prueba la primera ecuación
esOrigen x      = False  -- solo si la primera ecuación falla, se prueba la segunda

{-
   En esta ocasión tenemos en la primera ecuación un patrón tupla
   '(0,0)', cada componente es un patrón constante '0'. Por lo tanto,
   esa ecuación solo se puede aplicar si la entrada tiene el valor
   '(0,0)'. Esto no significa que la tupla de entrada deba ser
   literalmente '(0,0)'; también se puede aplicar a cualquier tupla
   cuyo valor sea '(0,0)', por ejemplo '(1-1, x * 0)'.
   Si la primera ecuación no es aplicable se intenta aplicar la segunda.
   En esta ocasión la segunda ecuación siempre es aplicable, porque
   utiliza un patrón variable que acepta cualquier valor del tipo '(Int,Int)'
-}

-- | Opción 4: PATRON SUBRAYADO

{-
   El patrón subrayado se escribe '_' y es como el patrón variable (acepta
   cualquier valor de entrada), excepto que no le da ningún nombre, por lo que
   no se puede utilizar en la definición de la función (a la derecha del '=').
-}

esOrigen (0, 0) = True
esOrigen _      = False

{-
   Observa que la segunda ecuación no hace uso del parámetro: no necesitamos ni
   darle un nombre ni acceder a sus componentes: solo necesitamos saber que
   está ahí.
-}

{-
   Resumen de patrones:

   Los patrones no solo se aplican a las tuplas: se aplican a todos los tipos
   Haskell. A continuación resumimos los patrones que hemos estudiado.

        Patrón                            Significado

         x                        PATRON VARIABLE              -> acepta cualquier valor y le da un nombre

       (patrón_1,...,patrón_n)    PATRON TUPLA de dimensión n  -> permite imponer restricciones
                                                                  sobre los componentes y acceder a los mismos

         n                        PATRON CONSTANTE             -> solo acepta el valor literal de la constante

         _                        PATRON SUBRAYADO             -> acepta cualquier valor pero lo de da nombre
-}





----------------------------------------------------------------------------------------------------------
------------------------------------------------- TEMA 2 -------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- | 1. El tipo lista
------------------------------------------------------------

{-
   Una lista se escribe como una secuencia de expresiones separadas
   por comas y encerradas entre corchetes:

                   [e1, e2, e3, ..., en]

   Por ejemplo:

                   [1, 2, 3, 4, 5]

                   [7, 1, -6]

                   ['a', 'b', 'c']

                   [1 < 2]

                   []

   El tipo de una lista se escribe entre corchetes:

                  ['a', 'b', 'c'] :: [Char]

                  [1 + 1 == 2, 'a' < 'b'] :: [Bool]

                  [True] :: [Bool]

   Diferencia con las tuplas:

         1. todos los elementos deben tener el mismo tipo
         2. la longitud de la lista puede variar (no afecta a su tipo)

   Las listas son instancia de las clases Eq y Ord siempre que el
   tipo de los elementos sea instancia de Eq y Ord. La comparación
   se hace en orden lexicográfico:

                  [1, 1+1, 3] == [1, 2, 3]

                  [5, 7, 9] < [5, 7, 3]

   Las listas de tipo base Char se pueden escribir como cadenas:

                  ['a', 'b', 'c'] es lo mismo que "abc"

   Al tipo [Char] también se le llama String:

                  "abc" :: String
-}

{-
   Ejercicio: tipar las siguientes expresiones asumiendo que las expresiones
   numéricas son de tipo Int.

      [1, 2, 3] :: [Int]

      "1,2,3" :: String

      [ ('a', 8), ('t', 6) ] :: [(Char, Int)]

      [ (True) ] :: [Bool]

      ( [True] ) :: [Bool]

      [ (False, '0'), (True, '1') ] :: [(Bool, Char)]

      ( [False, True], ['0', '1'] ) :: ([Bool], String)     -- una lista de char es un string

      [ [], [2, 3] ] :: [[Int]]

      [ ["a"] ] :: [[String]]

      [ ['a'] ] :: [String]

      [ (), (), () ] :: [()]

      ( [] ) :: [a]     -- el tipo que sea

      [ 1 == 1 + 1, -3 < 3 ] :: [Bool]

      [ 1 == 1 + 1, undefined, -3 < 3 ] :: [Bool]

      [ error "algo va mal" ] :: [a]
-}

-- | 2. Funciones predefinidas sobre listas
------------------------------------------------------------

{-
   Las siguientes funciones están predefinidas y las podemos usar
   sin importarlas. Observa que algunas de estas funciones son totales
   y otras son parciales.
   
      "" == []                    -- las comillas equivalen a una lista vacia

      null :: [a] -> Bool

      head :: [a] -> a

      last :: [a] -> a

      tail :: [a] -> [a]

      init :: [a] -> [a]

      take :: Int -> [a] -> [a]

      drop :: Int -> [a] -> [a]


       head              tail
        |   ------------------------------
       [x1, x2, x3, ............, xn-1, xn]
        ------------------------------  |
                    init               last

       -------------- + -----------------
            take              drop

      length :: [a] -> Int

      elem :: Eq a => a -> [a] -> Bool

      notElem :: Eq a => a -> [a] -> Bool

      reverse :: [a] -> [a]

      (++) :: [a] -> [a] -> [a]
-}

-- | 3. QuickCheck sobre listas
------------------------------------------------------------

{-
   Podemos usar QuickCheck para comprobar las siguientes propiedades
   de la concatenación (++) de listas:

      1. La lista vacía es el elemento unidad de la concatenación
      2. la concatenación de listas es asociativa
-}

-- | 4. Constructores de listas
------------------------------------------------------------

{-
   Aunque escribamos las listas de esta manera:

                         [2, 3, 5, 7]

   esta notación es azúcar sintáctico; es decir, una notación que
   nos facilita el lenguaje para escribir algo de forma más concisa
   y legible, pero que realmente ya se podía escribir de forma primitiva
   en el lenguaje.

   En Haskell las listas se construyen a partir de dos constructores:

         1. la constante [], que representa la lista vacía

         2. el operador (:), que sirve para construir una lista a partir de:

                - su cabeza (primer elemento)
                - su cola (lista con el resto de sus elementos)

   El tipo de estos constructores es el siguiente:

             [] :: [a]
             (:) :: a -> [a] -> [a]

   Observa que el operador (:) permite diferenciar dos partes en la lista;
   su cabeza y su cola:

                         (cabeza : cola) :: [a]
                            |       |
                            a      [a]

   Todas las listas que hemos escrito hasta el momento se pueden reescribir
   de forma primitiva usando estos constructores, pero es más engorroso:

            [2] --> 2 : []

            [2, 3] --> 2 : 3 : []

            [2, 3, 5] --> 2 : 3 : 5 : []

            [2, 3, 5, 7] -> 2 : 3 : 5 : 7 : []

   Obviamente, podemos combinar la notación primitiva con azúcar sintáctico, por
   ejemplo:

            2 : [3,5,7]

   Normalmente escribimos un valor de tipo lista usando azúcar sintáctico.
   La notación basada en constructores suele usarse para escribir patrones
   para listas.
-}

-- | 5. Patrones para listas
------------------------------------------------------------

{-
   Recuerda que en Haskell un parámetro formal es un patrón y que sirve
   para imponer condiciones sobre el valor que puede tomar la entrada
   (parámetro real).

   Se usa para definir funciones por casos; por ejemplo, para el caso de
   las tuplas:
-}

-- | 6. Recursividad sobre listas
------------------------------------------------------------

{-
   * 6.1 Las listas son una estructura recursiva

   Recuerda que las listas se construyen con dos constructores:

            []       - lista vacía
            x : xs   - lista no vacía con cabeza y cola

   Observa que la cola de una lista es también una lista: una lista
   de longitud n está formada por una cabeza seguida por una lista
   de longitud n-1; por ejemplo:

                           lista de longitud 5
                                  |
                     --------------------------
                     2 : (3 :  5 : 7 : 11 : [])
                    /    ----------------------
                cabeza           |
                               cola
                          lista de longitud 4

   Esto quiere decir que la lista es una estructura de datos recursiva:
   una lista contiene una lista que a su vez contiene una lista,...
   El caso base es la lista vacía [], que como su nombre indica no
   contiene nada.

   * 6.2 Proceso recursivo de listas

   Dado que las listas son recursivas, es habitual resolver problemas
   sobre listas aplicando recursión. Por ejemplo, si queremos calcular
   la suma de los elementos de una lista:

                       sumar [2,3,5,7,11]

   calculamos primero la solución para la cola (que tiene un elemento
   menos):

                       sumar [2,3,5,7,11]
                                --------         solución de la cola
                                   |            /
                         sumar [3,5,7,11]  =  26

   Una vez que conocemos la solución de la cola, solo tenemos que tener
   en cuenta la cabeza (el elemento que nos saltamos) y "añadirlo" a la
   solución de la cola:

                                    añadir cabeza   solución total
                                              \          /
                       sumar [2,3,5,7,11]  =  2 + 26 = 28
                                --------           \
                                |                  solución de la cola
                                |                /
                         sumar [3,5,7,11]  =  26

   En cada paso de la recursión la longitud de la lista a procesar
   disminuye en 1. El proceso recursivo de listas finaliza cuando alcanzamos
   el caso base: la lista vacía. Es habitual que los casos base tengan
   una solución inmediata:

                       sumar [] = 0

   Podemos resumir todo el proceso recursivo en el siguiente esquema:

                f (x:xs) --------- "añadir" x a la solución de la cola
                   |                    |
                 f xs    --------- solución de la cola
                   .                    .
                   .                    .
                   .                    .
                 f []    --------- solución caso base

   * 6.3 Definición de funciones recursivas sobre listas

   Las funciones recursivas sobre listas se definirán por casos y
   tendrán al menos dos casos:

      - un caso base: suele ser la lista vacía y tener solución inmediata

      - un caso recursivo: suele ser la lista no vacía (con cabeza y cola)
        y "añade" la cabeza a la solución de la cola, que se calcula en la
        llamada recursiva

   Estos dos casos se pueden expresar en Haskell con dos ecuaciones con
   patrones:

           f []     = solución caso base

           f (x:xs) = añadir x (f xs)
                                 \
                          solución de la cola
                          (llamada recursiva)

   Este esquema se puede aplicar de manera casi mecánica al definir funciones
   recursivas. La parte creativa consiste en determinar para cada problema:

       - ¿cuál es la solución base?
       - ¿cómo se "añade" la cabeza a la solución de la cola?

   Sin embargo, es muy importante entender que no todos los problemas de recursión
   sobre listas se ajustan al esquema anterior.

   La mayoría de las estructuras de datos que estudiaremos son recursivas
   y, por consiguiente, la mayoría de las funciones que las procesan serán
   también recursivas.
-}

-- | 7. Recursividad con acumulador
------------------------------------------------------------

{-
   * 7.1 Recursión con acumulador

   La recursión sobre listas funciona calculando la solución para la
   cola:

                problema [3,5,7,11,13]
                            ---------
                               |
                       solución de la cola

   Una vez que hemos calculado la solución de la cola, "añadimos" la
   cabeza para obtener la solución de toda la lista.

   También es posible resolver los problemas con un esquema alternativo
   que no se "salta" elementos y después los "añade"; sino que va
   calculando la solución de los elementos que ya se han visitado.

   Por ejemplo si queremos calcular la suma de los elementos de una lista:

                    sumar [3,5,7,11,13]

   después de haber visitado los dos primeros elementos la situación es
   la siguiente:

                    sumar [7,11,13]     8
                                        |
                           solución de los visitados [3,5]

   Cada vez que visitamos un elemento, lo "añadimos" a la solución de los
   visitados. Por ejemplo, al visitar el tercer elemento obtenemos:

                                  solución de los visitados [3,5,7]
                                                 |
                    sumar [11,13]       8 + 7 = 15
                                       /     \
                                      /   añadir recién visitado
                                     /
                   solución de anteriormente visitados [3,5]

   Obviamente, cuando alcanzamos la lista vacía (el caso base), la
   solución de los visitados es la solución para toda la lista.

   Queda aún una cuestión por decidir: ¿cuánto vale la solución de los
   visitados cuando aún no hemos visitado ningún elemento? La solución
   es simple: debe ser la solución para la lista vacía.

   Para almacenar la solución de los elementos visitados utilizamos
   un acumulador; por ello a este esquema recursivo se le llama recursión
   con acumulador. Por tanto el esquema utiliza dos parámetros:

      - la lista sobre la que se aplica la recursión
      - un acumulador con la solución del prefijo de los elementos visitados

   Para el ejemplo de la suma de elementos de una lista, la recursión con
   acumulador procede de la siguiente manera:

                  xs                    ac

         sumar [3,5,7]                  0  (solución para [])
         sumar   [5,7]                  3  (añadir 3 al acumulador)
         sumar     [7]                  8  (añadir 5 al acumulador)
         sumar      []                 15  (añadir 7 al acumulador)

   Al llegar a la lista vacía, el acumulador contiene la solución.

   Podemos resumir todo el proceso recursivo en el siguiente esquema:

                f (x:xs) ---------   inicializar acumulador
                   |                           |
                 f xs    ---------   "añadir" x a acumulador
                   .                           .
                   .                           .
                   .                           .
                 f []    --------- el acumulador contiene la solución

   * 7.2 Definición de funciones recursivas con acumulador

   Las funciones recursivas con acumulador sobre listas son uno poco
   más laboriosas de definir porque esta recursión debe manejar dos
   argumentos: la lista y el acumulador.

   El punto de entrada a una función recursiva con acumulador es una
   función 'f' que solo recibe la lista y se limita a invocar a la
   función recursiva 'fRecAc' con el acumulador inicializado:

                     valor inicial del acumulador
                         (solución para [])
                              /
           f xs = fRecAc xs ac0
                    \
            función recursiva con acumulador

   La función recursiva con acumulador 'fRecAc' suele definirse de manera
   local a 'f' y es una función recursiva con dos casos:

      - un caso base: suele ser la lista vacía y la solución ya está en el acumulador

      - un caso recursivo: suele ser la lista no vacía (con cabeza y cola)
        y "añade" la cabeza al acumulador; la llamada recursiva recibe la cola
        de la lista y el acumulador con la cabeza añadida

   Estos dos casos se pueden expresar en Haskell con dos ecuaciones con  patrones:

           f xs = fRecAc xs ac0
              where                la solución está en el acumulador
                                  /
                 fAc []     ac = ac

                 fAc (x:xs) ac = fAc xs (añadir x ac)
                                              \
                                     acumulador actualizado

   Este esquema se puede aplicar de manera casi mecánica al definir funciones
   recursivas con acumulador. La parte creativa consiste en determinar para cada
   problema:

       - ¿cuál es la solución base?
       - ¿cómo se "añade" la cabeza al acumulador?

   Sin embargo, es muy importante entender que no todos los problemas de recursión
   sobre listas con acumulador se ajustan al esquema anterior.

   La recursión con acumulador no es natural como la recursión sobre listas, pero
   en algunos casos puede ser más eficiente (ver transparencias).
-}

-- | 8. Orden superior sobre listas: map y filter
------------------------------------------------------------

{-
   Las funciones anteriores se parecen mucho y conceptualmente siguen
   el mismo esquema:

        lista de entrada:   [  x1,   x2,   x3 ...    xn ]
                               |     |     |         |
        lista de salida:   [ f x1, f x2, f x3, ... f xn ]

   Lo que varia de una función a otra es:

      - el tipo de las listas de entrada y salida
      - la función 'f'

   Podemos abstraer y parametrizar:

      - el tipo mediante polimorfismo
      - la función 'f' mediante orden superior (pasar la función como parámetro)
-}

-- | 9. Funciones como valores
------------------------------------------------------------

{-
   Supongamos un tipo básico como Int.

   ¿Qué podemos hacer con un valor de tipo Int?
-}

-- almacenarlo en una variable:

unEntero :: Int
unEntero = 5

-- almacenarlo en una estructura de datos:

listaDeEnteros :: [Int]
listaDeEnteros = [unEntero, 6, 1, 27]

-- pasarlo como parámetro o devolverlo como resultado de una función:

inc :: Int -> Int
inc x = x + 1

-- aplicarle ciertas operaciones (+,*,<,...)

-- escribirlo literalmente; por ejemplo 5

{-
    Idea clave de la programación funcional:

       - las funciones son valores
       - podemos hacer con ellas las mismas cosas que con un valor de Int
-}

-- almacenar función en una variable:

unaFunc :: Int -> Int
unaFunc = inc

-- almacenar función en una estructura de datos:

listaDeFunciones :: [Int->Int]
listaDeFunciones = [unaFunc, abs, cuadrado]

-- pasar una función como parámetro a una función:

twice :: (Int->Int) -> Int -> Int
twice f x = f (f x)

-- devolverla como resultado de una función:

elige :: Bool -> (Int->Int)
elige x = if x then inc
          else cuadrado

-- aplicarle cierta operación; la aplicación de la función a un valor: f x

-- escribirla literalmente mediante lambda expresiones

-- | 10. Lambda expresiones o funciones anónimas
------------------------------------------------------------

{-
   Para escribir literalmente el valor de una función utilizamos
   lambda-expresiones, también llamadas funciones anónimas.

   Las lambda-expresiones son especialmente útiles para pasar una
   función como parámetro. Por ejemplo, podemos reescribir cubos
   usando una lambda expresión.
-}

cubos' :: [Integer] -> [Integer]
cubos' xs = map (\ x -> x * x * x) xs

-- | 11. Secciones
------------------------------------------------------------

{-
   Una sección es un operador binario que recibe un solo
   argumento, que puede ser el izquierdo o el derecho; por ejemplo:

              (+3)

              (2*)

   La sección espera recibir el otro argumento para aplicar el operador,
   por lo que una sección es una función unaria:

              (+3)  5

              (2*)  7

   Si el operador no es conmutativo, el orden de la sección importa:

              (^2)  5

              (2^)  5

   Una sección es realmente azúcar sintáctico para una lambda expresión:

            (@n) ---> \ x -> x @ n
            (n@) ---> | x -> n @ x
-}

-- | 12. Parcialización
------------------------------------------------------------

{-
   Una sección es un operador binario que recibe un solo argumento y
   devuelve una función unaria que espera el otro operando.

   Esa idea se puede generalizar a cualquier función, no solo a
   operadores binarios: una función de n argumentos puede ser invocada
   con k argumentos (k <= n).

   Cuando k < n:

       1) se pasan los primeros k argumentos
       2) se devuelve una función que espera los n-k restantes argumentos
-}

-- | 13. Composición de funciones
------------------------------------------------------------

{-
   En cálculo se define la composición de funciones de la siguiente
   manera:

      f o g (x) = f (g(x))

   En Haskell también está definida la composición de funciones:

      (f . g) x = f (g x)

   Primero se aplica 'g' a 'x', y al resultado se le aplica 'f'.

   --> Ejemplo de composición:

      El cifrado César consiste en reemplazar cada carácter de un mensaje
      en claro por el carácter que está 'n' posiciones más adelante en el
      alfabeto; por ejemplo, para n = 3 tenemos:

      alfabeto     : "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      alfabeto + 3 : "DEFGHIJKLMNOPQRSTUVWXYZ[\]"

         cifrar("ATACAZ", 3)  --> "DWDFD]"
         descrifrar("DWDFD]", 3) --> "ATACAZ"
-}

-- | 14. Plegado a la derecha
------------------------------------------------------------

{-
   Recuerda que la mayoría de las funciones recursivas sobre listas
   siguen el siguiente esquema en Haskell:

          fun []     = solCasoBase
          fun (x:xs) = añadir x (fun xs)

   La parte creativa consiste en determinar:

      - 'solCasoBase', la solución del caso base (suele ser inmediato)

      - 'añadir', la función que "añade" la cabeza 'x' a la solución
        de la cola '(fun xs)'

   Recuerda también que los operadores binarios se pueden escribir
   como funciones prefijas; por ejemplo:

                  x +  suma xs

   se puede escribir como:

                  (+) x (suma xs)

   Este truco permite escribir todas las siguientes funciones
   recursivas aplicando el mismo esquema.

   Es obvio que las funciones anteriores se aparecen mucho. Podemos
   hacer como con 'map' y 'filter' y abstraer las diferencias:

     - todas las funciones tienen el tipo [a] -> b

     - todas las funciones necesitan un valor para solCasoBase

     - todas las funciones necesitan una función que añada la cabeza a
     la solución de la cola

   A veces la función que "añade" la cabeza a la solución de la cola
   es un poco más complicada. Por ejemplo, puede incluir un
   condicional. En tal caso, podemos definirla localmente en un where:

           fun []     = solCasoBase
           fun (x:xs) = f x (fun xs)
             where
                 f cabeza cola = ...
-}

-- | 15. Plegado a la izquierda
------------------------------------------------------------

{-
   Recuerda que la mayoría de las funciones recursivas con acumulador
   sobre listas siguen el siguiente esquema en Haskell:

          fun xs = funAc xs solCasoBase
             where
               fun []     ac = ac
               fun (x:xs) ac = funAc  x (actualiza ac x)

   La parte creativa consiste en determinar:

      - 'solCasoBase', la solución del caso base (suele ser inmediato)

      - 'actualiza', la función que "actualiza" el acumulador 'ac'
        para que tenga en cuenta la cabeza 'x' (el acumulador debe ser
        la solución de la prefijo visitado)

   Las siguientes funciones aplican recursión con acumulador (de nuevo aplicamos
   el truco de escribir los operadores como funciones prefijas).
-}

-- | 16. Secuencias aritméticas
------------------------------------------------------------

{-
   En Matemáticas es frecuente trabajar con sucesiones aritméticas,
   una sucesión donde la diferencia entre elementos consecutivos se
   mantiene constante; por ejemplo:

       3, 7, 11, 15, 19, 23, ...

   En Haskell podemos definir listas que representan una sucesión
   aritmética posiblemente acotada. En el caso más simple, definimos
   una secuencia aritmética acotada indicando su primer y último
   elementos, asumiendo que la diferencia es 1:

   Para definir secuencias aritméticas en las que la diferencia no sea
   1, basta facilitar los dos primeros elementos de la misma. Haskell
   calcula la diferencia entre estos dos elementos y la emplea para
   generar la secuencia aritmética:

   También es posible definir secuencias aritméticas infinitas (no
   acotadas). Basta omitir el extremo superior (o inferior, si es
   decreciente):
-}

-- | 17. Listas por comprensión
------------------------------------------------------------

{-
   En Matemáticas es posible definir un conjunto por enumeración,
   indicando uno a uno sus elementos:

         {0, 2, 4, 9, 16, 25, 36, 49, 64, 81, 100}

   Una técnica más potente es la definición de conjuntos por
   comprensión, que permite construir nuevos conjuntos a partir de
   otros conjuntos:

         { x^2 / x pertenece a {1..10} }

    La definición por comprensión permite definir conjuntos infinitos:

         { x^2 / x pertenece a N }

    ¿Qué representa el siguiente conjunto?

         { (x,y) | (x,y) pertenece a (R,R) y x^2 + y^2 <= r^2 }

     Similarmente, en Haskell podemos definir listas por comprensión,
     es decir, listas definidas a partir de otras listas.

     La sintaxis básica es:

         [ expresión | patrón <- lista ]

     donde la expresión `patrón <- lista` es un generador que visita uno
     a uno los elementos de la lista.
-}

-- | 18. Tipos Algebraicos
------------------------------------------------------------

{-
   Además de trabajar con los tipos predefinidos (tuplas, listas,...),
   en Haskell un programador puede definir sus propios tipos.

   En Java la herramienta fundamental para definir nuevos tipos es la
   clase:

              class NuevaClase {
                      ...
              }

   En Haskell usaremos tipos algebraicos, que declararemos con la
   palabra reservada `data`:

                            declaración de los valores del tipo
                                 /
              data NuevoTipo = ...
                       \
               nombre del nuevo tipo
              (empieza en mayúscula)

   Según la forma de la declaración de los valores del nuevo tipo,
   clasificaremos los tipos algebraicos en:

             - enumerado
             - unión
             - producto
             - general
             - parametrizados
-}

{-
   * Tipo enumerado

   Los tipos algebraicos más simples son los enumerados. La declaración
   simplemente enumera los posibles valores del tipo:

                           constructor de datos
                          (empieza en mayúscula)
                                  /
          data TipoEnumerado = Valor_1 | Valor_2 | ... | Valor_n

   A los valores se les llama constructores de datos, porque sirven
   para construir un valor del nuevo tipo.
-}

data Direction = North | South | East | West
                 deriving (Show, Eq, Ord)

{-
   La declaración de un tipo algebraico puede incluir una cláusula
   `deriving`:

          data TipoEnumerado = Valor_1 | Valor_2 | ... | Valor_n
                               deriving (Clase_1, Clase_2,...)
                                           /
                                   clase de tipo


   Haskell deriva automáticamente la instancia correspondiente para
   cada clase de tipo mencionada; es decir, genera el código de las
   funciones de la clase de tipo (es como si Java completara
   automáticamente la implementación de una interfaz).

   En general derivaremos instancias para las clases:

          - Show: para imprimir los valores en pantalla
          - Eq: para comparar por igualdad
          - Ord: para establecer un orden total

   Si no incluimos una cláusula `deriving`, tendremos que definir
   manualmente la instancia de la clase o nuestro tipo no soportará
   las operaciones de esa clase.
-}

{-
   * TIPO UNION

   Un tipo unión declara varios constructores de datos, cada
   constructor de datos va acompañado de un único argumento:

                                    tipo del argumento
                                          /
         data TipoUnion = Constructor_1 Arg_1 | Constructor_2 Arg_2 | ...
-}

--           Constructor Argumento
--               \        /
data Degrees = Celsius Double
             | Fahrenheit Double
             deriving Show

{-
   * TIPO PRODUCTO

   Un tipo producto declara un solo constructor de datos que puede recibir varios
   argumentos:

                          constructor único
                                   /
          data TipoProducto = Constructor Arg_1 Arg_2 .. Arg_n
                                                         /
                                                 varios argumentos

   Se le llama tipo producto porque es un producto cartesiano de los
   tipos de los argumentos.
-}

--        Constructor    Argumentos
--             \           /
data Persona = P  String String Int deriving Show

{-
   En la declaración de tipo anterior no queda muy claro cuál es el
   papel de cada uno de los argumentos de tipo `String`.

   Podemos hacer más legible nuestra declaración mediante sinónimos
   de tipo:

               type NuevoNombre = TipoExistente

   La diferencia entre `data` y `type` es que el primero introduce un
   nuevo tipo, mientras que el segundo introduce un nombre alternativo
   para un tipo existente.
-}

type Name = String
type Surname = String
type Age = Int

--        Constructor    Argumentos
--             \           /
data Person = Pers  Name Surname Age deriving Show

{-
   * TIPO GENERAL

   Un tipo algebraico general es un tipo que combina varios productos:

        data TipoGeneral = Constructor_1 Arg_1 .. Arg_n
                         | ...
                         | Constructor_m Arg_1 .. Arg_k

   Es una suma de productos, por eso a estos tipos se les llama
   algebraicos.
-}

data Complejo = Cartesianas Double Double
              | Polar Double Double
              deriving Show

{-
   * TIPO PARAMETRIZADO

   Un tipo parametrizado toma otros tipos como parámetro, como las clases
   genéricas de Java (ArrayList<T>):

                           tipo parámetro
                                  /
          data TipoParametrizado a = Constructor a
                                                /
                                    argumento de un tipo a

   Al igual que en Java (Map<Integer, String>), podemos tomar varios
   tipos como parámetro:

          data TipoParametrizado a b = Constructor a b
-}

{-
   * TIPO MAYBE

   Haskell define un tipo parametrizado `Maybe` que es muy útil para representar
   resultados opcionales:

               data Maybe a = Nothing
                            | Just a

   Si una función es parcial (no está definida para todas sus
   entradas) la podemos hacer total haciendo que devuelva un resultado
   de tipo `Maybe`.
-}





----------------------------------------------------------------------------------------------------------
------------------------------------------------- TEMA 3 -------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- STACK 

data Stack a = Empty
             | Node a (Stack a)
             deriving (Show, Eq)

empty :: Stack a
empty = Empty

push :: a -> Stack a -> Stack a
push x p = Node x p

pop :: Stack a -> Stack a
pop Empty       = error "Pila vacia"  -- no se puede eliminar un elemento de una pila vacia
pop (Node x p)  = p                   -- le quito el elemento x a la pila p

top :: Stack a -> a
top Empty       = error "Pila vacia, no tiene top"
top (Node x p)  = x

isEmpty :: Stack a -> Bool
isEmpty Empty       = True
isEmpty (Node x s)  = False

{-
   Constructores:    `push` y `empty`
   Sselectores:      `isEmpty`, `top`
   Transformadores:  `pop`

   Así, por ejemplo, para especificar la operación `isEmpty` tenemos
   que especificar qué devuelve `isEmpty` cuando se aplica a una Pila
   construida con `empty` o con `push`. Esto lo especificaremos
   mediante propiedades QuickCheck. La ventaja de usar propiedades
   QuickCheck es que podremos comprobar si nuestras implementaciones
   de la Pila son correctas.
-}


-- QUEUE

data Queue a = Empty 
             | Node a (Queue a)
             deriving (Eq, Show)

empty :: Queue a
empty = Empty

isEmpty :: Queue a -> Bool
isEmpty Empty  = True
isEmpty _      = False

first :: Queue a -> a
first Empty       = error "first sobre cola vacia"
first (Node x _)  = x

dequeue :: Queue a -> Queue a
dequeue Empty        = error "dequeue sobre cola vacia"
dequeue (Node _ q)   = q

enqueue :: a -> Queue a -> Queue a
enqueue x Empty      = Node x Empty
enqueue x (Node y q) = Node y (enqueue x q)

{-
   Constructores:    `enqueue` y `empty`
   Selectores:       `isEmpty`, `first`
   Transformadores:  `dequeue`
-}


-- SET

data Set a = Empty
          | Node a (Set a)
          deriving (Show, Eq)

{-
   * Eligiendo la representación interna del TAD Conjunto:

   Queremos utilizar el tipo algebraico `Set` arriba definido para
   representar conjuntos como el siguiente:

        insert 7 (insert 1 (insert 2 (insert 1 (insert 5 empty))))

   Observa que al construir el conjunto los elementos no se han
   facilitado en orden y, además, uno de los elementos aparece
   repetido.

   El implementador del TAD Conjunto debe decidir cómo representar el
   conjunto anterior. Por ejemplo, puede decidir representar los
   conjuntos apilando los elementos conforme se insertan:

        Node 7 (Node 1 (Node 2 (Node 1 (Node 5 Empty))))

   esto significa que la representación puede contener elementos
   repetidos.

   Otra posibilidad es que el implementador decida almacenar los
   elementos ordenados y sin repeticiones:

        Node 1 (Node 2 (Node 5 (Node 7 Empty)))

   Ambas representaciones son correctas, aunque obviamente no son
   equivalentes.

   *****  Ejercicio: ¿Qué ventajas e inconvenientes tiene cada una de estas
          representaciones internas? ¿Cómo afecta al usuario la elección?
               LA IMPLEMENTACION ES BUENA PARA EL INSERT (MUY EFICIENTE), 
               PERO MALA PARA EL DELETE (MUY INEFICIENTE)

   * Invariante de representación:

   Un invariante de representación de un TAD es una propiedad
   (booleana) sobre la representación interna del TAD.

   Este invariante debe ser cierto para todo valor del TAD:

     - antes de aplicar una operación pública del TAD
     - después de aplicar una operación pública del TAD

   sin embargo, el invariante puede ser falso durante la aplicación de
   una operación pública o al aplicar operaciones privadas.

   En la práctica, esto significa que todo valor del TAD que manipula
   el código del cliente satisface el invariante, pues ha sido
   construido por las operaciones públicas del TAD.

   La primera representación que hemos propuesto antes, basada en
   apilar elementos conforme se insertan:

        Node 7 (Node 1 (Node 2 (Node 1 (Node 5 Empty))))

   no satisface ningún invariante interesante.

   Sin embargo, la segunda representación:

        Node 1 (Node 2 (Node 5 (Node 7 Empty)))

   satisface un invariante muy importante: los elementos aparecen
   ordenados y sin repetidos.

   Es obligación del implementador del TAD asegurar que todos los
   valores del TAD satisfacen este invariante. Mantener este
   invariante supone un esfuerzo adicional, pero se ve recompensado
   porque simplifica la implementación de ciertas operaciones y mejora
   la eficiencia.
-}

-- invariante: ordenado y sin repetidos (<)
sample :: Set Char
sample = Node 'a' (Node 'c' (Node 'f' (Node 'z' Empty)))

empty :: Set a
empty = Empty

isEmpty :: Set a -> Bool
isEmpty Empty  = True
isEmpty _      = False

isElem :: Ord a => a -> Set a -> Bool
isElem x Empty      = False
isElem x (Node y s) 
     | x == y       = True
     | x < y        = False        -- al estar ordenado ascendentemente se da por hecho que no está x
     | otherwise    = isElem x s

insert :: Ord a => a -> Set a -> Set a
insert x Empty      = Node x Empty
insert x (Node y s) 
     | x == y       = Node y s
     | x < y        = Node x (Node y s)
     | otherwise    = Node y (insert x s)

delete :: Ord a => a -> Set a -> Set a
delete _ Empty      = Empty
delete x (Node y s) 
     | x == y       = s
     | x < y        = Node y s
     | otherwise    = delete x s

union :: Ord a => Set a -> Set a -> Set a
union Empty s2                = s2
union s1 Empty                = s1
union (Node x s1) (Node y s2)
     | x == y  = Node x (union s1 s2)
     | x < y   = Node x (union s1 (Node y s2))
     | x > y   = Node y (union (Node x s1) s2)

fold :: (a -> b -> b) -> b -> Set a -> b
fold f z s = recSet s
  where
    recSet Empty      = z
    recSet (Node x s) = f x (recSet s)

{-
   Constructores:    `empty`, `insert`
   Selectores:       `isEmpty`, `isElem`
   Transformadores:  `delete`
-}


-- BAG

data Bag a = Empty
           | Node a Int (Bag a) -- elemento y contador de apariciones
           deriving Eq

empty :: Bag a
empty = Empty

isEmpty :: Bag a -> Bool
isEmpty Empty  = True
isEmpty _      = False

insert :: Ord a => a -> Bag a -> Bag a
insert x Empty = Node x 1 Empty
insert x (Node y n b)
   | x == y    = (Node y (n+1)) b
   | x < y     = Node x 1 (Node y n b)
   | otherwise = Node y n (insert x b)

occurrences :: (Ord a) => a -> Bag a -> Int
occurrences _ Empty = 0
occurrences x (Node y n b)
   | x == y    = n
   | x < y     = 0
   | otherwise = occurrences x b

delete :: (Ord a) => a -> Bag a -> Bag a
delete _ Empty = Empty
delete x (Node y ny b)
   | x == y && ny > 1   = Node x (ny-1) b
   | x == y && ny == 1  = b
   | x < y              = Node y ny b
   | otherwise          = Node y ny (delete x b)

union :: Ord a => Bag a -> Bag a -> Bag a
union bag1 Empty     = bag1
union Empty bag2     = bag2
union (Node x1 n1 bag1) (Node x2 n2 bag2)
   | x1 == x2  = Node x1 (n1+n2) (union bag1 bag2)
   | x1 < x2   = Node x1 n1 (union bag1 (Node x2 n2 bag2))
   | otherwise = Node x2 n2 (union bag2 (Node x1 n1 bag1))

union' :: Ord a => Bag a -> Bag a -> Bag a
union' bag1 Empty     = bag1
union' Empty bag2     = bag2

intersection :: Ord a => Bag a -> Bag a -> Bag a
intersection _ Empty = Empty
intersection Empty _ = Empty
intersection (Node x1 n1 bag1) bag2
   | isElem    = Node x1 n1 (intersection bag1 bag2)
   | otherwise = intersection bag1 bag2
   where
      isElem = (occurrences x1 bag2) /= 0
