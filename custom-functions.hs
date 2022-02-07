doubleUs x y = doubleMe x + doubleMe y

doubleMe x = x + x

-- The order of function definition does not matter in haskell
-- It is common pattern in haskell to define functions for trivial tasks.
-- haskell programs works by gluing together smaller functions to implement more complex functionality

-- haskell's if statement

-- * else part is mandatory in haskell

-- * every expression and function must return something

-- * if statement in haskell is an expression

doubleSmallNumber x =
  if x > 100
    then x
    else x * 2

doubleSmallNumber' x =
  ( if x > 100
      then x
      else x * 2
  )
    + 1

-- * functions have to follow camelCase