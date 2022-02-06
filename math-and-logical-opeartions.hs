-- first haskell program
{-

multiline comment

 -}

import Data.List
import System.IO

sumOfNums :: Integer
sumOfNums = sum [1 .. 1000]

addEx :: Integer
addEx = 5 + 4

subEx :: Integer
subEx = 5 - 4

multEx :: Integer
multEx = 5 * 4

divEx :: Double
divEx = 5 / 4

modEx :: Integer
modEx = mod 5 4 -- prefix operator

modEx2 :: Integer
modEx2 = 5 `mod` 4 -- infix operator

num9 :: Integer
num9 = 9

sqrtOf9 = sqrt (fromIntegral num9)

{-
Built in math functions
- piVal = pi
- ePow9 = exp 9
- logOf9 = log 9
- squared9 = 9 ** 2
- truncateVal = truncate 9.999
- roundVal = round 9.999
- ceilingVal = ceiling 9.999
- floorVal = floor 9.999

- sin, cos, tan, asin, atan, acos, sinh, tanh, cosh, asinh, atanh, acosh
 -}

piVal = pi

ePow9 = exp 9

logOf9 = log 9

squared9 = 9 ** 2

truncateVal = truncate 9.999

roundVal = round 9.999

ceilingVal = ceiling 9.999

floorVal = floor 9.999

{- logical operators -}
-- tAdnF = True && False

-- tOrF = True || False
-- notTrue = not(True)
-- a == b
-- a /= b
