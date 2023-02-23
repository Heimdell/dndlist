module Data.Either exposing (..)

type Either a b
  = Left  a
  | Right b

elim : (a -> c) -> (b -> c) -> Either a b -> c
elim k l either = case either of
  Left  a -> k a
  Right b -> l b

bimap : (a -> c) -> (b -> d) -> Either a b -> Either c d
bimap f g = elim (Left << f) (Right << g)