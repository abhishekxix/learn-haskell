-- $ Recursion is important to Haskell because unlike imperative languages, you do computations in Haskell by declaring what something is instead of declaring how you get it. That's why there are no while loops or for loops in Haskell and instead we many times have to use recursion to declare what something is.

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x : xs)
  | x > maxTail = x
  | otherwise = maxTail
  where
    maxTail = maximum' xs
-- ^ As you can see, pattern matching goes great with recursion! Most imperative languages don't have pattern matching so you have to make a lot of if else statements to test for edge conditions. Here, we simply put them out as patterns.
-- There's an even clearer  way to rewrite this function

maximum'' :: (Ord a) => [a] -> a
maximum'' [] = error "maximum of empty list"
maximum'' [x] = x
maximum'' (x : xs) = max x (maximum'' xs)

replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
  | n <= 0 = []
  | otherwise = x : replicate' (n -1) x
-- ^ Num is not a subclass of Ord. That means that what constitutes for a number doesn't really have to adhere to an ordering. So that's why we have to specify both the Num and Ord class constraints when doing addition or subtraction and also comparison.

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _ | n <= 0 = []
take' _ [] = []
take' n (x : xs) = x : take' (n - 1) xs

-- * Reversing the list recursively

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (first : rest) =
  reverse' rest ++ [first]
-- ^ where
-- ^   reversedList = reverse' rest

-- * repeat infinite function recursive implementation

rep :: a -> [a]
rep num = num : rep num

-- * zip takes two lists and zips them together.

zip' :: [a] -> [a] -> [(a, a)]
zip' _ [] = []
zip' [] _ = []
zip' (a : resta) (b : restb) = (a, b) : zip resta restb

-- * elem

elem' :: (Eq a) => a -> [a] -> Bool
elem' x [] = False
elem' x (y : ys)
  | x == y = True
  | otherwise = x `elem'` ys

-- * Quicksort

quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (pivot : rest) =
  let smallerSorted = quickSort [a | a <- rest, a <= pivot]
      biggerSorted = quickSort [a | a <- rest, a > pivot]
   in smallerSorted ++ [pivot] ++ biggerSorted