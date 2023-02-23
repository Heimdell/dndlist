module Pair.Subscription exposing (..)

import Pair.Model exposing (Model)
import Pair.Msg exposing (Msg)
import Subscription exposing (Subscription)
import Data.Either exposing (Either(..))

subscribe : Subscription a msgA -> Subscription b msgB -> Subscription (Model a b) (Msg msgA msgB)
subscribe subA subB (first, second) =
  Sub.batch
    [ Sub.map Left  (subA first)
    , Sub.map Right (subB second)
    ]