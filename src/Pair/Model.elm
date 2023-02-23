
module Pair.Model exposing (..)

import Data.Pair as Pair

type alias Model a b = Pair.Pair a b

init : a -> b -> Model a b
init = Pair.make

elim : (a -> b -> c) -> Model a b -> c
elim = Pair.elim