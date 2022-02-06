-- lists are homogenous in haskell
{-# OPTIONS_GHC -Wno-empty-enumerations #-}

lostNumbers = [4, 8, 15, 16, 23, 42]

-- list concatenation -> 'l1 ++ l2'
-- string concatenation works the same way.
-- ++ is the concatenation operator

foundNumbers = [1, 2, 3, 4] ++ [1, 2, 3, 4]

helloWorld = "hello" ++ " world"

-- Lists in haskell are singly linked
-- insertion to the front is O(1)
-- cons operator is used for this purpose
-- const operator is used to insert a single item
newNumbers = 5 : foundNumbers

-- newestNumbers = newNumbers : 3 -> not allowed

{-
  -- [1, 2, 3, 4] is just syntactic sugar for 1 : 2 : 3 : 4 : [], where we are prepending all these numbers to the empty list one after another.
  -- [], [[]], and [[], [], []] all mean different things
-}

-- use "!!" operator to access an element at a given index
thirdNumber = newNumbers !! 2 -- thirdNumber is 2

-- the program will throw an error if we try to access an index that is out of bounds.
-- we can also have nested lists
nestedList =
  [ [ [ [1, 2, 3],
        [2, 3, 4],
        [3, 4, 5]
      ],
      [ [4, 5, 6],
        [5, 6, 7],
        [6, 7, 8]
      ],
      [ [9, 10, 11],
        [10, 11, 12],
        [11, 12, 13]
      ]
    ],
    [ [ [12, 13, 14],
        [13, 14, 15],
        [14, 15, 16]
      ],
      [ [15, 16, 17],
        [16, 17, 18],
        [17, 18, 19]
      ],
      [ [18, 19, 20],
        [19, 20, 21],
        [20, 21, 22]
      ]
    ]
  ]

-- Lists can be compared using >, <, >=, <=, ==, /=  if the items in list can be compared to each other
-- lists are compared in lexicographical order from head to last

a = [1, 2, 3]

b = [2, 3, 4]

{-
-- list functions
 -}

--  head takes a list and returns its head
headElem = head newNumbers

-- tail returns the whole list but the head.
nums = tail newNumbers

-- last returns the last element of the list
lastElem = last newNumbers

-- init returns the whole list but the last elem
numbers = init newNumbers

{-
-- |    init     | |last|

-- [1,    2, 3, 4,    5]

-- |head| |     tail    |
 -}

-- length returns the length of the list
len = length newNumbers

-- null checks if the list is empty
isNull = null newNumbers

-- reverse reverses the list
revNums = reverse newNumbers

-- take takes a number n and a list l and extracts n elements from the beginning of the list
-- if we try to take more elements than are present in the list, take just returns the whole list

first5 = take 5 newNumbers

first3 = 4 `take` newNumbers

-- drop works similarly by dropping the first n numbers from the list
notFirst5 = drop 5 newNumbers

-- maximum and minimum return what their name suggests
maxElt = maximum newNumbers

minElt = minimum newNumbers

-- sum does what it says
sumOfNums = sum newNumbers

-- product returns the product of the list
prodNums = product newNumbers

-- elem returns true if the given number is present in the list and false otherwise
is10Present = 10 `elem` newNumbers

-- ranges
-- ranges produce a sequence of [x..y] inclusive
oneTo100 = [1 .. 100]

aToZ = ['a' .. 'z']

-- we can also specify a step for a range
-- floating point numbers can produce weird results in ranges
-- [firstElem, secondElem .. upperLimitOrLowerLimit]
first10EvenNums = [2, 4 .. 20]

-- to make a list from 20 to 1
twentyTo1 = [20, 19 .. 1]

-- we can also create infinite lists by not specifying the limit
-- [1 ..]
-- haskell won't evaluate this list is accessed explicitly
-- this is due to haskell being lazy
infList = [1 ..]

-- first 24
-- now when haskell finds out what we want out of this abomination of a list, it will execute the range and provide the desired result. Hence saving time and resources.
first24 = take 24 infList

{-
-- there are some functions that produce infinite lists in haskell
 -}

-- cycle takes a list and cycles it into an infinite list, we have to slice it at some point for it to be useful.
cycledList = take 10 (cycle [1, 2, 3, 4])

-- repeat is like cycle but for a single element
repeated5 = drop 34 (take 100 (repeat 5))

-- it is easier to use 'replicate' to produce a repetition of a number
repeated10 = replicate 3 10

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- list comprehension
-- basically ranges on steroids if you will
-- similar to set comprehension in set theory
-- [output function, input set, predicate]

-- first 10 even numbers using list comprehension
tenEven = [x * 2 | x <- [1 .. 10]]

withPredicate = [x * 2 | x <- [1 .. 10], x * 2 >= 12]

anotherOne = [x | x <- [50 .. 100], x `mod` 7 == 3]

-- we can also put a comprehension in a function for reusability
boomOrBangSelector x =
  if x < 10
    then "BOOM!"
    else "BANG!"

boomBangs xs' = [boomOrBangSelector x | x <- xs', odd x]

-- we can include several predicates
withMultiplePredicates = [x | x <- [10 .. 20], x /= 13, x /= 15, x /= 19]

--  We can also draw inputs from multiple lists.
-- When drawing from multiple lists, comprehensions produce all combinations of the given lists.
multipleInputs = [x * y | x <- [1, 2, 3], y <- [5, 6, 7]]

-- multipleInputs = [x * y * z | x <- [1, 2, 3], y <- [5, 6, 7], z <- [8, 9, 10]] is also possible

-- custom version of length
length' l = sum [1 | _ <- l]

-- we can also use list comprehension on strings because they are a list of characters by design
-- nested list comprehension is also possible

matrix =
  [ [1, 3, 5, 2, 3, 1, 2, 4, 5],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 4, 2, 1, 6, 3, 1, 3, 2, 3, 6]
  ]

matrixWithoutOdd =
  [ [num | num <- list, even num]
    | list <- matrix
  ]
