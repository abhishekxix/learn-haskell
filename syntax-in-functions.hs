-- # Pattern matching in functions --

--  Pattern matching consists of specifying patterns to which some data should conform and then checking to see if it does and deconstructing the data according to those patterns.

-- When defining functions, you can define separate function bodies for different patterns. This leads to really neat code that's simple and readable. You can pattern match on any data type — numbers, characters, lists, tuples, etc

luckyNumber :: (Integral a) => a -> String
luckyNumber 7 = "LUCKY NUMBER SEVEN"
luckyNumber x = "Sorry, you're out of luck."

{-
  * When you call lucky, the patterns will be checked from top to bottom and when it conforms to a pattern, the corresponding function body will be used. The only way a number can conform to the first pattern here is if it is 7. If it's not, it falls through to the second pattern, which matches anything and binds it to x. This function could have also been implemented by using an if statement. But what if we wanted a function that says the numbers from 1 to 5 and says "Not between 1 and 5" for any other number? Without pattern matching, we'd have to make a pretty convoluted if then else tree. However, with it:
 -}

sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"
-- ^ The catch all pattern
-- It's kinda like switch case.

{-
 *We defined the factorial of a number n as product [1..n]. We can also define a factorial function recursively, the way it is usually defined in mathematics. We start by saying that the factorial of 0 is 1. Then we state that the factorial of any positive integer is that integer multiplied by the factorial of its predecessor. Here's how that looks like translated in Haskell terms.
 -}

factorial :: Integral a => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- ! we've defined the factorial of 0 to be just 1 and because it encounters that pattern before the catch-all one, it just returns 1. So the final result is equivalent to 3 * (2 * (1 * 1)). Had we written the second pattern on top of the first one, it would catch all numbers, including 0 and our calculation would never terminate. That's why order is important when specifying patterns and it's always best to specify the most specific ones first and then the more general ones later.

-- ! Pattern matching can also fail if we don't provide an exhaustive pattern .i.e. We don't provide the catch all  pattern and then the function is called with some argument that doesn't match any specific pattern.

{-
  -- Pattern matching can also be used on tuples. What if we wanted to make a function that takes two vectors in a 2D space (that are in the form of pairs) and adds them together? To add together two vectors, we add their x components separately and then their y components separately. Here's how we would have done it if we didn't know about pattern matching:

  -- * addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
  -- * addVectors a b = (fst a + fst b, snd a + snd b)

  -- Well, that works, but there's a better way to do it. Let's modify the function so that it uses pattern matching.

  -- * addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
  -- * addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

  --  There we go! Much better. Note that this is already a catch-all pattern. The type of addVectors (in both cases) is addVectors :: (Num a) => (a, a) -> (a, a) - > (a, a), so we are guaranteed to get two pairs as parameters.
 -}

-- * We can also do pattern matching in list comprehension

xs = [(1, 3), (4, 3), (2, 4), (5, 3), (5, 6), (3, 1)]

sum = [a + b | (a, b) <- xs]
-- ^ If the pattern matching fails, the element is just skipped.

-- * Lists themselves can also be used in pattern matching. You can match with the empty list [] or any pattern that involves : and the empty list. But since [1,2,3] is just syntactic sugar for 1:2:3:[], you can also use the former pattern. A pattern like x:xs will bind the head of the list to x and the rest of it to xs, even if there's only one element so xs ends up being an empty list.

-- ! Note: The x:xs pattern is used a lot, especially with recursive functions. But patterns that have : in them only match against lists of length 1 or more.

-- * If you want to bind, say, the first three elements to variables and the rest of the list to another variable, you can use something like x:y:z:zs. It will only match against lists that have three elements or more.

head' :: [a] -> a
head' [] = error "Can't call head on an empty list."
head' (x : _) = x

-- * _ is just used as an identifier for the list for the convenience that it denotes an entity that does not matter to us.

