module Data.List exposing (..)

import List
import Data.Pair as Pair

elim : (a -> c -> c) -> c -> List a -> c
elim = List.foldr

elimWithIndex : (Int -> a -> c -> c) -> c -> List a -> c
elimWithIndex f z = List.indexedMap Pair.make >> elim (uncurry f) z

uncurry : (a -> b -> c) -> (a, b) -> c
uncurry f (a, b) = f a b
