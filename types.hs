{-
  Types
  Int -> -2^63 to 2^63
  Integer -> Unbounded integer
  Float -> single precision decimal
  Double -> double precision decimal
  Bool -> True False
  Char -> ''
  Tuples -> list of many different data types
-}
-- always surround negative numbers with ()
maxInt = maxBound :: Int

minInt = minBound :: Int

unboundedInt :: Integer
unboundedInt = -100000

always5 :: Integer
always5 = 5