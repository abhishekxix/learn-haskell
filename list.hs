--------------------------------------------------------------
--------------------------------------------------------------
-- lists and list functions
--------------------------------------------------------------
--------------------------------------------------------------
-- Lists in haskell are singly linked
-- can only add to the front of the list

primeNumbers = [2, 3, 5, 7]

morePrime = primeNumbers ++ [13, 17, 19]

-- morePrime = morePrime ++ primeNumbers

favNums = 2 : 7 : 21 : 6 : []

multList = [[3, 5, 7], [11, 13, 17]]

morePrimes2 = 2 : morePrime

-- morePrimes3 = morePrime : 3 not allowed

lenPrime = length morePrime

-- reverse list
revPrime = reverse morePrimes2

isListEmpty = null morePrimes2

-- to access an index
secondPrime = morePrimes2 !! 1

firstPrime = head morePrimes2

lastPrime = last morePrimes2

-- get everything but last
primeInit = init morePrimes2

-- get first n values
first3Primes = take 3 morePrimes2

-- ignore first n and return the rest
skip3Primes = drop 3 morePrimes2

-- iselempresent
is7InList = 7 `elem` morePrimes2

-- max
maxPrime = maximum morePrimes2

--min
minPrime = minimum morePrimes2

-- product of values
productOfList = product [2, 3, 5]

-- generate list
zeroToTen = [0 .. 10]

-- step on list generation
