{-
  -- *We can use ghci to examine the types of expressions using the ':t expr'
  -- :: is read as 'has type of'
  --  empty tuple () is also a type which can only have a single value: ()
  -- Types are written in capital case
  -- We can also give a type declaration to our functions which is considered a good practice except when used for very short functions.
-}

removeNonUpperCase :: [Char] -> [Char]
removeNonUpperCase s =
  [ c
    | c <- s,
      c `elem` ['A' .. 'Z']
  ]

{-
  -- function removeNonUpperCase has the type [Char] -> [Char], which means that it maps a list of Chars to another list of Chars

  -- To write out the type of a function that takes multiple parameters
  -- *The parameters are separated with -> and there's no special distinction between the parameters and the return type. The return type is the last item in the declaration and the parameters are the first three.
  -- functions are expressions too, so :t works on them too
-}

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

{-
  -- if we check the type of the head function
  {-
    * ghci> :t head
    * head :: [a] -> a
  -}
  -- *The a here is not in capital case. Therefore, it is not a type. It is a type variable which means that 'a' can be of any type.
  -- Functions that have type variables are called polymorphic functions
  -- Although type variables can have names longer than a single character, it is a convention to write them as a, b, c, d,...

  -- NOTE
  {-
    * ghci> :t fst
    * fst :: (a, b) -> a

    * We see that fst takes a tuple which contains two types and returns an element which is of the same type as the pair's first component. That's why we can use fst on a pair that contains any two types. Note that just because a and b are different type variables, they don't have to be different types. It just states that the first component's type and the return value's type are the same.
  -}

 -}

-- Typeclasses
{-

  -- * A Typeclass is sort of an interface that defines some behavior.
  -- * If a type is a part of a typeclass, that means it supports and implements the behavior the typeclass describes.
  -- * A typeclass can be thought of as a better version of a java interface.

  {-
    What's the type signature of the == function?

    * ghci> :t (==)
    * (==) :: Eq a => a -> a -> Bool

    * Note: the equality operator, == is a function. So are +, *, -, / and pretty much all operators. If a function is comprised only of special characters, it's considered an infix function by default. If we want to examine its type, pass it to another function or call it as a prefix function, we have to surround it in parentheses.

    -- * We see the => symbol here. Everything before the => symbol is called a class constraint.

    -- * We can read the previous type declaration like this: the equality function takes any two values that are of the same type and returns a Bool. The type of those two values must be a member of the Eq class (this was the class constraint).

    -- * The Eq typeclass provides an interface for testing for equality. Any type where it makes sense to test for equality between two values of that type should be a member of the Eq class.

    -- ! All standard Haskell types except for IO (the type for dealing with input and output) and functions are a part of the Eq typeclass.

    -- * The elem function has a type of (Eq a) => a -> [a] -> Bool because it uses == over a list to check whether some value we're looking for is in it.
  -}

  -- * Some basic typeclasses are:
        -- * Eq -> used to support equality testing (==, /=)

        -- * Ord -> Ord is for types that have an ordering.
            -- * All the basic types except functions are a part of Ord.
            -- * Ord covers all the standard comparison functions such as >,<,>=,<=.
            -- *The compare function takes two members of the Ord typeclass and returns an ordering for them. Ordering is a type that can be GT, LT, or EQ.
            -- * To be a member of Ord, a type must be a member of the Eq typeclass first.

        -- * Show -> The members of Show typeclass can be presented as strings. All basic types except functions are a part of the Show typeclass.
            -- * The most commonly used function of the Show typeclass is 'show'. It takes a value whose type is a member of show and returns a string version of that type.

        -- * Read -> Read is the opposite of Show. The read function takes a string and returns a type that corresponds to the interpretation of that string that is also a member of the Read typeclass.
            -- * The read function deduces what it has to return by analyzing what we are doing with the result. If we are not using the result, haskell will get confused and throw an error. To avoid this, we can use explicit type annotations to let read know what we are expecting it to return.

            -- * read "4" -> it will throw an error
            -- * read "4" :: Float -> This will return 4.0.

        -- * Enum -> Members of Enum are sequentially ordered types i.e. They can be enumerated. They also have successors and predecessors which can be accessed by succ and pred functions.
            -- * Types in this class are:
              -- * (), Bool, Char, Ordering, Int, Integer, Float, and Double.

        -- * Bounded -> members have an upper and a lower bound.
            -- * minBound and maxBound are polumorphic constant functions.
            -- * Int, Char, Bool, and (() are bounded if so are the components in them).

        -- * Num is a numeric typeclass. Its members have the ability to act like numbers.
            -- * Int, Integer, Float, Double are Num types.
            -- * integers are also polymorphic constants. They can act like any type of the Num typeclass.
            -- * To join Num, a type must already be a member of Eq and Show.

        -- * Integral is also a numeric typeclass. Num includes all numbers, including real numbers and integral numbers, Integral includes only integral (whole) numbers. In this typeclass are Int and Integer.

        -- * Floating includes only floating point numbers, so Float and Double.

        -- * A very useful function for dealing with numbers is fromIntegral. It has a type declaration of fromIntegral :: (Num b, Integral a) => a -> b. From its type signature we see that it takes an integral number and turns it into a more general number. That's useful when you want integral and floating point types to work together nicely. For instance, the length function has a type declaration of length :: [a] -> Int instead of having a more general type of (Num b) => length :: [a] -> b.

        -- * if we try to get a length of a list and then add it to 3.2, we'll get an error because we tried to add together an Int and a floating point number. So to get around this, we do fromIntegral (length [1,2,3,4]) + 3.2 and it all works out.

      -- ! fromIntegral :: (Integral a, Num b) => a -> b
 -}