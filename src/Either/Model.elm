module Either.Model exposing (..)

import Data.Either exposing (Either(..))

type alias Model a b = Either a b

initLeft : a -> Model a b
initLeft = Left

initRight : b -> Model a b
initRight = Right