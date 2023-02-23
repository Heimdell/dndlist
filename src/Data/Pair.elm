module Data.Pair exposing (..)

type alias Pair a b = (a, b)

make : a -> b -> Pair a b
make a b = (a, b)

elim : (a -> b -> c) -> Pair a b -> c
elim k (first, second) = k first second

bimap : (a -> c) -> (b -> d) -> Pair a b -> Pair c d
bimap f g = elim <| \a b -> make (f a) (g b)