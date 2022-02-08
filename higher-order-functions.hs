-- # Higher order functions # --

-- * Higher order functions aren't just a part of the Haskell experience, they pretty much are the Haskell experience.

-- * It turns out that if you want to define computations by defining what stuff is instead of defining steps that change some state and maybe looping them, higher order functions are indispensable. They're a really powerful way of solving problems and thinking about programs.

-- # Curried Functions #--

-- $ Every function in haskell officially only takes one parameter.
--  $ All the functions that accept several parameters so far have been curried functions.
-- eg: max 4 5
-- if we check the type of max
-- * it is max :: (Ord a) => a -> a -> a
-- * This can also be written as:
-- ^ max :: (Ord a) => a -> (a -> a)
-- That could be read as:
-- ^ max takes an a and returns (->) a function that takes an a and returns an a. This is the reason that the return type and the parameter of the functions are separated by an arrow (->).

-- * So how is that beneficial to us? Simply speaking, if we call a function with too few parameters, we get back a partially applied function, meaning a function that takes as many parameters as we left out. Using partial application (calling functions with too few parameters, if you will) is a neat way to create functions on the fly so we can pass them to another function or to seed them with some data.

multThree :: Num a => a -> a -> a -> a
multThree x y z = x * y * z

multTwoWithNine = multThree 9

multWithEighteen = multTwoWithNine 2

-- * another example

compareWithHundred :: Integer -> Ordering
compareWithHundred = compare 100
-- ^ compareWithHundred is now a function that does what it says.

-- * Infix functions can also be partially applied by using sections. To section an infix function, simply surround it with parentheses and only supply a parameter on one side. That creates a function that takes one parameter and then applies it to the side that's missing an operand. An insultingly trivial function:

divideByTen :: Double -> Double
divideByTen = (/ 10)

-- * The only special thing about sections is using -. From the definition of sections, (-4) would result in a function that takes a number and subtracts 4 from it. However, for convenience, (-4) means minus four. So if you want to make a function that subtracts 4 from the number it gets as a parameter, partially apply the subtract function like so: (subtract 4).

-- # Some higher order functions # --

applyTwice :: (t -> t) -> t -> t
applyTwice f x = f (f x)

--  ^
{-
  Before, we didn't need parentheses because -> is naturally right-associative. However, here, they're mandatory. They indicate that the first parameter is a function that takes something and returns that same thing. The second parameter is something of that type also and the return value is also of the same type. We could read this type declaration in the curried way, but to save ourselves a headache, we'll just say that this function takes two parameters and returns one thing. The first parameter is a function (of type a -> a) and the second is that same a. The function can also be Int -> Int or String -> String or whatever. But then, the second parameter to also has to be of that type.
-}

zipWith' :: (t1 -> t2 -> a) -> [t1] -> [t2] -> [a]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x : xs) (y : ys) = f x y : zipWith' f xs ys