-- ! Notice that if you want to bind to several variables (even if one of them is just _ and doesn't actually bind at all), we have to surround them in parentheses. Also notice the error function that we used. It takes a string and generates a runtime error, using that string as information about what kind of error occurred. It causes the program to crash, so it's not good to use it too much. But calling head on an empty list doesn't make sense.

-- * Let's make a trivial function that tells us some of the first elements of the list in (in)convenient English form.

tell :: Show a => [a] -> String
tell [] = "The list is empty"
-- tell (x : []) = "The list has one item"
-- tell (x : y : []) = "The list has two items"
tell [x] = "The list has one item"
tell [x, y] = "The list has two items"
tell (x : _) = "The list has more than two items"

-- * We already implemented our own length function using list comprehension. Now we'll do it by using pattern matching and a little recursion:

length' :: (Num b) => [a] -> b
length' [] = 0
length' (_ : xs) = 1 + length' xs

{-
  There's also a thing called as patterns. Those are a handy way of breaking something up according to a pattern and binding it to names whilst still keeping a reference to the whole thing. You do that by putting a name and an @ in front of a pattern. For instance, the pattern xs@(x:y:ys). This pattern will match exactly the same thing as x:y:ys but you can easily get the whole list via xs instead of repeating yourself by typing out x:y:ys in the function body again. Here's a quick and dirty example:

  * capital :: String -> String
  * capital "" = "Empty string, whoops!"
  * capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
  * ghci> capital "Dracula"
  *"The first letter of Dracula is D"

  Normally we use as patterns to avoid repeating ourselves when matching against a bigger pattern when we have to use the whole thing again in the function body.

  ! One more thing — you can't use ++ in pattern matches. If you tried to pattern match against (xs ++ ys), what would be in the first and what would be in the second list? It doesn't make much sense. It would make sense to match stuff against (xs ++ [x,y,z]) or just (xs ++ [x]), but because of the nature of lists, you can't do that.

-}

-- # Guards --

-- Patterns are a way of making sure that a value conforms to some form and deconstructing it, guards are a way of testing whether some property of a value (or several of them) are true or false.
-- Guards are similar to if else statement
-- Guards are a lot more readable when there are several conditinos and they play nicely with patterns.

bmiTell :: RealFloat a => a -> String
bmiTell bmi
  | bmi <= 18.5 = "you are underweight"
  | bmi <= 25.0 = "you're in the normal range."
  | bmi <= 30.0 = "you are overweight."
  | otherwise = "you're a whale, congratulations"
-- ^  A guard is basically a boolean expression. If it evaluates to True, then the corresponding function body is used. If it evaluates to False, checking drops through to the next guard and so on.
-- * Many times, the last guard is otherwise. otherwise is defined simply as otherwise = True and catches everything.
-- * This is very similar to patterns, only they check if the input satisfies a pattern but guards check for boolean conditions. If all the guards of a function evaluate to False (and we haven't provided an otherwise catch-all guard), evaluation falls through to the next pattern. That's how patterns and guards play nicely together. If no suitable guards or patterns are found, an error is thrown.

-- The where keyword helps define an identifier for an expression
bmiTell' :: (RealFloat a) => a -> a -> String
bmiTell' weight height
  | bmi <= skinny = "you're underweight"
  | bmi <= normal = "normie"
  | bmi <= fat = "fatso"
  | otherwise = "you're a whale"
  where
    bmi = weight / height ** 2
    skinny = 18.5
    normal = 25.0
    fat = 30.0
-- ^ It can also define multiple identifiers
-- where bindings aren't shared across function bodies of different patterns. If you want several patterns of one function to access some shared name, you have to define it globally

calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
  where
    bmi weight height = weight / height ^ 2

-- * where bindings can also be nested. It's a common idiom to make a function and define some helper function in its where clause and then to give those functions helper functions as well, each with its own where clause.

-- There is also another type of binding called let binding.
-- It is similar to where binding except for the placement.

-- * Where bindings are a syntactic construct that let you bind to variables at the end of a function and the whole function can see them, including all the guards. Let bindings let you bind to variables anywhere and are expressions themselves, but are very local, so they don't span across guards. Just like any construct in Haskell that is used to bind values to names, let bindings can be used for pattern matching.

cylinder :: RealFloat a => a -> a -> a
cylinder r h =
  let sideArea = 2 * pi * r * h
      topArea = pi * r ^ 2
   in sideArea + 2 * topArea

-- * The form is let <bindings> in <expression>. The names that you define in the let part are accessible to the expression after the in part.

-- * The difference is that let bindings are expressions themselves. where bindings are just syntactic constructs.

anExample = 4 * (let a = 9 in a + 1) + 2

-- * They can also be used to introduce functions in a local scope:

sq =
  let square x = x * x
   in [square 1, square 2, square 3, square 4, square 5, square 6]

-- * If we want to bind to several variables inline, we obviously can't align them at columns. That's why we can separate them with semicolons.

tup =
  ( let a = 100; b = 200; c = 300
     in a * b * c,
    let foo = "hey"; bar = " there!"
     in foo ++ bar
  )

-- * you can pattern match with let bindings. They're very useful for quickly dismantling a tuple into components and binding them to names and such.

num = let (a, b, c) = (1, 2, 3) in (a + b + c) * 1000

-- * We can also put let bindings in list comprehension.

calculateBMIs :: RealFloat a => [(a, a)] -> [a]
calculateBMIs xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]
-- ^  We put the let bindings inside a list comprehension much like a predicate. However, it does not filter the list. The let bindings are available to the output function and all predicates and the sections that come after the binding.

cbmi :: RealFloat a => [(a, a)] -> [a]
cbmi xs =
  [ bmi
    | (w, h) <- xs,
      let bmi = w / h ^ 2,
      bmi >= 25.0
  ]
-- ^ We can't use the bmi name in the (w, h) <- xs part because it's defined prior to the let binding.
-- ^ We omitted the in part of the let binding when we used them in list comprehensions because the visibility of the names is already predefined there. However, we could use a let in binding in a predicate and the names defined would only be visible to that predicate.
-- * The in part can also be omitted when defining functions and constants directly in GHCi. If we do that, then the names will be visible throughout the entire interactive session.

{- If let bindings are so cool, why not use them all the time instead of where bindings, you ask? Well, since let bindings are expressions and are fairly local in their scope, they can't be used across guards. Some people prefer where bindings because the names come after the function they're being used in. That way, the function body is closer to its name and type declaration and to some that's more readable. -}

-- # Case expressions --

-- * taking and variable and executing different blocks of code for different values that it could take and then a catch all or default case.

-- * As the name suggests, case expressions are 'expressions'.

-- * Not only can we evaluate different expressions based on the possible cases, we can also do pattern matchinc.

-- * Pattern matching in funcitno definitions is just syntactic sugar for case expressions.

-- * following two pieces of code do the exact same thing:

{-
    -- * head' :: [a] -> a
    -- * head' [] = error "No head for empty lists!"
    -- * head' (x:_) = x

    -- * head' :: [a] -> a
    -- * head' xs = case xs of [] -> error "No head for empty lists!"
    -- *                       (x:_) -> x
-}

-- ^ The syntax for case expressions is pretty simple
-- ! case expression of pattern -> result
-- !                    pattern -> result
-- !                    pattern -> result
-- !                    ...

-- * expression is matched against the patterns. The pattern matching action is the same as expected: the first pattern that matches the expression is used. If it falls through the whole case expression and no suitable pattern is found, a runtime error occurs.

-- * Whereas pattern matching on function parameters can only be done when defining functions, case expressions can be used pretty much anywhere. For instance:

describeList :: [a] -> String
describeList xs =
  "The list is "
    ++ case xs of
      [] -> "empty"
      [x] -> "singleton"
      xs -> "a longer list"

-- * They are useful for pattern matching against something in the middle of an expression. Because pattern matching in function definitions is syntactic sugar for case expressions, we could have also defined this like so:

descList :: [a] -> String
descList xs = "The list is " ++ what xs
  where
    what [] = "empty."
    what [x] = "a singleton list."
    what xs = "a longer list."