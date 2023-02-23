module Both.Subscription exposing (..)

import Both.Model exposing (Model)
import Both.Msg exposing (Msg (..))
import Subscription exposing (Subscription)
import Data.Either exposing (Either(..))

subscribe : Subscription a msg -> Subscription b msg -> Subscription (Model a b) (Msg msg)
subscribe subA subB (first, second) =
  [ subA first
  , subB second
  ]
    |> Sub.batch
    |> Sub.map Msg