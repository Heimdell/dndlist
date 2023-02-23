module Either.Subscription exposing (..)

import Either.Model exposing (Model)
import Either.Msg exposing (Msg)
import Subscription exposing (Subscription)
import Data.Either as Either exposing (Either(..))

subscribe : Subscription a msgA -> Subscription b msgB -> Subscription (Model a b) (Msg msgA msgB)
subscribe subA subB = Either.elim
  (Sub.map Left  << subA)
  (Sub.map Right << subB)