matrixZipped =
  zipWith'
    (zipWith' (*))
    [[1, 2, 3], [3, 5, 6], [2, 3, 4]]
    [[3, 2, 2], [3, 4, 5], [5, 4, 3]]

-- * flip

-- flip' :: (t1 -> t2 -> t3) -> (t2 -> t1 -> t3)
-- flip' f = g where g x y = f y x

flip' :: (t1 -> t2 -> t3) -> t2 -> t1 -> t3
flip' f y x = f x y

--  ^ Here, we take advantage of the fact that functions are curried. When we call flip' f without the parameters y and x, it will return an f that takes those two parameters but calls them flipped. Even though flipped functions are usually passed to other functions, we can take advantage of currying when making higher-order functions by thinking ahead and writing what their end result would be if they were called fully applied.

-- # Maps and filters # --

{- -- * map takes a function and a list and applies that function to every element in the list, producing a new list.

-- * map is basically the same functionality as list comprehension. However, using map is much more readable for cases where you only apply some function to the elements of a list, especially once you're dealing with maps of maps and then the whole thing with a lot of brackets can get a bit messy. -}

{-
  -- * filter is a function that takes a predicate (a predicate is a function that tells whether something is true or not.) and a list and then returns the list of elements that satisfy the predicate.
  -- * All of this could also be achived with list comprehensions by the use of predicates. There's no set rule for when to use map and filter versus using list comprehension, you just have to decide what's more readable depending on the code and the context. The filter equivalent of applying several predicates in a list comprehension is either filtering something several times or joining the predicates with the logical && function.
-}

-- * similar to the take function is the takeWhile function which takes a predicate and a list and takes the elements from the list that satisfy the predicate.

-- # lambdas #--
--  * lambdas are basically anonymous funcions that are used because we need some functions only once. Normally, a lambda is created with the sole purpose of passing it to a higher order function.

-- * The syntax looks like:

-- $ (\ params... -> function body)
-- ^ usually surrounded by parenthesis
-- ^ Lambdas are expressions. That's why we can pass them into functions.
-- ! People who are not well acquainted with how currying and partial application works often use lambdas where they don't need to. For instance, the expressions map (+3) [1,6,3,2] and map (\x -> x + 3) [1,6,3,2] are equivalent since both (+3) and (\x -> x + 3) are functions that take a number and add 3 to it. Needless to say, making a lambda in this case is stupid since using partial application is much more readable.

-- $ And like normal functions, you can pattern match in lambdas. The only difference is that you can't define several patterns for one parameter, like making a [] and a (x:xs) pattern for the same parameter and then having values fall through. If a pattern matching fails in a lambda, a runtime error occurs, so be careful when pattern matching in lambdas!

-- $ Lambdas are normally surrounded by parentheses unless we mean for them to extend all the way to the right.

-- # Folds # --
{- Back when we were dealing with recursion, we noticed a theme throughout many of the recursive functions that operated on lists. Usually, we'd have an edge case for the empty list. We'd introduce the x:xs pattern and then we'd do some action that involves a single element and the rest of the list. It turns out this is a very common pattern, so a couple of very useful functions were introduced to encapsulate it. These functions are called folds. They're sort of like the map function, only they reduce the list to some single value. -}

-- * A fold takes a binary function, a starting value (say an accumulator) and a list to fold up.

-- * The binary function itself takes two parameters.

--  * The binary function is called with the accumulator and the first or last element and it produces a new accumulator.

-- ^ Then, the binary function is called again with the new accumulator and the now new first (or last) element, and so on. Once we've walked over the whole list, only the accumulator remains, which is what we've reduced the list to.

-- * foldl -> folds the list from left

sum' :: Num a => [a] -> a
-- sum' xs = foldl (\acc x -> acc + x) 0 xs
-- sum' list = foldl (+) 0 list
sum' = foldl (+) 0
-- ^ returns a function that takes a list as an argument.

elem' :: Eq a => a -> [a] -> Bool
elem' elt = foldl (\acc x -> x == elt) False

{-
    *The right fold, foldr works in a similar way to the left fold, only the accumulator eats up the values from the right. Also, the left fold's binary function has the accumulator as the first parameter and the current value as the second one (so \acc x -> ...), the right fold's binary function has the current value as the first parameter and the accumulator as the second one (so \x acc -> ...). It kind of makes sense that the right fold has the accumulator on the right, because it folds from the right side.

    * The accumulator value (and hence, the result) of a fold can be of any type. It can be a number, a boolean or even a new list. We'll be implementing the map function with a right fold. The accumulator will be a list, we'll be accumulating the mapped list element by element. From that, it's obvious that the starting element will be an empty list.WW
-}
map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x acc -> f x : acc) []
-- ^ Of course, we could have implemented this function with a left fold too. It would be map' f xs = foldl (\acc x -> acc ++ [f x]) [] xs, but the thing is that the ++ function is much more expensive than :, so we usually use right folds when we're building up new lists from a list.

-- $ If you reverse a list, you can do a right fold on it just like you would have done a left fold and vice versa. Sometimes you don't even have to do that. The sum function can be implemented pretty much the same with a left and right fold. One big difference is that right folds work on infinite lists, whereas left ones don't! To put it plainly, if you take an infinite list at some point and you fold it up from the right, you'll eventually reach the beginning of the list. However, if you take an infinite list at a point and you try to fold it up from the left, you'll never reach an end!

-- !Folds can be used to implement any function where you traverse a list once, element by element, and then return something based on that. Whenever you want to traverse a list to return something, chances are you want a fold. That's why folds are, along with maps and filters, one of the most useful types of functions in functional programming.

-- $ The foldl1 and foldr1 functions work much like foldl and foldr, only you don't need to provide them with an explicit starting value. They assume the first (or last) element of the list to be the starting value and then start the fold with the element next to it. With that in mind, the sum function can be implemented like so: sum = foldl1 (+). Because they depend on the lists they fold up having at least one element, they cause runtime errors if called with empty lists. foldl and foldr, on the other hand, work fine with empty lists. When making a fold, think about how it acts on an empty list. If the function doesn't make sense when given an empty list, you can probably use a foldl1 or foldr1 to implement it.

-- * scanl and scanr are like foldl and foldr, only they report all the intermediate accumulator states in the form of a list. There are also scanl1 and scanr1, which are analogous to foldl1 and foldr1.

-- ^ When using a scanl, the final result will be in the last element of the resulting list while a scanr will place the result in the head.

-- # function application with '$' #

-- ^ ($) :: (a -> b) -> a -> b

-- ^ f $ x = f x

-- * Whereas normal function application (putting a space between two things) has a really high precedence, the $ function has the lowest precedence. Function application with a space is left-associative (so f a b c is the same as ((f a) b) c)), function application with $ is right-associative.

-- * Most of the time, it's a convenience function so that we don't have to write so many parentheses. Consider the expression sum (map sqrt [1..130]). Because $ has such a low precedence, we can rewrite that expression as `sum $ map sqrt [1..130]`, saving ourselves precious keystrokes!

--  # Function composition # --

-- * Pretty much the same thing as in math.

-- * We do function composition with the . function, which is defined like so:

-- $ (.) :: (b -> c) -> (a -> b) -> a -> c

-- $ f . g = \x -> f (g x)

-- * One of the uses for function composition is making functions on the fly to pass to other functions. Sure, can use lambdas for that, but many times, function composition is clearer and more concise

-- * Function composition is right-associative, so we can compose many functions at a time. The expression f (g (z x)) is equivalent to (f . g . z) x

-- $ Another common use of function composition is defining functions in the so-called point free style (also called the pointless style). Take for example this function that we wrote earlier:

{-
  * sum' :: (Num a) => [a] -> a
  * sum' xs = foldl (+) 0 xs
  The xs is exposed on both right sides. Because of currying, we can omit the xs on both sides, because calling foldl (+) 0 creates a function that takes a list. Writing the function as sum' = foldl (+) 0 is called writing it in point free style. How would we write this in point free style?
  * fn x = ceiling (negate (tan (cos (max 50 x))))
  * fn = ceiling . negate . tan . cos . max 50
  -}