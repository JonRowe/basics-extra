module Basics.Extra
    exposing
        ( (=>)
        , fmod
        , inDegrees
        , inRadians
        , inTurns
        , isSafeInteger
        , maxSafeInteger
        , minSafeInteger
        , swap
        )

{-| Additional basic functions.


# Tuples

@docs (=>), swap


# Numbers

@docs maxSafeInteger, minSafeInteger, isSafeInteger


# Arithmetics

@docs fmod


# Angle Conversions

@docs inDegrees, inRadians, inTurns

-}


{-| A shorthand for writing 2-tuples. Very commonly used when expressing key/value pairs
in CSS or Json encoders.
-}
(=>) : a -> b -> ( a, b )
(=>) =
    (,)
infixr 8 =>


{-| Swaps the elements in a pair.

    swap ( 1, 2 ) == ( 2, 1 )

-}
swap : ( a, b ) -> ( b, a )
swap ( a, b ) =
    ( b, a )


{-| The maximum _safe_ value for an integer, defined as `2^53 - 1`. Anything
larger than that and behaviour becomes mathematically unsound.

    (maxSafeInteger + 1) == (maxSafeInteger + 2)
        == True

-}
maxSafeInteger : number
maxSafeInteger =
    2 ^ 53 - 1


{-| The minimum _safe_ value for an integer, defined as `-(2^53 - 1)`. Anything
smaller than that, and behaviour becomes mathematically unsound.

    (minSafeInteger - 1) == (minSafeInteger - 2)
        == True

-}
minSafeInteger : number
minSafeInteger =
    -maxSafeInteger


{-| Checks if a given integer is within the safe range, meaning it is between
`-(2^53 - 1)` and `2^53 - 1`.

    isSafeInteger 5 == True
    isSafeInteger maxSafeInteger == True
    isSafeInteger (maxSafeInteger + 1) == False

-}
isSafeInteger : Int -> Bool
isSafeInteger number =
    minSafeInteger <= number && maxSafeInteger >= number


{-| Perform [modular arithmetic](https://en.wikipedia.org/wiki/Modular_arithmetic)
involving floating point numbers.

The sign of the result is the same as the sign of the modulus
(the `m` in `fmod x m`).

    fmod 5 2 == 1
    fmod 5 2.5 == 0
    fmod 4.5 2 == 0.5

    fmod -5 2 == 1
    fmod -4.5 2 == 1.5

    fmod 5 -2 == -1
    fmod 4.5 -2 == -1.5

-}
fmod : Float -> Float -> Float
fmod x m =
    x - m * toFloat (floor (x / m))


degreesPerRadian : Float
degreesPerRadian =
    1 / degrees 1


{-| Convert standard Elm angles (radians) to degrees.

    inDegrees (turns 2) == 720
    inDegrees pi == 180

-}
inDegrees : Float -> Float
inDegrees angle =
    angle * degreesPerRadian


{-| Convert standard Elm angles (radians) to radians.

    inRadians (degrees 90) == pi / 2
    inRadians (turns 1) == 2 * pi

-}
inRadians : Float -> Float
inRadians =
    identity


turnsPerRadian : Float
turnsPerRadian =
    1 / turns 1


{-| Convert standard Elm angles (radians) to turns. One turn is equal to 360°.

    inTurns (degrees 180) == 0.5
    inTurns (3 * pi) = 1.5

-}
inTurns : Float -> Float
inTurns angle =
    angle * turnsPerRadian
