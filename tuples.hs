-- tuples are a way to store multiple values into a single value
-- the number of values in a tuple determines its type
-- tuples can contain heterogenous data
-- they are denoted with comma separated elements enclosed in parenthesis
-- tuples are needed to be of a finite size
-- a tuple with three elements has a different type than a tuple with two elements
-- two tuples are of same type if they have the same size and the same order of the type of elements in them.
-- ("a", 1) is the same type as ("b", 2) ✅
-- ("a", 1) is the same type as (1, 2) ❌
-- a tuple is atleast a pair.

-- there are some functions on pairs
-- first element
firstElem = fst (1, 2)

-- second element
secondElem = snd (1, 2)

-- zip function returns a list of tuples by making pairs of elements at the same index in both the lists
-- the longer list gets cut off match the length of the shorter one. What this means is that we can zip finite lists with infinite ones
points = zip [1, 2, 3, 4, 5] [-1, -2, -3, -4, -5, -6, -7]

-- problem: which right triangle that has integers for all sides and all sides equal to or smaller than 10 has a perimeter of 24?
-- solution

triangles =
  [ (a, b, c)
    | a <- [1 .. 10],
      b <- [1 .. 10],
      c <- [1 .. 10]
  ]

rightTriangles =
  [ (a, b, c)
    | c <- [1 .. 10],
      b <- [1 .. c],
      a <- [1 .. b],
      a ** 2 + b ** 2 == c ** 2
  ]

result =
  [ (a, b, c)
    | c <- [1 .. 10],
      b <- [1 .. c],
      a <- [1 .. b],
      a ** 2 + b ** 2 == c ** 2,
      a + b + c == 24
  ]

-- This is a common pattern in functional programming. You take a starting set of solutions and then you apply transformations to those solutions and filter them until you get the right ones.