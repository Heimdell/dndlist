module List.Model exposing (..)

import Data.List as List

type alias Model a = List a

init : List a -> Model a
init = identity

elim : (a -> c -> c) -> c -> Model a -> c
elim = List.elim

cons : a -> Model a -> Model a
cons a az = a :: az

snoc : Model a -> a -> Model a
snoc az a = a :: az