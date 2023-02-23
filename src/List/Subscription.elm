module List.Subscription exposing (..)

import List.Model exposing (Model)
import List.Msg   exposing (Msg(..))
import Subscription exposing (Subscription)
import Data.List as List

subscribe : Subscription a msgA -> Subscription (Model a) (Msg msgA)
subscribe subA = Sub.batch << List.indexedMap (\i -> Sub.map (Index i) << subA)